UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
    installer := mac
    readlink := greadlink
else
    installer := arch
    readlink := readlink
endif

install: $(installer)_install_prettier $(installer)_install_yamllint setup_prettier setup_yamllint setup_rubocop setup_flake8

arch_install_prettier:
	yay -S --needed --noconfirm prettier || true

arch_install_yamllint:
	yay -S --needed --noconfirm yamllint || true

mac_install_prettier:
	hash $(readlink) || brew install coreutils
	hash prettier 2>/dev/null || brew install prettier

mac_install_yamllint:
	hash $(readlink) || brew install coreutils
	hash yamllint 2>/dev/null || brew install yamllint

setup_prettier:
	ln -sf $$($(readlink) -f prettier.yaml) ~/.prettierrc.yaml

setup_yamllint:
	mkdir -p ~/.config/yamllint
	ln -sf $$($(readlink) -f yamllint.yaml) ~/.config/yamllint/config

setup_rubocop:
	hash rubocop 2>/dev/null || gem install --user-install rubocop
	ln -sf $$($(readlink) -f rubocop.yaml) ~/.rubocop.yml

setup_flake8:
	ln -sf $$($(readlink) -f flake8.ini) ~/.config/flake8
