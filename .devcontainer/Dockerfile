FROM ubuntu:22.04

# Set environment to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# 1. Root: install sudo and create user
RUN apt-get update && \
    apt-get install -y sudo && \
    groupadd --gid 1000 ubuntu && \
    useradd -s /bin/bash --uid 1000 --gid 1000 -m ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu

# 2. Switch to user ubuntu
USER ubuntu
WORKDIR /home/ubuntu

# 3. Install packages as user (with sudo)
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
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
        texlive-extra-utils && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# 4. Set locale
RUN sudo locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
