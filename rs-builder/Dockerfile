FROM fedora-base

RUN dnf install -y \
	git \
	clang \
	    openssl \
	openssl-devel \
	curl \
	libcurl-devel \
	gcc
RUN dnf clean all

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN curl -fLo ~/.cargo/bin/ra_lsp_server https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux 
RUN chmod +x ~/.cargo/bin/ra_lsp_server
RUN ln -s ~/.cargo/bin/* /usr/bin/
RUN rustup update \
	&& rustup target add wasm32-unknown-unknown \
	&& rustup component add rust-analysis \
	&& rustup component add rustfmt \
	&& rustup component add clippy \
	&& rustup component add rust-src \ 
	&& rustup toolchain add nightly 
RUN cargo install cargo-make \
	&& cargo install wasm-pack \
	&& cargo install cargo-expand \
	&& cargo install mdbook
RUN ln -sf ~/.cargo/bin/* /usr/bin/
RUN mkdir /workingdir
WORKDIR /workingdir
