# Start from the official n8n Docker image
FROM n8nio/n8n

# Switch to the root user to install system packages
USER root

# On Alpine Linux, use 'apk' to install packages.
# Then use pip to install yt-dlp, adding the --break-system-packages flag to override the environment protection.
RUN apk add --no-cache python3 py3-pip && pip3 install --upgrade yt-dlp --break-system-packages

# Switch back to the non-root 'node' user for security
USER node
