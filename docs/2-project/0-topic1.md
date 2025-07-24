# 🚀 Implementation

We start by deploying a simple Flask application into a Kubernetes cluster without Zero Trust controls enabled. This allows us to establish a security baseline, observe open service-to-service communication, and then incrementally enforce Zero Trust Architecture (ZTA) for comparison.

---

## 🔧 Step-by-Step Breakdown

### 🟢 1. Initial Deployment (ZTA Disabled)

* Run the following to provision the environment:

```bash
task dev
```

This command automates:

* Kind cluster creation

* Namespace and image setup

* Helm-based app deployment (`zta-demo-app`)

* Istio installation (without ZTA policies activated)

* The following values in `values-local.yaml` are disabled by default:

```yaml
authn:
  enabled: false
authz:
  enabled: false
gateway:
  enabled: false
virtualsvc:
  enabled: false
svcentry:
  enabled: false
```

> ✅ This results in **unrestricted** cross-service communication inside the mesh.

* Inside a pod:

```bash
curl zta-demo-app-service:8080/hello
```

Returns:

```text
Hello I am reachable! from zta-demo-app-<pod-name>
```

This is expected because there is **no authentication or authorization** in place. This insecure state means any compromised pod can access internal services freely.

---

<div align="center">
  <h4>Before Zero Trust Architecture</h4>
</div>

![top1](../assets/top1.png)
![screenshot1](../assets/screenshot1.png)

---

### 🔒 2. Enabling Zero Trust

To activate Zero Trust components, run:

```bash
task activate-zta
```

This uses `yq` to toggle the following values in `values-local.yaml`:

```yaml
authn:
  enabled: true
authz:
  enabled: true
gateway:
  enabled: true
virtualsvc:
  enabled: true
svcentry:
  enabled: true
```

Then it triggers a Helm upgrade and waits for the pods to be ready.

* Now, try the same `curl` command again from another pod:

```bash
curl zta-demo-app-service:8080/hello
```

Returns:

```text
RBAC: access denied
```

Zero Trust policies enforced via Istio now block all traffic that is not explicitly allowed.

---

<div align="center">
  <h4>After Zero Trust Architecture</h4>
</div>

![top2](../assets/top2.png)
![screenshot2](../assets/screenshot2.png)

---

### 🔐 3. Access with Token

To access the service securely:

* Run:

```bash
task get-token
```

This retrieves a JWT access token using the configured Auth0 credentials and writes it to `token.txt`.

* Then use it inside the pod:

```bash
curl zta-demo-app-service:8080/hello -H "Authorization: Bearer $token"
```

This returns:

```text
Hello I am reachable! from zta-demo-app-<pod-name>
```

The request is now authorized, authenticated, and securely handled via mTLS and policy rules.

---

## ⚖️ Performance Comparison

We use `curl` with the `-w` flag to compare the latency introduced by ZTA.

### ⏱ Before ZTA

```bash
curl -o /dev/null -s -w "Total: %{time_total}s\n" zta-demo-app-service:8080/hello
```

Output:

```text
Total: 0.005481s
```

---

### ⏱ After ZTA (Token Authenticated)

```bash
curl -o /dev/null -s -w "Total: %{time_total}s\n" zta-demo-app-service:8080/hello -H "Authorization: Bearer $token"
```

Output:

```text
Total: 0.005916s
```

---
<div align="center">
  <h4>Before Zero Trust Architecture</h4>
</div>

![screenshot3](../assets/screenshot3.png)

<div align="center">
  <h4>After Zero Trust Architecture</h4>
</div>

![screenshot4](../assets/screenshot4.png)


---

## 🧠 Performance Perspective

The added latency of \~435 microseconds (µs) is negligible:

| Comparison           | Value             |
| -------------------- | ----------------- |
| Human reaction time  | \~0.2–0.3 seconds |
| One frame at 60 FPS  | \~0.0167 seconds  |
| Latency added by ZTA | \~0.0004 seconds  |

> 🔐 In return for this near-zero impact, we gain end-to-end service authentication, traffic encryption, and granular access control.

