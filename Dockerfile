ARG BASE_VERSION
ARG RUST_VERSION
FROM --platform=$TARGETPLATFORM ghcr.io/calm04061/rust:${BASE_VERSION}-${RUST_VERSION}-protobuf as builder
WORKDIR /app
ADD Cargo.* ./
RUN mkdir src &&\
    echo "fn main(){}" > src/main.rs && \
    cargo build --release

ADD . ./
RUN cargo build --release

FROM  --platform=$TARGETPLATFORM ghcr.io/calm04061/rust:${BASE_VERSION}-${RUST_VERSION}-runner
EXPOSE 50051
WORKDIR /app

COPY --from=builder /app/target/release/github-cache /app/github-cache
ENTRYPOINT ["./github-cache"]
