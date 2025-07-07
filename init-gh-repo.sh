#!/bin/bash

# Check for project name and GitHub repo URL
if [ $# -ne 2 ]; then
  echo "Usage: ./setup-git.sh <project-name> <github-repo-url>"
  echo "Example: ./setup-git.sh my-app https://github.com/your-username/my-app.git"
  exit 1
fi

PROJECT_NAME=$1
REPO_URL=$2

# Create project directory and initialize Git
mkdir $PROJECT_NAME
cd $PROJECT_NAME
git init

# Create README and first commit
echo "# $PROJECT_NAME" > README.md
git add .
git commit -m "Initial commit"

# Rename default branch to main
git branch -M main

# Go back to main and push
git checkout main
git remote add origin $REPO_URL
git push --set-upstream origin main

# Create and switch to dev branch
git checkout -b dev
git push --set-upstream $REPO_URL dev

# Print manual next step
echo ""
echo "✅ Project initialized with main and dev branches."
echo "👉 Now go to GitHub and set 'main' as the default branch under Settings → Branches."
