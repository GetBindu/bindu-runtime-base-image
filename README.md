# Bindu Runtime Base Image

A minimal, multi-runtime base image for Bindu agents, combining Python 3.12 (via uv) and Node.js 22 on Debian Bookworm.


## Image Details

- **Base OS**: Debian Bookworm (slim)
- **Python**: 3.12 (managed by uv)
- **Node.js**: 22.x
- **Working Directory**: `/app`

## Usage

### Pull the image

```bash
docker pull raahulrahl/getbindu/bindu-base:latest
```

## Building & Publishing

### Prerequisites

- Docker installed and running
- Authenticated to Docker Hub:
  ```bash
  echo $DOCKERHUB_TOKEN | docker login -u raahulrahl --password-stdin
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


## License

Maintained by Bindu team.

## Contact

**Author**: Raahul Dutta <raahul@getbindu.com>
