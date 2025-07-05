# Start from the official n8n Docker image
FROM n8nio/n8n

# Switch to the root user to install system packages
USER root

# On Alpine Linux, use 'apk' to install packages
# --no-cache keeps the image smaller
RUN apk add --no-cache python3 py3-pip && pip3 install --upgrade yt-dlp

# Switch back to the non-root 'node' user for security
USER node
