all: prechecks .SRCINFO postchecks

postchecks: PKGBUILD .SRCINFO
	makepkg -p $<
	pkgctl license check

.SRCINFO: PKGBUILD prechecks
	makepkg -p $< --printsrcinfo >$@

prechecks: PKGBUILD
	# TODO: add this back
	# shellcheck $<
	updpkgsums $<
	namcap $<
	shfmt -w $<

.PHONY: prechecks
