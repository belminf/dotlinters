install : setup_prettier setup_yamllint

setup_prettier:
	yay -S --needed --noconfirm prettier || true
	ln -sf $$(readlink -f prettier.yaml) ~/.prettierrc.yaml

setup_yamllint:
	yay -S --needed --noconfirm yamllint || true
	mkdir -p ~/.config/yamllint
	ln -sf $$(readlink -f yamllint.yaml) ~/.config/yamllint/config
