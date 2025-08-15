FROM mcr.microsoft.com/devcontainers/base:ubuntu
RUN wget https://github.com/errata-ai/vale/releases/download/v2.26.0/vale_2.26.0_Linux_64-bit.tar.gz && \
    tar -xvzf vale_2.26.0_Linux_64-bit.tar.gz -C bin && \
    export PATH=./bin:"$PATH"
