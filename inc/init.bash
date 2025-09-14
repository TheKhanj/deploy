if [ -z "$_INC_INIT" ]; then
	_INC_INIT=1

	. 'inc/ssh.bash'
	. 'inc/git.bash'

	_init() {
		_ssh_init
		_git_init
	}
fi
