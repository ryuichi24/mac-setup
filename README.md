<h1 align="center">Mac Setup</h1>

# Mac Setup

A comprehensive setup script for configuring a new macOS system with development tools, applications, and settings.

## One line Get Started

Make sure you change the value of each env variable below in the script:

- GIT_USER_NAME
- GIT_USER_EMAIL

```bash
git clone https://github.com/ryuichi24/mac-setup.git && cd mac-setup && echo "GIT_USER_NAME=example\nGIT_USER_EMAIL=user@example.com" > .env && ./setup.sh --skip=mac,brew,shell,tap,cli,gui,mas,vim,vs,git -R
```

## Get Started

1. Clone the repository:

```bash
git clone https://github.com/ryuichi24/mac-setup.git
cd mac-setup
```

2. Create `.env` file with your Git credentials:

```bash
echo "GIT_USER_NAME=your_name
GIT_USER_EMAIL=your_email@example.com" > .env
```

3. Run the setup script:

```bash
./setup.sh --skip=mac,brew,shell,tap,cli,gui,mas,vim,vs,git -R
```

## Configuration Options

Use the `--skip` flag to skip specific setup steps:

```bash
./setup.sh --skip=mac,brew,shell,tap,cli,gui,mas,vim,vs,git
```

You can also use the `-R` flag to control whether the computer restarts after the setup is complete:

```bash
./setup.sh -R
```

Available skip options:

- `mac`: MacOS system preferences
- `brew`: Homebrew installation
- `shell`: Shell configuration
- `tap`: Homebrew tap registration
- `cli`: CLI tools installation
- `gui`: GUI applications installation
- `mas`: Mac App Store applications
- `vim`: Neovim configuration
- `vs`: VSCode configuration
- `git`: Git configuration

## Project Structure

```
.
├── files/           # Configuration files
│   ├── bash/        # Shell configurations
│   ├── git/         # Git templates
│   ├── nvim/        # Neovim setup
│   └── vscode/      # VSCode settings
├── modules/         # Setup modules
├── utils/          # Helper scripts
├── setup.sh        # Main setup script
└── .env.example    # Environment template
```
