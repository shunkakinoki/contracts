FROM alpine as build
WORKDIR /opt
RUN apk add pkgconfig gcc musl-dev python3-dev libffi-dev openssl-dev clang lld curl build-base linux-headers git \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
    && chmod +x ./rustup.sh \
    && ./rustup.sh -y

WORKDIR /opt/huff-rs
RUN git clone https://github.com/huff-language/huff-rs .
RUN apk add libressl-dev && source $HOME/.profile && cargo build --release \
    && strip /opt/huff-rs/target/release/huffc

WORKDIR /opt/foundry
RUN git clone https://github.com/foundry-rs/foundry .
RUN source $HOME/.profile && cargo build --release \
    && strip /opt/foundry/target/release/forge \
    && strip /opt/foundry/target/release/cast \
    && strip /opt/foundry/target/release/anvil

FROM alpine as client
ENV GLIBC_KEY=https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
ENV GLIBC_KEY_FILE=/etc/apk/keys/sgerrand.rsa.pub
ENV GLIBC_RELEASE=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk

RUN apk add linux-headers gcompat
RUN wget -q -O ${GLIBC_KEY_FILE} ${GLIBC_KEY} \
    && wget -O glibc.apk ${GLIBC_RELEASE} \
    && apk add glibc.apk --force

COPY --from=build /opt/huff-rs/target/release/huffc /usr/local/bin/huffc
COPY --from=build /opt/foundry/target/release/forge /usr/local/bin/forge
COPY --from=build /opt/foundry/target/release/cast /usr/local/bin/cast
COPY --from=build /opt/foundry/target/release/anvil /usr/local/bin/anvil

COPY . .

RUN /bin/sh -c "forge install"
RUN /bin/sh -c "forge build"
RUN /bin/sh -c "forge test"

ENTRYPOINT ["/bin/sh", "-c"]
