# Base image with commonly used packages
FROM registry.fedoraproject.org/fedora:latest
RUN dnf install -y \
	git \
	wget \
	which \
	curl \
	unzip \
	gpg \
	groff \
	less
RUN dnf clean all
