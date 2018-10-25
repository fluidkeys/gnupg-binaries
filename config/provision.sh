#!/bin/bash -eux

install_extra_ppas() {
  echo
}

update_package_index() {
    sudo apt-get update
}

install_required_packages() {
    sudo apt-get install -y \
	ack-grep \
        clang \
	git \
	htop \
	libgpg-error-dev \
	libgcrypt-dev \
	libassuan-dev \
	libksba-dev \
	libnpth0-dev \
	make \
	tree \
	unzip \
	zip
}

configure_ack() {
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
}

install_symlinks() {
    echo
    # ln -sf /vagrant/config/bashrc /home/vagrant/.bashrc
}

atomic_download() {
    URL=$1
    DEST=$2

    TMP="$(tempfile)"

    wget -qO "${TMP}" "${URL}" && mv "${TMP}" "${DEST}"
}

run_as_vagrant() {
  su vagrant bash -l -c "$1"
}

build_gnupg_binaries() {
  /vagrant/build
}


install_symlinks
install_extra_ppas
update_package_index
install_required_packages
configure_ack
build_gnupg_binaries
