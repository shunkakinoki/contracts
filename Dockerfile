FROM ghcr.io/foundry-rs/foundry

RUN apk add git

COPY . .

RUN forge install
RUN forge build
RUN forge test
