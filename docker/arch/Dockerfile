FROM archlinux:base

RUN pacman -Syu --noconfirm \
	base-devel jq curl namcap shellcheck coreutils go \
	findutils shfmt git sudo openssh pacman-contrib \
	&& pacman -Scc --noconfirm

WORKDIR /workspace
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
