# ❗ Requests Fail Immediately After `activate-zta` or `deactivate-zta`

---

## 🧭 Context

This issue arises when quickly testing service-to-service communication right after toggling Zero Trust settings via:

```bash
task activate-zta
# or
task deactivate-zta
```

* Tool used: `curl` from inside a pod
* Environment: Kind cluster (`task dev`)
* Trigger: Immediate request to `zta-demo-app-service` after ZTA config change

---

## 🧨 Symptoms

* Unexpected failures such as:

  ```bash
  RBAC: access denied
  ```

  or

  ```bash
  curl: (7) Failed to connect to zta-demo-app-service port 8080
  ```

* Pods appear stuck in pending or restarting state temporarily

* Some requests work after retrying a few seconds later

---

## 📌 Possible Causes

* Helm applies new Istio configs (authn/authz/gateway), which trigger:

  * Pod restarts due to sidecar injection updates
  * Configuration propagation delays across Istio components
* Load balancer or DNS cache may reference stale pod/service states

---

## ✅ Resolution (If Available)

✅ Wait a few seconds (5–10s) after running `task activate-zta` or `task deactivate-zta` before testing with `curl`.

✅ Confirm pod readiness:

```bash
kubectl get pods -n zta-demo
```

✅ Use `kubectl wait` (already part of `Taskfile`) to verify rollout:

```bash
kubectl wait --for=condition=ready pod -l app.kubernetes.io/instance=zta-demo-app --timeout=60s
```

---

## 🧪 Workarounds (Optional)

* Add a delay manually before curl tests:

```bash
sleep 10
```

* Add log checks to validate policy syncing before proceeding with testing

---

## 🔗 External References

* [Istio rollout behavior](https://istio.io/latest/docs/ops/deployment/rollout-strategies/)
* [Helm & Istio readiness considerations](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/)

---

## 🧠 Notes

* This behavior is transient but can confuse first-time testers
* Consider adding a note to `task activate-zta` and `task deactivate-zta` output reminding the user to wait
* Can also add a `post-deploy` validation or status check task in future versions

---
