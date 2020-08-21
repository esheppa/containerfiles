#!/usr/bin/python3
import os 
import os.path as path
import subprocess
import sys
from typing import Optional

def build_image(dir: str):
	subprocess.run(["buildah", "bud", "-f", "{}/Dockerfile".format(dir), "--tag", "{}".format(dir)])

def push_image(image: str, repo: str):
	subprocess.run(["podman", "push", image, "{}/{}".format(repo, image)])

def remove_image(image: str, repo: Optional[str] = None):
	if repo is None:
		subprocess.run(["podman", "rmi", image])
	else:
		subprocess.run(["podman", "rmi", "{}/{}".format(repo, image)])

no_deps = [
	"vultr-cli",
	"netcat",
	"certbot",
	"nmap",
	"texlive",
	"mutt",
	"wireshark",
	"s3cmd",
	"nomad",
	"vault",
	"pandoc",
	"terraform",
	"wrk",
	"consul",
	"rstudio",
	"azure-cli",
	"ansible",
	"aws-cli",
]

dep_fedora_base = [
	"rs-builder",
	"jq",
	"task",
	"hledger",
	"timew",
	"mssql-cli",
	"pgcli",
	"restic",
]


try:
	if sys.argv[2] == "push":
		with open('repo-auth','r') as f:
			credentials = str.encode(f.read())
			subprocess.run(["podman", "login", "-u esheppa", "--password-stdin", "quay.io"], input = credentials)
except:
	print("Not logging in")

if sys.argv[1] == "base":
	print("Building: fedora-base")
	remove_image("fedora:latest","registry.fedoraproject.org")
	build_image("fedora-base")
	try:
		if sys.argv[2] == "push":
			push_image("fedora-base", "quay.io/esheppa")
	except:
		print("Not pushing fedora-base")
elif sys.argv[1] == "utils":
	for dir in dep_fedora_base:
		print("Building:", dir)
		remove_image(dir)
		build_image(dir)
		try:
			if sys.argv[2] == "push":
				push_image(dir, "quay.io/esheppa")
		except:
			print("Not pushing", dir)
elif sys.argv[1] == "neovim":
		print("Building: neovim")
		remove_image("neovim")
		build_image("neovim")
		try:
			if sys.argv[2] == "push":
				push_image("neovim", "quay.io/esheppa")
		except:
			print("Not pushing neovim")
elif sys.argv[1] == "other":
	for dir in no_deps:
		print("Building:", dir)
		remove_image(dir)
		build_image(dir)
		push_image(dir, "quay.io/esheppa")
		try:
			if sys.argv[2] == "push":
				push_image(dir, "quay.io/esheppa")
		except:
			print("Not pushing", dir)
else:
    print("Please choose a subcommand from `base`, `utils`, `neovim` or `other`")


