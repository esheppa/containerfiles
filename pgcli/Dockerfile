FROM quay.io/esheppa/fedora-base
RUN dnf install -y \
	openssl-devel \
	pip \
	python3-devel \
	libicu-devel \
	libpq-devel \
	postgresql \
	openssl \
	python3 
RUN dnf clean all
RUN pip install pgcli
