FROM archlinux:base

RUN pacman -Syu --noconfirm \
	base-devel jq curl namcap shellcheck coreutils go \
	findutils shfmt git sudo openssh pacman-contrib \
	graphviz devtools \
	&& pacman -Scc --noconfirm

RUN git config --global user.email "bot@deploy.com"
RUN git config --global user.name "Deployment Bot"

WORKDIR /workspace
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
