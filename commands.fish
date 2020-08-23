#!/usr/bin/fish

function aws
	mkdir -p .aws
	chcon -Rt svirt_sandbox_file_t $PWD/.aws
	podman run --rm -it \
	    -v $PWD/.aws:/root/.aws \
	    aws-cli aws $argv
end

function aws-dir
	if test $PWD = $HOME
		echo "Please run in a more appropriate directory!"
	else
		mkdir -p .aws
		chcon -Rt svirt_sandbox_file_t $PWD
		podman run --rm -it \
		    -v $PWD:/root/ \
		    aws-cli aws $argv
	end
end

function az
	mkdir -p .azure
	chcon -Rt svirt_sandbox_file_t $PWD/.azure
	podman run --rm -it \
	    -v $PWD/.azure:/root/.azure \
	    mcr.microsoft.com/azure-cli az $argv
end

function mssql-cli
	podman run --rm -it fedora-base mssql-cli $argv
end

function pgcli
	podman run --rm -it fedora-base pgcli $argv
end

function cargo
	if test $PWD = $HOME
	    echo "Please run in a more appropriate directory!"
	else
	    if not test -n "$RUST_LOG"
		set -x RUST_LOG info
	    end
	    chcon -Rt svirt_sandbox_file_t $PWD;
	    chcon -t svirt_sandbox_file_t $HOME/.git-credentials;
	    chcon -t svirt_sandbox_file_t $HOME/.gitconfig;
	    mkdir -p $HOME/Applications/cargo-root/registry;
	    chcon -t svirt_sandbox_file_t $HOME/Applications/cargo-root/registry;
	    mkdir -p $HOME/Applications/cargo-usr/registry;
	    chcon -t svirt_sandbox_file_t $HOME/Applications/cargo-usr/registry;
	    podman run --rm \
		-v $PWD:/workingdir \
		-v $HOME/.git-credentials:/root/.git-credentials \
		-v $HOME/.gitconfig:/root/.gitconfig \
		-v $HOME/Applications/cargo-root/registry:/usr/local/cargo/registry \
		-v $HOME/Applications/cargo-usr/registry:/root/.cargo/registry \
		-e RUST_LOG=$RUST_LOG \
		-e USER=$USER \
		-it rs-builder cargo $argv
	end
end

function hledger
	mkdir -p ~/Applications/hledger
	chcon -Rt svirt_sandbox_file_t ~/Applications/hledger
	podman run --rm -it \
	    -v ~/Applications/hledger:/root \
	    fedora-base hledger $argv
end

function mssql
	podman run --rm -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=12345Abcde' --name 'mssqlserver' -d -p 1433:1433 mcr.microsoft.com/mssql/rhel/server
end

function nvim
	if test $PWD = $HOME 
	    chcon -t svirt_sandbox_file_t $1
	    podman run --rm \
		-v $PWD/$1:/workingdir/$1 \
		-e USER=$USER \
		-it neovim nvim $1
	else
	    chcon -Rt svirt_sandbox_file_t $PWD
	    podman run --rm \
		-v $PWD:/workingdir \
		-e USER=$USER \
		-it neovim nvim $1
	end
end

function nvim-rs
	if test -f "Cargo.toml"
	    touch Session.vim
	    #mkdir -p $PWD/.cargo-registry;
	    chcon -Rt svirt_sandbox_file_t $PWD
	    chcon -t svirt_sandbox_file_t $HOME/.git-credentials;
	    chcon -t svirt_sandbox_file_t $HOME/.gitconfig;
	    mkdir -p $HOME/Applications/cargo-root/registry;
	    chcon -t svirt_sandbox_file_t $HOME/Applications/cargo-root/registry;
	    mkdir -p $HOME/Applications/cargo-usr/registry;
	    chcon -t svirt_sandbox_file_t $HOME/Applications/cargo-usr/registry;
	    podman run --rm \
		-v $PWD:/workingdir \
		-v $HOME/Applications/cargo-root/registry:/usr/local/cargo/registry \
		-v $HOME/Applications/cargo-usr/registry:/root/.cargo/registry \
		-v $HOME/.git-credentials:/root/.git-credentials \
		-v $HOME/.gitconfig:/root/.gitconfig \
		-e USER=$USER \
		-it neovim nvim -S
	else
		echo "Please run me in the root directory of a rust project"
	end
end

function nvim-py
	if test -f "setup.py"
	    touch Session.vim
	    chcon -Rt svirt_sandbox_file_t $PWD
	    podman run --rm \
		-v $PWD:/workingdir \
		-e USER=$USER \
		-it neovim nvim -S
	else
		echo "Please run me in the root directory of a python project"
	end
end

function task
	mkdir -p ~/Applications/taskwarrior
	chcon -Rt svirt_sandbox_file_t ~/Applications/taskwarrior
	podman run --rm -it \
	    -v ~/Applications/taskwarrior:/root \
	    fedora-base task $argv
end

function tf
	if test $PWD = $HOME
		echo "Please run in a more appropriate directory!"
	else
	        mkdir -p '.terraform.d'
	        touch .terraformrc
		chcon -Rt svirt_sandbox_file_t $PWD
		podman run --rm -it \
		    -v $PWD:/workingdir \
		    -v $PWD/.terraform.d:/root/.terraform.d \
		    -v $PWD/.terraformrc:/root/.terraformrc \
		    terraform bash -c "cd /workingdir && terraform $argv"
	end
end

function timew
	mkdir -p ~/Applications/timewarrior
	chcon -Rt svirt_sandbox_file_t ~/Applications/timewarrior
	podman run --rm -it \
	    -v ~/Applications/timewarrior:/root \
	    fedora-base timew $argv
end

function wasm-pack
	if test -f "Cargo.toml"
		chcon -Rt svirt_sandbox_file_t $PWD;
		mkdir -p $PWD/.cargo-registry;
		podman run --rm \
			-v $PWD:/workingdir \
			-v $PWD/.cargo-registry:/usr/local/cargo/registry \
			-e USER=$USER \
			-it rs-builder wasm-pack $argv
	else
		echo "Please run me in the root directory of a rust project"
	end
end
