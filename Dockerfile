 Start from the official n8n Docker image
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

  # Install yt-dlp and Playwright with system packages override
  RUN pip3 install --upgrade yt-dlp playwright --break-system-packages

  # Install Playwright browsers and dependencies
  RUN playwright install chromium --with-deps

  # Install Node.js Playwright package globally for n8n access
  RUN npm install -g playwright

  # Create a symlink for chrome to make it available for yt-dlp
  RUN ln -sf /usr/bin/chromium-browser /usr/bin/google-chrome

  # Set environment variables for headless Chrome and Playwright
  ENV CHROME_BIN=/usr/bin/chromium-browser
  ENV CHROME_PATH=/usr/bin/chromium-browser
  ENV DISPLAY=:99
  ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
  ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

  # Create footage directory for downloads
  RUN mkdir -p /home/node/footage && chown -R node:node /home/node/footage

  # Create Playwright cache directory with proper permissions
  RUN mkdir -p /ms-playwright && chown -R node:node /ms-playwright

  # Switch back to the non-root 'node' user for security
  USER node

  # Set working directory
  WORKDIR /home/node/.n8n
