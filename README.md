## One-Line Setup in Your Project Folder

1. Create and enter your new project folder:

	```sh
	mkdir myproject && cd myproject
	```

2. Run the setup script directly:

	```sh
	curl -sL https://raw.githubusercontent.com/bojanstrko/session-defaults/main/setup.sh | bash
	```

The script will use the current folder name (e.g., myproject) as your project name wherever needed.

3. After setup completes, run the following command to start your session:

	```sh
	start session
	```

---
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


## Quick Start

Clone this repo into your new project folder, name the folder as your project, and run setup:

```sh
git clone <repo-url> <your-project-name> && cd <your-project-name> && bash setup.sh
```

Replace `<repo-url>` with the HTTPS or SSH URL of this repository, and `<your-project-name>` with your desired folder/project name.

### Shortening the Command

- You can use a URL shortener (like bit.ly or git.io) for the repo URL to make the command shorter.
- Or, create a shell alias in your `.bashrc` or `.zshrc` for repeated use:

```sh
alias newproj='git clone <repo-url> "$1" && cd "$1" && bash setup.sh'
```
Then run:
```sh
newproj myproject
```

---
This will clone, set up, and name your project folder automatically.
