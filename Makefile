.PHONY: help build-runtime push-runtime tag-latest-runtime all clean

# Configuration
RUNTIME_IMAGE_NAME := bindu-runtime-base
REGISTRY := raahulrahl
VERSION := $(shell cat .version)
RUNTIME_IMAGE := $(REGISTRY)/$(RUNTIME_IMAGE_NAME)

help:
	@echo "Bindu Base Images - Build & Push"
	@echo ""
	@echo "Usage:"
	@echo "  make build-runtime        Build the runtime base image"
	@echo "  make push-runtime         Push the runtime image"
	@echo "  make tag-latest-runtime   Tag and push runtime as latest"
	@echo "  make all                  Build and push runtime image"
	@echo "  make clean                Remove local images"
	@echo ""
	@echo "Current version: $(VERSION)"
	@echo "Runtime image: $(RUNTIME_IMAGE):$(VERSION)"

build-runtime:
	@echo "Building $(RUNTIME_IMAGE):$(VERSION)..."
	docker build --no-cache -f Dockerfile.runtime-base -t $(RUNTIME_IMAGE):$(VERSION) .
	@echo "✓ Runtime build complete"

push-runtime: build-runtime
	@echo "Pushing $(RUNTIME_IMAGE):$(VERSION)..."
	docker push $(RUNTIME_IMAGE):$(VERSION)
	@echo "✓ Runtime push complete"

tag-latest-runtime:
	@echo "Tagging $(RUNTIME_IMAGE):$(VERSION) as latest..."
	docker tag $(RUNTIME_IMAGE):$(VERSION) $(RUNTIME_IMAGE):latest
	docker push $(RUNTIME_IMAGE):latest
	@echo "✓ Runtime latest tag pushed"

all: push-runtime tag-latest-runtime
	@echo "✓ All tasks complete"

clean:
	@echo "Removing local images..."
	-docker rmi $(RUNTIME_IMAGE):$(VERSION)
	-docker rmi $(RUNTIME_IMAGE):latest
	@echo "✓ Cleanup complete"