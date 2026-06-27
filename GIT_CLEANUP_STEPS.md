# Git Cleanup: Removing Large Files from History

## Problem
GitHub rejected push due to large file exceeding 100MB limit:
- File: `Terraform/Day-1/ec2-instance-creation/.terraform/providers/registry.terraform.io/hashicorp/aws/6.51.0/darwin_arm64/terraform-provider-aws_v6.51.0_x5`
- Size: 835MB (796.99 MB)

## Solution Steps

### Step 1: Update .gitignore
Add the following lines to `.gitignore` to prevent future commits of large files:

```
Terraform/Day-1/ec2-instance-creation/.terraform/*
*.tfstate
*.tfstate.backup
.terraform.lock.hcl
Terraform/Day-1/ec2-instance-creation/.terraform.lock.hcl
```

### Step 2: Stage and Commit Changes
```bash
git add .
git commit -m "Add .gitignore and update Terraform files"
```

### Step 3: Rewrite Git History
Remove the `.terraform` directory (containing large provider files) from all commits:

```bash
git filter-branch --tree-filter 'rm -rf Terraform/Day-1/ec2-instance-creation/.terraform' --prune-empty HEAD
```

**What this does:**
- `filter-branch` rewrites all commits in the branch
- `--tree-filter 'rm -rf ...'` removes the `.terraform` directory from each commit
- `--prune-empty` removes empty commits
- `HEAD` applies to current branch

### Step 4: Force Push to Remote
Replace the remote history with your cleaned local version:

```bash
git push --force-with-lease origin main
```

**Why `--force-with-lease`:**
- Safely overwrites remote branch
- Safer than `--force` on shared repos
- Prevents accidentally overwriting others' work

## Result
✅ Push succeeded with cleaned history
✅ Large `.terraform` files removed from git history
✅ Future commits excluded by updated `.gitignore`

## Key Takeaways
1. `.gitignore` prevents NEW commits of large files
2. `git filter-branch` removes ALREADY-COMMITTED large files
3. `--force-with-lease` safely rewrites remote history
4. Always add `node_modules/`, `.terraform/`, `venv/`, `dist/` to `.gitignore`

Here are the git commands executed to investigate and verify the files:
# 1. Check what Terraform files were already tracked in git
git ls-files | grep terraform
# Result: Showed terraform.tfstate.backup and .terraform.lock.hcl were tracked

# 2. Check current git status
git status
# Result: Showed pending changes and commits ahead of remote

# 3. View recent commit history
git log --oneline -6
# Result: Displayed last 6 commits to identify which one had the large files

# 4. Inspect specific commit to see what files it contained
git show d86f831 --stat | head -30
# Result: Confirmed the 835MB terraform-provider-aws_v6.51.0_x5 binary was in that commit