if [ -z "$_INC_GIT" ]; then
	_INC_GIT=1

	_git_init() {
		if ! git config --global user.email >/dev/null; then
			git config --global user.email "bot@deploy.com"
		fi

		if ! git config --global user.name >/dev/null; then
			git config --global user.name "Deployment Bot"
		fi
	}
fi
