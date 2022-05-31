FROM ghcr.io/foundry-rs/foundry
LABEL org.opencontainers.image.source https://github.com/shunkakinoki/contracts
RUN apk add git

WORKDIR /app

COPY . .

RUN forge install
RUN forge build
RUN forge test

ENTRYPOINT ["forge"]
