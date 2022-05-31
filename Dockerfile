FROM ghcr.io/foundry-rs/foundry
RUN apk add git
WORKDIR /app

COPY . .

RUN forge install
RUN forge build
RUN forge test

ENTRYPOINT ["forge"]
