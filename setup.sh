#!/bin/bash
# Session-defaults bootstrap script
# Run from the root of a NEW project folder:
#   curl -sL https://raw.githubusercontent.com/bojanstrkovski-21/session-defaults/main/setup.sh | bash

set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/bojanstrkovski-21/session-defaults/main"
PROJECT_NAME=$(basename "$PWD")

echo "Setting up session defaults for: $PROJECT_NAME"
echo ""

mkdir -p .github/prompts

curl -sL "$BASE_URL/prompts/session-start.prompt.md" -o .github/prompts/session-start.prompt.md
curl -sL "$BASE_URL/prompts/session-end.prompt.md"   -o .github/prompts/session-end.prompt.md
curl -sL "$BASE_URL/templates/copilot-instructions.md" -o .github/copilot-instructions.md
curl -sL "$BASE_URL/templates/PROJECT.md" | sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" > PROJECT.md
curl -sL "$BASE_URL/templates/set-git-cred.sh" -o set-git-cred.sh
curl -sL "$BASE_URL/templates/push.sh" -o push.sh

read -p "Set project name '$PROJECT_NAME' in set-git-cred.sh? (y/n): " setname
if [[ "$setname" =~ ^[Yy](es)?$ ]]; then
    sed -i "s|project=your-project-name|project=$PROJECT_NAME|" ./set-git-cred.sh
    echo "Project name set."
else
    echo "Edit set-git-cred.sh manually before use."
fi

chmod +x ./set-git-cred.sh ./push.sh
git config --add core.fileMode true 2>/dev/null || true

echo ""
echo "Done. Files created:"
echo "  .github/prompts/session-start.prompt.md"
echo "  .github/prompts/session-end.prompt.md"
echo "  .github/copilot-instructions.md"
echo "  PROJECT.md"
echo "  set-git-cred.sh"
echo "  push.sh"
echo ""

if [ -d .git ]; then
    read -p "Git initialized. Run set-git-cred.sh now? (y/n): " runcred
    if [[ "$runcred" =~ ^[Yy](es)?$ ]]; then
        bash ./set-git-cred.sh
    fi
fi

echo "Next: open Claude Code and say 'start session'."

## Session-defaults bootstrap script
## Run this from the root of a NEW project folder to set up session defaults.
##
## Usage:
##   cd /path/to/your/new-project
##   bash /path/to/Session-defaults/setup.sh
#
#set -euo pipefail
#
##TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
#PROJECT_NAME=$(basename "$PWD")
#
#echo "Setting up session defaults for: $PROJECT_NAME"
#echo ""
#
## Create required directories
#mkdir -p .github/prompts
#
## Copy prompt files
#cp "$TEMPLATE_DIR/prompts/session-start.prompt.md" .github/prompts/
#cp "$TEMPLATE_DIR/prompts/session-end.prompt.md"   .github/prompts/
#
## Copy copilot instructions
#cp "$TEMPLATE_DIR/templates/copilot-instructions.md" .github/copilot-instructions.md
#
## Create PROJECT.md from template, substituting project name
#sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TEMPLATE_DIR/templates/PROJECT.md" > PROJECT.md
#
#
## Copy git helper scripts
#cp "$TEMPLATE_DIR/templates/set-git-cred.sh" ./set-git-cred.sh
#cp "$TEMPLATE_DIR/templates/push.sh" ./push.sh
#
## Prompt for project name to update set-git-cred.sh
#read -p "Do you want to set the project name in set-git-cred.sh to '$PROJECT_NAME'? (y/n): " setname
#if [[ "$setname" =~ ^[Yy](es)?$ ]]; then
	#sed -i "s|project=your-project-name|project=$PROJECT_NAME|" ./set-git-cred.sh
	#echo "Project name set in set-git-cred.sh."
#else
	#echo "Project name not set. Edit set-git-cred.sh manually before use."
#fi
#
## Make scripts executable
#chmod +x ./set-git-cred.sh ./push.sh
#
## Persist executable bit in git config for future clones
#git config --add core.fileMode true || true
#
#echo "Done. Files created:"
#echo "  .github/prompts/session-start.prompt.md"
#echo "  .github/prompts/session-end.prompt.md"
#echo "  .github/copilot-instructions.md"
#echo "  PROJECT.md"
#echo "  set-git-cred.sh"
#echo "  push.sh"
#echo ""
#
## Optionally run set-git-cred.sh after git init
#if [ -d .git ]; then
	#read -p "Git is initialized. Run set-git-cred.sh to set credentials now? (y/n): " runcred
	#if [[ "$runcred" =~ ^[Yy](es)?$ ]]; then
		#./set-git-cred.sh
	#else
		#echo "You can run ./set-git-cred.sh later to set credentials."
	#fi
#fi
#
#echo "Next: open VS Code, open Copilot chat, and say 'start session'."
