#!/bin/bash

# Script to build and push Docker image to Docker Hub

set -e

# Configuration
DOCKER_USERNAME="akshitmadan"
IMAGE_NAME="test-node-harness"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "=== Building and Pushing Docker Image ==="
echo "Image: ${FULL_IMAGE_NAME}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker Desktop."
    exit 1
fi

# Build the image
echo "Step 1: Building Docker image..."
docker build -t ${IMAGE_NAME}:${TAG} .
echo "✅ Image built successfully"
echo ""

# Tag the image
echo "Step 2: Tagging image for Docker Hub..."
docker tag ${IMAGE_NAME}:${TAG} ${FULL_IMAGE_NAME}
echo "✅ Image tagged: ${FULL_IMAGE_NAME}"
echo ""

# Login to Docker Hub
echo "Step 3: Logging in to Docker Hub..."
echo "Please enter your Docker Hub credentials:"
docker login -u ${DOCKER_USERNAME}
echo "✅ Logged in successfully"
echo ""

# Push the image
echo "Step 4: Pushing image to Docker Hub..."
docker push ${FULL_IMAGE_NAME}
echo "✅ Image pushed successfully"
echo ""

echo "=== Complete ==="
echo "Your image is now available at: ${FULL_IMAGE_NAME}"
echo ""
echo "You can verify by running:"
echo "  docker pull ${FULL_IMAGE_NAME}"
echo ""

