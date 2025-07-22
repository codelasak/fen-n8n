FROM n8nio/n8n:1.101.2

  # Switch to the root user to install system packages
  USER root

  # Update package list and install dependencies including Node.js tools
  RUN apk update && apk add --no-cache \
      ffmpeg \
      python3 \
      py3-pip \
      chromium \
      chromium-chromedriver \
      xvfb \
      gcc \
      python3-dev \
      musl-dev \
      curl \
      nodejs \
      npm \
      && rm -rf /var/cache/apk/*

  # Install yt-dlp only (skip playwright for now)
  RUN pip3 install --upgrade yt-dlp --break-system-packages

  # Create a symlink for chrome to make it available for yt-dlp
  RUN ln -sf /usr/bin/chromium-browser /usr/bin/google-chrome

  # Set environment variables for headless Chrome and Playwright
  ENV CHROME_BIN=/usr/bin/chromium-browser
  ENV CHROME_PATH=/usr/bin/chromium-browser
  ENV DISPLAY=:99
  ENV PLAYWRIGHT_BROWSERS_PATH=/root/.cache/ms-playwright

  # Create footage directory for downloads
  RUN mkdir -p /home/node/footage && chown -R node:node /home/node/footage

  # Create Playwright cache directory with proper permissions
  RUN mkdir -p /root/.cache/ms-playwright && chown -R node:node /root/.cache/ms-playwright

  # Switch back to the non-root 'node' user for security
  USER node

  # Set working directory
  WORKDIR /home/node/.n8n
