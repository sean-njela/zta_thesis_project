# ❗ Inter-service Call Fails After ZTA Activation (RBAC: access denied)

---

## 🧭 Context

This issue occurs during testing of Zero Trust Architecture enforcement in a local Kubernetes cluster using a Kind-based environment.

* Tool used: `curl` inside a pod (manual test)
* Command run:

  ```bash
  curl zta-demo-app-service:8080/hello
  ```
* Environment: `Kind` cluster bootstrapped via `task dev`, ZTA activated with `task activate-zta`
* Precondition: Helm values toggled to enable `authn`, `authz`, `gateway`, etc.

---

## 🧨 Symptoms

* Curl request from one pod to another fails with:

  ```bash
  RBAC: access denied
  ```

* No service response, Istio blocks traffic based on authorization policies

* No issues observed before enabling ZTA

---

## 📌 Possible Causes

* Istio `AuthorizationPolicy` now enforces strict service identity checks
* No valid JWT token or SPIFFE identity presented in service call
* Sidecar injection is active, but traffic lacks credentials to satisfy ZTA rules

---

## ✅ Resolution (If Available)

✅ Fetch a valid token using:

```bash
task get-token
```

Then retry the request inside the pod with:

```bash
curl zta-demo-app-service:8080/hello -H "Authorization: Bearer $token"
```

This restores access by satisfying the authentication and authorization layers.

---

## 🧪 Workarounds (Optional)

* Temporarily disable ZTA by running:

```bash
task deactivate-zta
```

> Not recommended in production but useful for debugging.

---

## 🔗 External References

* [Istio Authorization Policies](https://istio.io/latest/docs/tasks/security/authorization/)
* [Taskfile.yaml – activate-zta logic](../2-project/tasks/1-main-taskfile.md)

---

## 🧠 Notes

* This issue is **expected** once ZTA is active
* A helpful follow-up task could pre-check token presence or inject it automatically into test pods
* Should be documented clearly in the developer onboarding section

---
