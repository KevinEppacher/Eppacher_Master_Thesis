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

RUN apt-get update && \
    apt-get install -y texlive-full latexmk && \
    apt-get clean

# Locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
