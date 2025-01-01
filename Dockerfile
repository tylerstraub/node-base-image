# Use an official Node.js image as the base
FROM node:22

# Set working directory
WORKDIR /app

# Install useful system utilities
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    procps \
    net-tools \
    iproute2 \
    nano \
    lsof \
    htop \
    jq \
    less \
    traceroute \
    iputils-ping \
    && apt-get clean

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
