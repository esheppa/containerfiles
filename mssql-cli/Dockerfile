FROM quay.io/esheppa/fedora-base
RUN dnf install -y \
	openssl-devel \
	python3-devel \
	libicu-devel \
	openssl \
	python3 \
    pip
RUN dnf clean all
RUN pip install mssql-cli
