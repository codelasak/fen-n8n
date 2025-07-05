# Start from the official n8n Docker image
FROM n8nio/n8n

# Switch to the root user to install system packages
USER root

# Update package lists and install yt-dlp using pip
RUN apt-get update && apt-get install -y python3 python3-pip && pip3 install --upgrade yt-dlp

# Switch back to the non-root 'node' user for security
USER node
