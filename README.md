<div align="center">

  <!-- Optional logo -->
  <div style="display: flex; gap: 10px;">
    <img src="assets/top1.png" alt="top1" style="width: 48%;" />
    <img src="assets/top2.png" alt="top2" style="width: 48%;" />
  </div>

  <h1>📘 Zero Trust in Microservices Architecture Demo</h1>

  <p>
    This is a proof of concept of Zero Trust in Microservices Architecture using Kubernetes, Istio, and Auth0.
  </p>

  <p>
    <a href="https://github.com/sean-njela/zta_thesis_project/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/sean-njela/zta_thesis_project" alt="contributors" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/last-commit/sean-njela/zta_thesis_project" alt="last update" />
  </a>
  <a href="https://github.com/sean-njela/zta_thesis_project/network/members">
    <img src="https://img.shields.io/github/forks/sean-njela/zta_thesis_project" alt="forks" />
  </a>
  <a href="https://github.com/sean-njela/zta_thesis_project/stargazers">
    <img src="https://img.shields.io/github/stars/sean-njela/zta_thesis_project" alt="stars" />
  </a>
  <a href="https://github.com/sean-njela/zta_thesis_project/issues/">
    <img src="https://img.shields.io/github/issues/sean-njela/zta_thesis_project" alt="open issues" />
  </a>
  <a href="https://github.com/sean-njela/zta_thesis_project/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/sean-njela/zta_thesis_project.svg" alt="license" />
  </a>
  </p>

</div>

## 📚 Table of Contents

  * [Screenshots](#screenshots)
  * [Tech Stack](#tech-stack)
  * [Prerequisites](#prerequisites)
  * [Quick Start](#quick-start)
  * [Documentation](#documentation)
  * [Features](#features)
  * [Tasks (automation)](#tasks)
  * [Roadmap](#roadmap)
  * [License](#license)
  * [Contributing](#contributing)
  * [Contact](#contact)

---

## 📸 Screenshots

<div align="center"> 
  <h4>Before Zero Trust Architecture</h4>
  <img src="assets/screenshot1.png" alt="screenshot1" width="900" />
  <h4>After Zero Trust Architecture</h4>
  <img src="assets/screenshot2.png" alt="screenshot2" width="900" />
</div>

> Now Comparing the difference in latency between the two approaches

<div align="center"> 
  <h4>Before Zero Trust Architecture</h4>
  <img src="assets/screenshot3.png" alt="screenshot1" width="900" />
  <h4>After Zero Trust Architecture</h4>
  <img src="assets/screenshot4.png" alt="screenshot2" width="900" />
</div>


As demonstrated, the Zero Trust in Microservices Architecture provides a latency *435 µs*.

🧠 Some Perspective:
* Human reaction time: ~0.2 to 0.3 seconds
* One frame at 60fps: ~0.0167 seconds (16,700 microseconds)
* We added latency: ~0.0004 seconds

This is well below any threshold that would cause concern in 99% of systems.

---

## 🛠️ Tech Stack

> List of tools used in the project

![Devbox](https://img.shields.io/badge/Devbox-0.15.0-green)
![Taskfile](https://img.shields.io/badge/Taskfile-3.44.0-green)
![gitflow](https://img.shields.io/badge/gitflow-1.12-green)
![python@3.12](https://img.shields.io/badge/python@3.12-green)
![flask@3.1](https://img.shields.io/badge/flask@3.1-green)
![go-task@3.44](https://img.shields.io/badge/go-task@3.44-green)
![httpie@3.2](https://img.shields.io/badge/httpie@3.2-green)
![kubectl@1.33](https://img.shields.io/badge/kubectl@1.33-green)
![kind@0.29](https://img.shields.io/badge/kind@0.29-green)
![yamllint@1.37](https://img.shields.io/badge/yamllint@1.37-green)
![helm@3.18](https://img.shields.io/badge/helm@3.18-green)
![kubectx@0.9](https://img.shields.io/badge/kubectx@0.9-green)
![poetry@2.1](https://img.shields.io/badge/poetry@2.1-green)
![k9s@0.50](https://img.shields.io/badge/k9s@0.50-green)
![istioctl@1.22](https://img.shields.io/badge/istioctl@1.22-green)

---

## 📋 Prerequisites

> This project uses [Devbox](https://www.jetify.com/devbox/) to manage the development environment. Devbox provides a consistent, isolated environment with all the necessary CLI tools pre-installed.

0. **Install Docker**

   - Follow the [installation instructions](https://docs.docker.com/get-docker/) for your operating system.

> The rest of the tools are already installed in the devbox environment

1. **Install Devbox**

   - Follow the [installation instructions](https://www.jetify.com/devbox/docs/installing_devbox/) for your operating system.

2. **Clone the Repository**

   ```bash
   git clone https://github.com/sean-njela/zta_thesis_project.git
   cd zta_thesis_project
   ```

3. **Start the Devbox Environment and poetry environment**

   ```bash
   devbox shell # Start the devbox environment (this will also start the poetry environment)
   poetry install # Install dependencies
   poetry env activate # use the output to activate the poetry environment ( ONLY IF DEVBOX DOES NOT ACTIVATE THE ENVIRONMENT)
   ```
> Note - The first time you run `devbox shell`, it will take a few minutes to install the necessary tools. But after that it will be much faster.

---

## 🚀 Quick Start

```bash
# this one command will run all commands necessary to setup the environment. yes, really.
task dev
```

---
## 📚 Documentation

For full documentation, setup instructions, and architecture details, visit the [docs](docs/0-index.md) or run:

```bash
task docs
```

Docs available at: [http://127.0.0.1:8000/zta_thesis_project/](http://127.0.0.1:8000/zta_thesis_project/)

---

## 📂 Features

* Demo pyhton flask application with `hello`, `slow` and `error` endpoints.
* Simulation of the security vulnerabilities of the application when it is not protected by Zero Trust Architecture.
* Demonstration of the applications' resilience when it is protected by Zero Trust Architecture using Kubernetes, Istio, and Auth0.

---

## ✅ Tasks (Automation)

> This project is designed for a simple, one-command setup. All necessary actions are orchestrated through `Taskfile.yaml`.

```bash
task setup # setup the environment
task dev # automated local provisioning
task cleanup-dev # cleanup the dev environment
```

### Git Workflow with Git Flow

The `Taskfile.gitflow.yaml` provides a structured Git workflow using Git Flow. This helps in managing features, releases, and hotfixes in a standardized way. To run these tasks just its the same as running any other task. Using gitflow is optional.

```bash
task init                 # Initialize Git Flow with 'main', gh-pages and 'develop'
task sync                 # Sync current branch with latest 'develop' and handle main updates
task release:finish       # Finishes and publishes a release (merges, tags, pushes). e.g task release:finish version="1.2.0"
```

To see all tasks:

```bash
task --list-all
```

If you do not want the gitflow tasks, you can remove the `Taskfile.gitflow.yaml` file and unlink it from the `Taskfile.yaml` file (remove the `includes` section). If you cannot find the section use CTRL + F to search for Taskfile.yaml.

---

## 📝 NOTES

> Important notes to remember whilst using the project

This project is a proof of concept. It has not been tested in a production environment, yet.

---

## 📚 Troubleshooting

For comprehensive troubleshooting, refer to the [Troubleshooting](docs/3-troubleshooting/overview.md) section. Or open the github pages [here](https://sean-njela.github.io/docs/3-troubleshooting/overview.md) and use the search bar to search your issue (USE INDIVIDUAL KEYWORDS NOT THE ISSUE NAME). 

---

## 🛣️ Roadmap

* [x] Create a python flask application with `hello`, `slow` and `error` endpoints.
* [x] Create a k8s cluster using kind.
* [x] Create a namespace for the helm deployment.
* [x] Create a helm chart for the flask application.
* [x] Create a k8s deployment for the flask application.
* [x] Create a k8s service for the flask application.
* [x] Create tasks to automate non secure deployment of the flask application.
* [x] Create tasks to automate secure deployment of the flask application.
* [x] Create tasks to automate cleanup of the flask application.
* [ ] Create comprehensive documentation for the project.

---

## 🤝 Contributing

<a href="https://github.com/sean-njela/zta_thesis_project/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=sean-njela/zta_thesis_project" />
</a>

> Contributions welcome! Open an issue or submit a PR.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more info.

---

## 📬 Contact

Sean Njela – [@linkedin](https://linkedin.com/in/sean-njela) – [@twitter/x](https://x.com/devopssean) – [email](mailto:seannjela@gmail.com)

Project Link: [https://github.com/sean-njela/zta_thesis_project](https://github.com/sean-njela/zta_thesis_project)

About Me - [About Me](docs/4-about/about.md)

---