## 📁 Repository layout (top‑level)

```
├── charts/              # Reusable Helm chart(s)
├── dev/                 # Tilt + local values for k3s
├── Taskfile.yml         # One‑liner commands (`task -l`)
└── README.md            # ← you are here
```

---

## 🖥️  Quick start for contributors

```bash
# 1. Clone & enter reproducible shell (installs CLIs via Nix)
$ devbox shell

# 2. Spin up local k3s cluster + live‑reload dev loop
$ task dev:up  # creates k3d cluster & opens Tilt dashboard

# 3. Browse app at http://localhost:8080 (auto reload on save)
```

*To clean up, run `task dev:down`.*

---

## 🛠️  Adding a new micro‑service

1. Duplicate `values-examples/nodejs.yaml` (or Django/Golang…) into `dev/values/`.
2. Add a release entry in `clusters/staging/helmfile.yaml` → point to `charts/webapp-template`.
3. Commit & push — CI will bump image tag automatically.
4. Promote to prod via the same GitOps PR flow.

---

## 🆘  Troubleshooting

| Problem                    | Where to look                                                   |
| -------------------------- | --------------------------------------------------------------- |
| **Pods CrashLoop**         | `kubectl logs`, check ExternalSecrets values (Infisical)        |
| **Ingress 404**            | `kubectl describe ingress <name>` or Traefik dashboard          |
| **HPA not scaling in dev** | Autoscaling disabled in `dev/values-local.yaml`                 |
| **Terraform failure**      | GitHub Actions ➜ Terraform‑Infra logs / or local `task tf:plan` |

Detailed runbooks live under **`docs/runbooks/`**.
