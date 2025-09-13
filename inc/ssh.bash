if [ -z "$_INC_SSH" ]; then
	_INC_SSH=1

	. 'inc/common.bash'

	_ssh_get_key() {
		local name="$1"

		echo "${CACHE}/ssh/${name}/key"
	}

	_ssh_init_key() {
		local name="$1"
		local privkey="$2"
		local pubkey="$3"

		_common_log "ssh: initializing \"${name}\" key"

		local dir="${CACHE}/ssh/${name}"
		if ! [ -d "${dir}" ]; then
			mkdir -p "${dir}"
		fi

		echo "${privkey}" >"${dir}/key"
		chmod 600 "${dir}/key"

		echo "${pubkey}" >"${dir}/key.pub"
	}

	_ssh_trust() {
		local host="$1"
		local known="${HOME}/.ssh/known_hosts"

		if ! [ -d "$(dirname "${known}")" ]; then
			mkdir -p "$(dirname "${known}")"
		fi

		if ! [ -f "${known}" ]; then
			touch "${known}"
			chmod 600 "${known}"
		fi

		if cat "${known}" |
			awk '{ print $1 }' |
			grep "${host}" -q >/dev/null; then
			_common_log "ssh: ${host} already trusted"
			return 0
		fi

		ssh-keyscan "${host}" >>"${known}"
	}

	_ssh_init_keys() {
		local privkey pubkey

		for name in aur; do
			privkey="$(jq -r ".ssh.${name}.privkey" ${CONFIG})"
			pubkey="$(jq -r ".ssh.${name}.pubkey" "${CONFIG}")"

			_ssh_init_key "$name" "${privkey}" "${pubkey}"
		done
	}

	_ssh_init() {
		_ssh_init_keys

		_ssh_trust "aur.archlinux.org"
		_ssh_trust "github.com"
	}
fi
