.PHONY := setup dry-run delete

STOW = $(shell command -v stow 2> /dev/null)

setup: check
	stow --verbose --restow --target=${HOME} */

check:
ifndef STOW
	$(error No 'stow' in $$PATH, consider installing GNU stow from https://github.com/aspiers/stow)
endif

dry-run: check
	stow -v -n --restow --target=${HOME} */

delete: check
	stow --verbose --delete --target=${HOME} */
