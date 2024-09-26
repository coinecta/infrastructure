FROM node:20-bullseye
WORKDIR /app
ARG COMMIT=1452625067e168bcd913c1a603c11287b399ac5e
RUN git clone https://github.com/coinecta/mpf-api.git
WORKDIR /app/mpf-api
RUN git checkout ${COMMIT}
RUN corepack enable
RUN pnpm install
RUN pnpm run build

ENTRYPOINT ["pnpm", "start:prod"]