---
description: Create a new git branch (optionally from a base branch) and switch to it
agent: build
---

Create a new git branch from the user's input and switch to it:

1. Read the current state:

!`git status --short`
!`git branch --show-current`

2. Determine the branch name:
   - Use `$ARGUMENTS` as-is if it looks like a valid branch name
   - Otherwise, if the user described a feature/fix, convert it to a kebab-case branch name (e.g. "add dark mode" -> `add-dark-mode`)
   - Optionally prefix with a type like `feat/` or `fix/` if that matches the repo's convention (check `git branch -a` for existing patterns)

3. If the user mentioned a base branch (e.g. "from main"), make sure you're up to date with it first:

```bash
git fetch origin
git checkout <base>      # e.g. main
git pull origin <base>
```

4. Create and switch to the new branch:

```bash
git checkout -b <branch-name>
```

5. Print the branch name when done. **Don't** commit, push, or make any other changes.

Extra context (optional, from the user): `$ARGUMENTS`

**Don't** switch branches, commit, push, or create the branch if it already exists — instead tell the user and suggest an alternative name.
