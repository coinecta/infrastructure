FROM ubuntu:22.04
WORKDIR /app
# Install wget
RUN apt-get update && apt-get install -y wget
# Download tar
RUN wget https://github.com/IntersectMBO/cardano-node/releases/download/8.7.3/cardano-node-8.7.3-linux.tar.gz
# Extract tar
RUN tar -xvf cardano-node-8.7.3-linux.tar.gz
# Download Config
RUN wget https://book.world.dev.cardano.org/environments/mainnet/submit-api-config.json

ENTRYPOINT [ "./cardano-submit-api", "--config", "submit-api-config.json", "--mainnet", "--socket-path", "/ipc/node.socket", "--listen-address", "0.0.0.0"]