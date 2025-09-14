. 'inc/aur.bash'
. 'inc/common.bash'

update() {
	local name="ella"
	local dir="$(_aur_get_project_dir "${name}")"
	local makefile="${PWD}/aur/ella/Makefile"

	_aur_clean_clone "${name}" "${dir}"

	pushd "${dir}"
	_update "${makefile}"
	popd
	_aur_push
}

update_bin() {
	local name="ella-bin"
	local dir="$(_aur_get_project_dir "${name}")"
	local makefile="${PWD}/Makefile"

	_aur_clean_clone "${name}" "${dir}"

	pushd "${dir}"
	_update "${makefile}"
	popd
	_aur_push
}

_update() {
	local makefile="$1"

	local current="$(
		cat PKGBUILD |
			grep -oP '(?<=pkgver='"'"')([^'"'"']*)'
	)"
	local latest="$(_get_latest_version)"

	if [ "${current}" = "${latest}" ]; then
		_common_log "ella: deploy: already up to date: ${current}"
		return 0
	fi

	cp PKGBUILD PKGBUILD.backup
	cat PKGBUILD.backup |
		sed "s/^pkgver=.*/pkgver='${latest}'/" |
		sed 's/^pkgrel=.*/pkgrel=1/' >PKGBUILD
	rm PKGBUILD.backup

	make -f "${makefile}"
	git add .
	git commit -m "deploy-bot: bump up version: ${latest}"
}

_get_latest_version() {
	curl -s https://api.github.com/repos/thekhanj/ella/releases/latest |
		grep '"tag_name":' |
		sed -E 's/.*"v([^"]+)".*/\1/'
}
