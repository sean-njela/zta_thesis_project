# 🧱 System Architecture Overview

This section provides a high-level overview of the architecture and design decisions behind the project. It outlines the system's core components, their responsibilities, and how they interact.

Normally applications are secure at the perimeter of the network. This can cause issues when an application is compromised, as the attacker can access the entire network by moving laterally.

This project demonstrates a shift from traditional perimeter-based models to a Zero Trust Architecture (ZTA) using Kubernetes, Istio, and a microservices deployment. Initially, an application is deployed without ZTA, allowing unrestricted cross-service communication. Then, ZTA features are enabled, which blocks unauthorized service calls until a valid token is presented.

![System Diagram without ZTA](../assets/top1.png) 

---

## 📐 Design Philosophy

* Modular and composable: Each component, from the service mesh to application services, is isolated and independently replaceable.
* Secure by default: With ZTA activated, all communication is encrypted, authenticated, and authorized.
* Automation-first: Environment provisioning, cluster setup, and app deployment are fully automated via Taskfile and Helm.
* Portable/local-dev friendly: Runs in a local Kind cluster, simulating real-world distributed infrastructure for testing and experimentation.

---

## 🧩 Core Components

### 1. Infrastructure

* A local Kind cluster (task dev) is used to simulate a production-like Kubernetes environment.
* All deployments (Istio, demo app, policies) are automated and declarative.
* Helm is used to package and manage Kubernetes resources for the ZTA demo app.
* ZTA features can be toggled using Taskfile commands (task activate-zta, task deactivate-zta).

### 2. CI/CD

* While no external CI/CD pipelines were configured, Git-style workflows are facilitated by Taskfile.gitflow.yaml.
* Application images are built and optionally pushed using Docker Buildx.
* Deployment automation mirrors GitOps-like patterns using Helm and manifests, although ArgoCD was not used in this version.

### 3. Secrets & Configuration

* Secrets and feature flags (such as enabling/disabling ZTA components) are managed via values-local.yaml.
* Secure configuration toggling is done using yq, enabling safe and auditable activation of:
* `authn`, `authz`, `gateway`, `svcentry`, `virtualsvc` components in Istio.
* Token-based authentication flows are handled via an external Auth0-compatible provider with credentials set in .env.

---

## 🔀 Architecture Diagram

![System Diagram with ZTA](../assets/top2.png)

This diagram shows the same service mesh and microservices environment, but with ZTA enabled. All inter-service traffic is blocked unless explicitly authorized via mTLS and policy rules. Services must present valid identities and tokens to access restricted endpoints.

---

## 🔄 Data / Control Flow

The following summarizes the lifecycle of the system and how traffic is controlled:

 1. User runs task dev:

    * Kind cluster is created and configured.
    * Istio is installed and namespace is labeled for sidecar injection.
 
 2. Helm chart for zta-demo-app is deployed to the cluster.

 3. Initially, ZTA components (authn/authz) are disabled; inter-service traffic flows unrestricted.

 4. task activate-zta modifies the Helm values to enable Istio ZTA resources.

 5. Unauthorized service requests are now blocked.

 6. A valid token is fetched via task get-token and used in a curl command inside the pod to access protected endpoints.

 7. Logs and metrics are collected using Prometheus, Grafana, and Istio’s built-in observability stack.

---

## 🧭 Related Pages

* [Quickstart: Getting Started](../0-quickstart/1-getting-started.md)
* [Topics / Application Layer](../2-project/0-topic1.md)
* [Taskfile Automation](../2-project/tasks/0-overview.md)

---
