FROM node:20-bullseye
WORKDIR /app
ARG COMMIT=190e05069462dc00d0dcd540e782552512a6cc91
RUN git clone https://github.com/coinecta/mpf-api.git
WORKDIR /app/mpf-api
RUN git checkout ${COMMIT}
RUN corepack enable
RUN pnpm install
RUN pnpm run build

ENTRYPOINT ["pnpm", "start:prod"]