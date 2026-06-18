FROM node:24.15.0-trixie-slim

RUN apt update \
    && apt install -y curl fd-find ripgrep \
    && rm -rf /var/lib/apt/lists/*

# NOTE assuming your host user has uid/gid == containers user (node) == 1000
USER node

RUN mkdir -p /home/node/.npm-global
RUN npm config set prefix /home/node/.npm-global
RUN npm config set --global min-release-age 7

# Opencode does use a postinstall script, which downloads from npm the opencode-cli
RUN npm config set --global ignore-scripts false

ENV PATH="/home/node/.npm-global/bin:/home/node/bin:$PATH"
RUN npm install -g --omit=optional --omit=dev "opencode-ai@1.15.3"

VOLUME  /home/node/workspace
WORKDIR /home/node/workspace

COPY --chown=node:node ./opencode/opencode.jsonc /home/node/.config/opencode/opencode.jsonc
COPY --chown=node:node ./opencode/agent/ /home/node/.config/opencode/agent/

CMD ["bash"]
# CMD [ "opencode", "--print-logs", "--log-level", "DEBUG" ]
