# 🧰 Main Taskfile Overview

This section describes the purpose and layout of the main `Taskfile.yaml` used in this project. The Taskfile defines automation tasks to simplify development workflows and ensure consistency across environments.

---

## ⚙️ Purpose of This Taskfile

This Taskfile provides command-line shortcuts for tasks like:

* Bootstrapping a local Kind cluster with Istio
* Deploying the ZTA-enabled demo app using Helm
* Toggling Zero Trust policies on/off
* Building and pushing Docker images
* Fetching authorization tokens for mTLS-authenticated service access
* Serving MkDocs-based documentation locally

It abstracts repetitive shell commands into named tasks you can run with:

```bash
task <task-name>
```

---

## 🧱 Core Sections

### 1. **Setup & Initialization**

Includes tasks for:

* Creating the Kind cluster (`task create-cluster`)
* Labeling namespaces for Istio sidecar injection
* Preparing Docker Buildx builder for multi-platform builds
* Creating necessary namespaces (`zta-demo`)

### 2. **Development Workflow**

Common tasks for:

* Starting the full dev environment with `task dev`
* Automatically deploying Istio and Helm charts
* Port-forwarding to access the app on `localhost:8081`
* Activating and deactivating ZTA (`task activate-zta`, `task deactivate-zta`)

### 3. **Documentation**

Tasks to:

* Serve documentation locally using MkDocs (`task docs`)
* Automatically watch for changes and hot-reload the preview

### 4. **Deployment & Automation**

Tasks automate:

* Building Docker images (`task build-local`, `task build-push`)
* Pushing images to remote registries
* Upgrading app Helm chart (`task upgrade-all`)
* Applying dynamic config changes using `yq`

### 5. **Cleanup & Teardown**

Includes safe commands to:

* Remove Kind cluster and Helm releases (`task cleanup-dev`)
* Delete generated files like `token.txt` and kubeconfigs
* Reset state for fresh Zero Trust experiments

---

## 🧪 Typical Usage Flow

A typical flow using this Taskfile might look like:

* Set up your environment:

  ```bash
  task setup
  ```

* Start development:

  ```bash
  task dev
  ```

* Activate Zero Trust:

  ```bash
  task activate-zta
  ```

* Get a valid token and test curl:

  ```bash
  task get-token
  ```

* Serve documentation:

  ```bash
  task docs
  ```

* Clean up:

  ```bash
  task cleanup-dev
  ```

---

## 📝 Notes

* To list all available tasks:

  ```bash
  task --list-all
  ```

* Variables and flags can be passed to tasks like so:

  ```bash
  task build-local TAG=mytag
  ```

* You can structure task dependencies using `deps:` and reuse shell logic cleanly across environments.

---

## 📝 Tips

| Key            | Description                                                                 |
| -------------- | --------------------------------------------------------------------------- |
| dotenv + env:  | Loads `.env` to inject secrets like Auth0 credentials.                      |
| vars:          | Supports Git-derived tags or CLI overrides for dynamic configuration.       |
| prompt:        | Use confirmation prompts before destructive actions (e.g., uninstall).      |
| preconditions: | Ensure cluster exists before attempting deployment.                         |
| deps:          | Used to serialize setup steps (e.g., `setup` → `create-cluster` → `istio`). |
| internal:      | Tasks like `_deploy` are hidden helpers invoked only by higher-level tasks. |
| platforms:     | Set up Buildx for multi-arch Docker builds if targeting ARM or others.      |
| requires:      | Not used here, but can enforce vars like `REPOSITORY`.                      |
| status:        | Skips setup if the cluster is already running (e.g., using `kubectx`).      |

---

## 🔗 Related Docs

* [GitFlow Taskfile](./2-gitflow-taskfile.md)
* [Getting Started](../../0-quickstart/1-getting-started.md)
* [Architecture Overview](../../1-architecture/0-overview.md)

---

## 📬 Contact

For issues or suggestions related to automation and task structure, open an issue or contact the maintainer at [sean.njela@gmail.com](mailto:sean.njela@gmail.com).

