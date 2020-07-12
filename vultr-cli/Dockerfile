FROM quay.io/esheppa/fedora-base
RUN wget -q -O vultr.tar.gz https://github.com/vultr/vultr-cli/releases/download/v0.3.2/vultr-cli_0.3.2_linux_64-bit.tar.gz
RUN tar xf vultr.tar.gz
RUN mv vultr-cli /usr/local/bin
WORKDIR /workingdir

