#!/bin/bash

# Check input
if [ $# -ne 1 ]; then
  echo "Usage: ./init-gh-repo.sh <project-name>"
  echo "Example: ./init-gh-repo.sh my-app"
  exit 1
fi

PROJECT_NAME=$1

# Create directory and initialize repo
mkdir $PROJECT_NAME
cd $PROJECT_NAME
git init

# Create initial README and commit
echo "# $PROJECT_NAME" > README.md
git add .
git commit -m "Initial commit"

# Rename default branch to main
git branch -M main

# Create repo on GitHub using CLI
gh repo create $PROJECT_NAME --public --source=. --remote=origin --push

# Create and push dev branch
git checkout -b dev
git push -u origin dev

# Go back to main and push
git checkout main
git push -u origin main

# Set main as default branch on GitHub
gh repo edit --default-branch main

# Done
echo ""
echo "✅ Repo '$PROJECT_NAME' set up with 'main' and 'dev' branches."
echo "👉 'main' is set as default branch on GitHub."
