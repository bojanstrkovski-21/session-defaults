# Session-defaults

This repo provides templates and scripts for initializing new projects with best practices, Copilot agent instructions, and git automation.

## Usage

- Use `setup.sh` to bootstrap a new project. It will copy all templates, prompt for project name, and set up git.
- After git init, you will be prompted to set git credentials and run the credentials script if desired.
- Scripts `set-git-cred.sh` and `push.sh` are copied to each new project and made executable automatically.

## Scripts

- `set-git-cred.sh`: Sets up git credentials and remote for your project. You will be prompted for the project name and the script will be updated accordingly.
- `push.sh`: Pulls, adds, commits, and pushes changes to the correct branch.

## Customization

- You can edit the templates in `templates/` to fit your workflow.
- The setup process ensures all scripts are executable and persist this setting via git config.
