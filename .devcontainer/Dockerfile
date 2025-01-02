# Base image
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

# Install common dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    software-properties-common \
    && apt-get clean

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install gcloud CLI
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --install-dir=/usr/local/ --disable-prompts \
    && ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Set up user permissions
ARG USERNAME=vscode
RUN usermod -aG sudo ${USERNAME}
