FROM archlinux:base

RUN pacman -Syu --noconfirm \
	base-devel jq curl namcap shellcheck coreutils \
	findutils shfmt git sudo openssh \
	&& pacman -Scc --noconfirm

WORKDIR /workspace
