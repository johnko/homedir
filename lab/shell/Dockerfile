FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl git
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew install kubernetes-cli k9s helm || true
ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
