if [ -z "$_INC_INIT" ]; then
	_INC_INIT=1

	. 'inc/ssh.bash'

	_init() {
		_ssh_init
	}
fi
