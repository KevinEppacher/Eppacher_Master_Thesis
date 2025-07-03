# .devcontainer/Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-latex-extra \
        latexmk \
        pandoc \
        git \
        curl \
        locales \
        make \
        && rm -rf /var/lib/apt/lists/*

# Locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
