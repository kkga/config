---
description: Open a pull request from the current branch with a generated title and summary
agent: build
---

Create a pull request from the current branch:

1. Read the current state:

!`git status --short`
!`git log main..HEAD --oneline`
!`git diff main...HEAD --stat`

2. Decide on a PR title:
   - Match the repo's conventional-commits style (`feat:`, `fix:`, `refactor:`, `docs:`, …)
   - One short sentence, under ~70 chars
   - Imperative voice ("Add X" not "Added X")

3. Check for a repo PR template. Look in this order: `.github/PULL_REQUEST_TEMPLATE.md`, `PULL_REQUEST_TEMPLATE.md`, `docs/PULL_REQUEST_TEMPLATE.md`, and any `.md` file inside `.github/PULL_REQUEST_TEMPLATE/` (if multiple exist there, use the default named `pull_request_template.md`, or ask the user which one). If a template exists:

   - Read it and use it as the PR body base, filling in every section/placeholder from the actual diff (`git diff main...HEAD`).
   - Fill in and check checklist items as appropriate; only remove obviously decorative placeholder text (e.g. `<description>`, "Please describe your changes").
   - Keep all project-specific sections (CHANGELOG links, deployment notes, test checklists).

   If no template exists, use this fallback template:

   ```
   ## Summary
   <1–3 bullets — what changed and why, not how>

   ## Test plan
   - [ ] <verifiable step>
   - [ ] <verifiable step>
   ```

4. Push the branch if it's not yet on the remote, then create the PR:

```bash
git push -u origin HEAD          # only if needed
gh pr create --title "<title>" --body-file /tmp/pr-body.md
rm /tmp/pr-body.md
```

Write the PR body you built in step 3 to `/tmp/pr-body.md` before running `gh pr create` (use `--body-file` to avoid shell-quoting issues with multiline bodies).

If the base branch isn't `main` (e.g. `master`, `develop`), use that instead.

5. Print the resulting PR URL when done.

Extra context (optional, from the user): `$ARGUMENTS`

**Don't** force-push, amend pushed commits, or rebase main into the branch unless explicitly asked.