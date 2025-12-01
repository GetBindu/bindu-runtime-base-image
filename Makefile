.PHONY: help build push tag-latest all clean

# Configuration
IMAGE_NAME := bindu-base
REGISTRY := raahulrahl/getbindu
VERSION := 1.0.0
FULL_IMAGE := $(REGISTRY)/$(IMAGE_NAME)

help:
	@echo "Bindu Base Image - Build & Push"
	@echo ""
	@echo "Usage:"
	@echo "  make build        Build the Docker image"
	@echo "  make push         Push the versioned image"
	@echo "  make tag-latest   Tag and push as latest"
	@echo "  make all          Build, push versioned, and push latest"
	@echo "  make clean        Remove local images"
	@echo ""
	@echo "Current version: $(VERSION)"
	@echo "Image: $(FULL_IMAGE):$(VERSION)"

build:
	@echo "Building $(FULL_IMAGE):$(VERSION)..."
	docker build -f Dockerfile.base -t $(FULL_IMAGE):$(VERSION) .
	@echo "✓ Build complete"

push: build
	@echo "Pushing $(FULL_IMAGE):$(VERSION)..."
	docker push $(FULL_IMAGE):$(VERSION)
	@echo "✓ Push complete"

tag-latest:
	@echo "Tagging $(FULL_IMAGE):$(VERSION) as latest..."
	docker tag $(FULL_IMAGE):$(VERSION) $(FULL_IMAGE):latest
	docker push $(FULL_IMAGE):latest
	@echo "✓ Latest tag pushed"

all: build push tag-latest
	@echo "✓ All tasks complete"

clean:
	@echo "Removing local images..."
	-docker rmi $(FULL_IMAGE):$(VERSION)
	-docker rmi $(FULL_IMAGE):latest
	@echo "✓ Cleanup complete"
