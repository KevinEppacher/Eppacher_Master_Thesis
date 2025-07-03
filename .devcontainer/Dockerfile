# .devcontainer/Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install LaTeX, Tools und Abhängigkeiten in einem Schritt
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-science \
        texlive-bibtex-extra \
        biber \
        latexmk \
        python3-pygments \
        pandoc \
        git \
        curl \
        locales \
        make \
        chktex \
        texlive-extra-utils \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
