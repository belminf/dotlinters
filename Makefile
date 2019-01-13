UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
    installer := mac
else
    installer := arch
endif

install: $(installer)_install_prettier $(installer)_install_yamllint setup_prettier setup_yamllint

arch_install_prettier:
	yay -S --needed --noconfirm prettier || true

arch_install_yamllint:
	yay -S --needed --noconfirm yamllint || true

mac_install_prettier:
	brew install prettier

mac_install_yamllint:
	brew install yamllint

setup_prettier:
	ln -sf $$(readlink -f prettier.yaml) ~/.prettierrc.yaml

setup_yamllint:
	mkdir -p ~/.config/yamllint
	ln -sf $$(readlink -f yamllint.yaml) ~/.config/yamllint/config
