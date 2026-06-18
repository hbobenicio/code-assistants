FROM node:24.15.0-trixie-slim

RUN apt update \
 && apt install -y fd-find ripgrep git \
 && rm -rf /var/lib/apt/lists/*

USER node

ENV NODE_ENV=production

# NPM setup: updating npm prefix for the non-root user to be able to install packages
RUN mkdir -p /home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"
RUN npm config set prefix /home/node/.npm-global

# NPM setup: sane security settings: protection against supply chain attacks
RUN npm config set --global min-release-age 7
RUN npm config set --global allow-git       none
RUN npm config set --global ignore-scripts  true

# Workspace is where container users should mount their projects folder
VOLUME  /home/node/workspace
WORKDIR /home/node/workspace

# PI coding agent installation / setup
ENV PI_SKIP_VERSION_CHECK=1
ENV PI_OFFLINE=1
RUN npm install -g --omit=optional --omit=dev --ignore-scripts '@earendil-works/pi-coding-agent@0.74.0'
RUN pi install "npm:pi-permission-system"
RUN pi install "npm:@juicesharp/rpiv-ask-user-question"
RUN pi install "npm:pi-subagents"

# Do we really need this?!?
RUN ln -s /usr/bin/fdfind /home/node/.npm-global/bin/fd

# PI setup: configurations
COPY --chown=node:node ./pi/agent /home/node/.pi/agent/

# CMD ["pi"]
CMD ["bash"]

