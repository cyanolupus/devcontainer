ARG VARIANT=invalid
ARG TYPST_VERSION=invalid
ARG TYPSTYLE_VERSION=invalid

FROM mcr.microsoft.com/devcontainers/rust:${VARIANT} AS typst-builder
ARG TYPST_VERSION
ADD https://github.com/typst/typst.git#${TYPST_VERSION} /typst
WORKDIR /typst
# Replace cp with --artifact-dir after GA
RUN --mount=type=cache,target=/typst/target/ \
    --mount=type=cache,target=/usr/local/cargo/registry/ \
    cargo build --locked --release -p typst-cli && cp ./target/release/typst /bin/typst

FROM mcr.microsoft.com/devcontainers/rust:${VARIANT} AS typstyle-builder
ARG TYPSTYLE_VERSION
ADD https://github.com/Enter-tainer/typstyle.git#${TYPSTYLE_VERSION} /typstyle
WORKDIR /typstyle
# Replace cp with --artifact-dir after GA
RUN --mount=type=cache,target=/typstyle/target/ \
    --mount=type=cache,target=/usr/local/cargo/registry/ \
    cargo build --locked --release && cp ./target/release/typstyle /bin/typstyle

FROM mcr.microsoft.com/devcontainers/base:${VARIANT} AS output
COPY --from=typst-builder /bin/typst /usr/local/bin/typst
COPY --from=typstyle-builder /bin/typstyle /usr/local/bin/typstyle
