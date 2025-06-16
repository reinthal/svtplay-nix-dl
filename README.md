# SVTPlay Nix Downloader

A Nix-based development environment for using svtplay-dl to download videos from Swedish and Nordic streaming services.

## Setup

This project uses [devenv](https://devenv.sh/) for development environment management.

### Prerequisites
- [Nix](https://nixos.org/download.html) package manager
- [devenv](https://devenv.sh/getting-started/) installed

### Getting Started

1. Clone this repository
2. Enter the development environment:
   ```bash
   devenv shell
   ```
   
   Or if using direnv:
   ```bash
   direnv allow
   ```

## Usage

### Basic Download
Download a video from a supported streaming service:
```bash
svtplay-dl https://www.svtplay.se/video/example-url
```

### Common Options
```bash
# Download with specific quality
svtplay-dl -q 720p https://www.svtplay.se/video/example-url

# Download to specific directory
svtplay-dl -o /path/to/downloads/ https://www.svtplay.se/video/example-url

# Download with subtitles
svtplay-dl --subtitle https://www.svtplay.se/video/example-url

# List available formats/qualities
svtplay-dl --list-formats https://www.svtplay.se/video/example-url

# Resume interrupted download
svtplay-dl --resume https://www.svtplay.se/video/example-url
```

### Supported Platforms
- SVT Play (Sweden)
- TV4 Play (Sweden)
- NRK (Norway)
- DR (Denmark)
- Twitch.tv
- And 30+ other streaming services

### Output Options
```bash
# Custom filename format
svtplay-dl --filename-format "{title}-{season}x{episode}" URL

# Download multiple episodes
svtplay-dl --all-episodes https://www.svtplay.se/series-url

# Download specific episode range
svtplay-dl --all-episodes --episode-start 5 --episode-end 10 URL
```

## Environment

The devenv environment provides:
- Python 3.12 with virtual environment
- svtplay-dl installed and ready to use
- ffmpeg for media processing
- All necessary dependencies managed automatically

## Getting Help

```bash
# Show all available options
svtplay-dl --help

# Show version information
svtplay-dl --version
```

## Notes

- Always respect the terms of service of the streaming platforms
- Some content may be geo-restricted
- Quality and format availability varies by platform and content