# 🚀 Zero Trust Microservices Demo

**A hands-on implementation of Zero Trust Architecture using Kubernetes, Istio, and Helm.**

Welcome to the official documentation site for **Zero Trust Microservices Demo**! This site provides full guides on setup, architecture, usage, performance analysis, and security enforcement using Zero Trust principles.

---

## 🧭 Quick Overview

* 🔧 This project simulates a microservices deployment inside a local Kubernetes cluster with Zero Trust enforcement using Istio.
* 🎯 It demonstrates how service-to-service communication is secured via identity, mTLS, and fine-grained RBAC policies.
* 🔗 Live demo not hosted, but reproducible fully in a local environment using `Kind` and `task dev`.

---

## ⚡ Getting Started

Visit the **[Quick Start](0-quickstart/1-getting-started.md)** page in the docs for step-by-step instructions to bootstrap your cluster, deploy services, and simulate traffic flow with and without Zero Trust.

---

## 📐 Architecture & Components

Dive into how the project is architected:

* 🔄 Deployment is Helm-based using a modular chart (`zta-demo-app`)
* 🔒 Security is handled by Istio + SPIRE for workload identity
* 🧱 Infra is bootstrapped using `Taskfile.yaml` with zero manual steps

For full diagrams, workflows, and explanations, visit **[Architecture](1-architecture/0-overview.md)**.

---

## 📚 Documentation Roadmap

* **Quick Start** → Setup, prerequisites, and usage
* **Architecture** → System overview, component breakdown
* **Features / Topics** → ZTA toggling, service access flows, token authentication
* **About Me** → Author info and project background

Use the sidebar for easy navigation.

---

## 🧪 Examples & Use Cases

Key examples this project demonstrates:

* 🧪 Insecure service communication in a typical mesh setup
* 🔐 Enforcement of Zero Trust via Istio AuthorizationPolicy and PeerAuthentication
* 📉 Latency benchmarking before vs after ZTA activation
* 🛡️ Realistic threat modeling: lateral movement blocked without identity

---

## 🔗 Useful Links

* 🔧 [Getting Started](0-quickstart/1-getting-started.md)
* 📊 [System Architecture](1-architecture/0-overview.md)
* 📝 [Dive into Features](2-project/0-topic1.md)
* 🧑‍💼 [About Me](4-about/0-about.md)

---

## 💡 Contributions & Feedback

Contributions welcome! Please open GitHub issues or PRs.
License: [MIT](https://github.com/your-username/your-repo/blob/main/LICENSE) • Maintained by **Sean Njela**

---
