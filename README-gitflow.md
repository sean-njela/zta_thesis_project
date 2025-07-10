# ⚙️ Git Flow with Taskfile (Zero-Setup Workflow)

This guide assumes **zero prior knowledge** and helps any developer get started instantly. Our project uses a standardized Git Flow workflow implemented through Taskfile.gitflow.yml to ensure consistent branching and versioning.

## 🧠 Rule of Thumb

| Situation                 | When to `task init`                                 |
| ------------------------- | --------------------------------------------------- |
| 🆕 Brand new repo         | After pushing your first `main` commit              |
| ⬇️ Cloned existing repo   | Immediately after cloning, before any work          |
| Only `main` branch exists | Run `task init` to create `develop`, configure flow |

## 🏗 Initial Setup (First-Time Only)

Only the **first person** to configure the repo does this:

```bash
# 1. Push your initial commit to GitHub
git remote add origin git@github.com:your-user/your-repo.git
git push -u origin main

# 2. Run the Git Flow setup task (creates 'develop' and config)
task init
```

✅ This creates and pushes `develop`, and configures Git Flow to use `main` & `develop`.

---

## 👩‍💻 Daily Workflow (All Developers)

### 🕘 Start of Day

```bash
# Pull latest 'develop' and safely merge it into your current branch
task sync

# Start a new feature (based off 'develop')
task feature:start name=your-feature-name
```

### 🔁 During the Day

```bash
# Work as usual
git add .
git commit -m "feat: implement something important"

# Push your branch to GitHub
task feature:push
```

### 🌙 End of Day (Optional)

```bash
# Optional: sync with latest 'develop' before ending your day
task sync
task feature:push
```

---

## ✅ Finishing a Feature

After your PR is merged (e.g. on GitHub via squash merge into `develop`):

```bash
task feature:clean name=your-feature-name
```

---

## 🚀 Releasing a Version (Lead Dev or Maintainer)

```bash
# Start a release branch from 'develop'
task release:start version=1.2.0

# Final edits or bugfixes...
# Commit and push if needed

# Merge release to 'main' and 'develop', tag version
task release:finish version=1.2.0
```

🧪 Your CI/CD pipeline should trigger automatically on tags like `v1.2.0`.

---

## 🔥 Emergency Fixes (Hotfixes)

```bash
# Start hotfix from 'main'
task hotfix:start name=critical-issue

# Fix the bug, commit

# Finish and tag hotfix (merges into both 'main' and 'develop')
task hotfix:finish version=1.2.1
```

Hotfixes are critical patches that need to be applied directly to production. When finished, the hotfix is merged into both `main` and `develop` branches to ensure the fix is included in future releases.

---

## ✅ GitHub Setup Recommendations

| Type          | Default PR Target         |
| ------------- | ------------------------- |
| Feature PRs   | `develop`                 |
| Release PRs   | `main`                    |
| Hotfix PRs    | `main` & `develop`        |
| CI/CD deploys | Trigger on tags like `v*` |

---

## 🔄 Summary Flow Diagram

```text
main ← release/x.y.z ← develop ← feature/*
           ↑                ↑
         hotfix         daily sync
```

---

## 📎 Optional Extras

* ✅ `task clean:branches` — deletes merged local feature/release/hotfix branches
* ✅ `task release:repair` — assists with resolving failed merges
* ✅ `task release:verify` — ensures safe state before merging releases

## ⚠️ Important Notes

* After completing a release, it's normal for `develop` to be 1 commit ahead of `main`. This is the back-merge commit created by git flow and should not be manually merged into `main`.
* All tasks are defined in `Taskfile.gitflow.yml` and can be customized if needed.
* When finishing a release or hotfix, git flow will prompt for commit messages for the two merge operations.

## 🔄 Reset Git Flow Configuration

If you need to reset or remove git flow configuration:

```bash
git config --remove-section gitflow || { git config --remove-section gitflow.branch && git config --remove-section gitflow.prefix; }
```

