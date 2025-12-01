# Bindu Runtime Base Image

A minimal, multi-runtime base image for Bindu agents, combining Python 3.12 (via uv) and Node.js 22 on Debian Bookworm.

## Features

- **Python 3.12**: Installed via [uv](https://github.com/astral-sh/uv) for fast, reliable Python management
- **Node.js 22**: Latest LTS version with npm and npx
- **Minimal footprint**: Based on `debian:bookworm-slim` with only essential runtime dependencies
- **Multi-stage build**: Optimized layer caching and smaller final image size
- **OCI compliant**: Proper labels and metadata

## Image Details

- **Base OS**: Debian Bookworm (slim)
- **Python**: 3.12 (managed by uv)
- **Node.js**: 22.x
- **Working Directory**: `/app`

## Usage

### Pull the image

```bash
docker pull ghcr.io/getbindu/bindu-base:latest
# or specific version
docker pull ghcr.io/getbindu/bindu-base:1.0.0
```

### Use as base image

```dockerfile
FROM ghcr.io/getbindu/bindu-base:1.0.0

# Your agent-specific setup
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY package.json .
RUN npm install

# ... rest of your Dockerfile
```

## Building & Publishing

### Prerequisites

- Docker installed and running
- Authenticated to GitHub Container Registry:
  ```bash
  echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
  ```

### Build Commands

```bash
# Build the image
make build

# Build and push versioned image
make push

# Tag and push as latest
make tag-latest

# Build and push both versioned and latest
make all

# Clean up local images
make clean
```

### Version Management

Update the version in `Makefile`:

```makefile
VERSION := 1.0.0  # Change this for new releases
```

## Architecture

The Dockerfile uses a multi-stage build:

1. **uv-base**: Installs Python 3.12 using uv
2. **node-base**: Provides Node.js 22 binaries
3. **Final stage**: Combines both runtimes on minimal Debian base

This approach ensures:
- Clean separation of build dependencies
- Smaller final image (no build tools included)
- Efficient layer caching

## Python Environment

Python is available globally at `/python/bin/python`. Each agent should create its own virtual environment:

```bash
python -m venv /app/venv
source /app/venv/bin/activate
```

## Node.js Environment

Node.js, npm, and npx are available globally:

```bash
node --version  # v22.x.x
npm --version
```

## License

Maintained by Bindu team.

## Contact

**Author**: Raahul Dutta <raahul@getbindu.com>
