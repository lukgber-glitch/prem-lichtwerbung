FROM node:20-alpine

WORKDIR /directus

# Install required tools for bootstrap script
RUN apk add --no-cache curl jq netcat-openbsd bash

# Install Directus globally
RUN npm install -g directus@11.13.2

# Copy package.json and install dependencies
COPY directus/package.json directus/package-lock.json* ./
RUN npm install

# Copy bootstrap scripts and data
COPY directus/bootstrap /directus/bootstrap
COPY directus/entrypoint.sh /directus/entrypoint.sh

# Make entrypoint executable
RUN chmod +x /directus/entrypoint.sh

# Expose Directus port
EXPOSE 8055

# Run entrypoint script
ENTRYPOINT ["/directus/entrypoint.sh"]
