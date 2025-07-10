
> ⚙️ This project uses a .gitignore for: docker | python | flask | kubernetes | windows | visualstudiocode (via gitignore.io)

## Project structure
```bash
my-app-starter/
├── docker/
│   ├── Dockerfile                # Builds your application image
│   ├── Dockerfile.test           # (Optional) for testing builds
│   └── entrypoint.sh             # Entrypoint for container startup
├── compose/
│   ├── docker-compose.yml        # Local development stack
├── src/                           # Your application code                  
├── k8s/                           # Kubernetes manifests (use other setup template)             
├── .env.example                   # Example environment variables
├── .gitignore                     
└── README.md                      # Project overview & getting-started guide
```

## Taskfile commands

```bash
# Development environment
task compose:build    # 🔨 Rebuild all services if Dockerfile or dependencies changed
task compose:up       # 🚀 Start app stack in background
task dev              # 🛠️  Build and run dev stack (shortcut for the above two)
task compose:logs     # 🔍 View logs in real time
task compose:down     # 🧹 Tear down containers and volumes

# Git Flow workflow (from Taskfile.gitflow.yml)
task init             # ⚙️ Initialize Git Flow for the repository
task feature:start    # 🌿 Start a new feature branch
task release:start    # 🚀 Start a new release
task hotfix:start     # 🔥 Start a hotfix
```

For detailed Git Flow workflow instructions, see [README-gitflow.md](README-gitflow.md).



## 🧠 When to Use Each Task

| Command | Use When... |
| --- | --- |
| task dev | You're starting or restarting the dev environment |
| task compose:logs | You want to tail logs from all services |
| task compose:down | You're done or need a clean reset |
| task compose:build | You've updated the Dockerfile or dependencies |
| task compose:up | Stack is already built, just bring it up again |
| task feature:start | You're starting work on a new feature |
| task release:start | You're preparing a new version release |
