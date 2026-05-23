#!/bin/bash
set -euo pipefail

DEFAULTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "${1:-}" ]]; then
    echo "Usage: bash ~/Projects/session-defaults/setup.sh <ProjectName>"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_DIR="$(pwd)/$PROJECT_NAME"

if [[ -d "$PROJECT_DIR" ]]; then
    echo "Folder '$PROJECT_NAME' already exists."
    exit 1
fi

echo "Creating project: $PROJECT_NAME"
mkdir -p "$PROJECT_DIR/.github/prompts"

cp -r "$DEFAULTS_DIR/prompts/."  "$PROJECT_DIR/.github/prompts/"
cp -r "$DEFAULTS_DIR/memory"     "$PROJECT_DIR/"
cp    "$DEFAULTS_DIR/templates/copilot-instructions.md" "$PROJECT_DIR/.github/"
cp    "$DEFAULTS_DIR/templates/push.sh"                 "$PROJECT_DIR/"
cp    "$DEFAULTS_DIR/templates/set-git-cred.sh"         "$PROJECT_DIR/"
cp    "$DEFAULTS_DIR/sync.sh"                           "$PROJECT_DIR/"
sed   "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$DEFAULTS_DIR/templates/PROJECT.md" > "$PROJECT_DIR/PROJECT.md"

sed -i "s|project=your-project-name|project=$PROJECT_NAME|" "$PROJECT_DIR/set-git-cred.sh"
chmod +x "$PROJECT_DIR/set-git-cred.sh" "$PROJECT_DIR/push.sh" "$PROJECT_DIR/sync.sh"

echo ""
echo "Done. Project created at: $PROJECT_DIR"
echo "cd $PROJECT_NAME and say 'start session'."


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
