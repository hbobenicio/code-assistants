FROM node:24.15.0-trixie-slim

# Docker build operators are expected to inform the GID/UID of the container user.
# To avoid permission errors on read/write operations (for the container process and for the host user),
# ideally the GID and the UID of the container user must match the GID and the UID of the host user.
ARG UID
ARG GID

RUN addgroup --gid ${GID} ai-code
RUN adduser  --gid ${GID} --uid ${UID} --disabled-password ai-code

USER ai-code

ENV NODE_ENV=production

# NPM setup: updating npm prefix for the non-root user to be able to install packages
RUN mkdir -p /home/ai-code/.npm-global
ENV PATH="/home/ai-code/.npm-global/bin:$PATH"
RUN npm config set prefix /home/ai-code/.npm-global

# NPM setup: sane security settings: protection against supply chain attacks
RUN npm config set --global min-release-age 7
RUN npm config set --global ignore-scripts  true

# Workspace is where container users should mount their projects folder
VOLUME  /home/ai-code/workspace
WORKDIR /home/ai-code/workspace

# PI coding agent installation / setup
ENV PI_SKIP_VERSION_CHECK=1
ENV PI_OFFLINE=1
RUN npm install -g --omit=optional --omit=dev '@earendil-works/pi-coding-agent@0.74.0'

# PI setup: configurations
COPY --chown=ai-code:ai-code ./agent /home/ai-code/.pi/agent/

# CMD ["pi"]
CMD ["bash"]

