---
name: deploying-to-github
description: Automates and standardizes the version control workflow for the project. Use when the user wants to save changes, push to GitHub, or perform git operations.
---

# Deploying to GitHub

This skill provides a standardized workflow for pushing local changes to the GitHub repository, ensuring consistency in commit messages and process.

## When to use this skill
- When you have finished a task and need to save changes remotely.
- When the user mentions "push to github", "save changes", or "subir cambios".
- To verify the current status of the repository before committing.

## Workflow

### 1. Verification
Check what files have changed to ensure no unwanted files are included.
```bash
git status
```

### 2. Staging
Add changes to the staging area.
```bash
git add .
```

### 3. Committing
Create a descriptive commit message based on the work done.
```bash
git commit -m "feat: [brief description of changes]"
```

### 4. Pushing
Push the changes to the remote repository.
```bash
git push
```

## Best Practices
- **Descriptive Messages**: Use prefixes like `feat:`, `fix:`, `refactor:`, or `docs:` in commit messages.
- **Atomic Commits**: Group related changes together in a single commit.
- **Check Paths**: Ensure the portable node path is correctly set if running git hooks (though usually not necessary for standard git).

## Troubleshooting
- If `git push` fails, check if there are remote changes to pull: `git pull --rebase`.
- Ensure you have the necessary permissions for the repository.
- Verify that the portable Node.js path is in your environment if you have pre-commit hooks that require node.
