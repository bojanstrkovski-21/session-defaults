#!/bin/bash
# Template: push.sh
# Usage: Run from your repo root to pull, add, commit, and push changes.

echo "Checking for newer files online first"
git pull

# Backup everything inside the project folder
git add --all .

echo "####################################"
echo "Write your commit comment!"
echo "####################################"
read input

git commit -m "$input"


# Push to the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Pushing to branch: $current_branch"
git push -u origin "$current_branch"

echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
