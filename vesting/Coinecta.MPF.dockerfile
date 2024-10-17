FROM node:20-bullseye
WORKDIR /app
ARG COMMIT=c8824a0ec52b2f1a03d4b6f0fc7803ccc85e740d
RUN git clone https://github.com/coinecta/mpf-api.git
WORKDIR /app/mpf-api
RUN git checkout ${COMMIT}
RUN corepack enable
RUN pnpm install
RUN pnpm run build

ENTRYPOINT ["pnpm", "start:prod"]