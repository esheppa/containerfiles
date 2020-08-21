FROM rs-builder
RUN dnf install -y \
	neovim \
	python3-neovim \
	pip \
	ripgrep \
	curl \
	libcurl-devel \
	python3-devel \
	libicu-devel \
	python3 \
	jq \
	bat \
	git-delta \
	fd-find
RUN dnf clean all

RUN yes y | pip install pynvim 
RUN yes y | pip install pynvim
RUN yes y | pip uninstall msgpack
RUN yes y | pip install 'msgpack>=1.0.0'
RUN pip install pynvim 'python-language-server[all]' mypy pyls-mypy
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir -p /workingdir
RUN mkdir /root/.config
RUN mkdir /root/.config/nvim
COPY neovim/init.vim /root/.config/nvim
RUN nvim +PlugUpgrade +PlugInstall +UpdateRemotePlugins +qa
RUN printf "colorscheme gruvbox\n" >> /root/.config/nvim/init.vim
RUN printf "set background=light\n" >> /root/.config/nvim/init.vim
WORKDIR /workingdir
CMD ["nvim"]
