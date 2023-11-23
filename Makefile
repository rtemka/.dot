all:
	stow --verbose --restow --target=${HOME} */

dry-run:
	stow -v -n --restow --target=${HOME} */

delete:
	stow --verbose --delete --target=${HOME} */
