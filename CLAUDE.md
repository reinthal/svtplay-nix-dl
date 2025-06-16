# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Environment

This project uses devenv (Nix-based development environment) for dependency management and development setup.

### Setup Commands
```bash
# Enter the development environment (if using direnv)
direnv allow

# Or manually enter devenv shell
devenv shell

# Install Python dependencies
# Dependencies are automatically installed when entering the shell via devenv
```

### Project Structure

This is a Python project focused on Swedish TV content downloading, utilizing:
- **Python 3.12** with virtual environment management via devenv
- **ffmpeg** for media processing (available in the Nix environment)
- **svtplay-dl** as the core dependency for downloading Swedish TV content

### Development Workflow

The devenv configuration automatically:
- Sets up Python virtual environment with dependencies from requirements.txt
- Provides ffmpeg binary in the environment
- Runs a greeting message on shell entry

### Testing
```bash
# Run environment tests
devenv test
```

The project currently has minimal test configuration that verifies git is available and working.