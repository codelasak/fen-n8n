

  # Update package list and install dependencies
RUN apk update && apk add --no-cache \
  python3 \
  py3-pip \
  chromium \
  chromium-chromedriver \
  xvfb \
  && rm -rf /var/cache/apk/*

  # Install yt-dlp with system packages override
RUN pip3 install --upgrade yt-dlp --break-system-packages

  # Create a symlink for chrome to make it available for yt-dlp
RUN ln -sf /usr/bin/chromium-browser /usr/bin/google-chrome

  # Set environment variables for headless Chrome
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/bin/chromium-browser
ENV DISPLAY=:99

  # Create footage directory for downloads
RUN mkdir -p /home/node/footage && chown -R node:node /home/node/footage

  # Switch back to the non-root 'node' user for security
USER node

  # Set working directory
WORKDIR /home/node
