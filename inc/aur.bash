if [ -z "$_INC_AUR" ]; then
	_INC_AUR=1

	. 'inc/ssh.bash'

	_aur_clean_clone() {
		local name="$1"
		local dir="$2"

		if [ -d "${dir}" ]; then
			# use sudo cause aur installs using root user
			sudo rm -rf "${dir}"
		fi
		if [ -d "$(dirname "${dir}")" ]; then
			mkdir -p "$(dirname "${dir}")"
		fi

		GIT_SSH_COMMAND="ssh -i $(_aur_get_ssh_key)" \
			git clone "aur@aur.archlinux.org:${name}" "${dir}"
	}

	_aur_push() {
		GIT_SSH_COMMAND="ssh -i $(_aur_get_ssh_key)" \
			git push
	}

	_aur_get_project_dir() {
		local name="$1"

		echo "${CACHE}/aur/${name}"
	}

	_aur_get_ssh_key() {
		_ssh_get_key aur
	}
fi
