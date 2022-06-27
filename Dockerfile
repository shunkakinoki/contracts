FROM ghcr.io/foundry-rs/foundry
RUN apk add git
RUN curl -L get.huff.sh | bash

WORKDIR /app

COPY . .

RUN forge install
RUN forge build
RUN forge test --ffi

ENTRYPOINT ["forge"]
