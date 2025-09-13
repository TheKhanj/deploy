FROM archlinux:base

RUN pacman -Syu --noconfirm \
	base-devel jq curl namcap shellcheck coreutils \
	findutils shfmt git sudo \
	&& pacman -Scc --noconfirm

WORKDIR /workspace

RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
