#!/bin/bash
##################################
#Author: Sivanesh B
#Date: 19/06/2024
#
#Version: 1.0
#################################

# Function to display usage instructions
usage() {
    echo "Usage: $0 <github_repo_url> <docker_image_name>"
    echo "Example: $0 https://github.com/user/repo.git my-docker-image"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    usage
fi

# Assign variables from arguments
GITHUB_REPO_URL=$1
DOCKER_IMAGE_NAME=$2

# Clone the GitHub repository
echo "Cloning the repository from $GITHUB_REPO_URL..."
git clone $GITHUB_REPO_URL
if [ $? -ne 0 ]; then
    echo "Failed to clone the repository."
    exit 1
fi

# Extract the repository name from the URL
REPO_NAME=$(basename $GITHUB_REPO_URL .git)

# Navigate to the cloned repository directory
cd $REPO_NAME || { echo "Failed to enter the directory $REPO_NAME."; exit 1; }

# Build the Docker image
echo "Building the Docker image $DOCKER_IMAGE_NAME..."
sudo docker build -t $DOCKER_IMAGE_NAME .
if [ $? -ne 0 ]; then
    echo "Failed to build the Docker image."
    exit 1
fi

echo "Docker image $DOCKER_IMAGE_NAME built successfully."

# End of script

