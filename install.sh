#!/bin/bash
#set -x

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

function log_info() {
    echo -e "\033[32m[INFO]\033[0m $1"
}

function soft_link() {
	if [ -e "$1" ]; then
		ln -sf "$1" "$2"
	fi
}

log_info "backing up current vim config..."
today=`date +%Y%m%d`
related_files=( $HOME/.vimrc $HOME/.bashrc $HOME/.bash_profile $HOME/.gitconfig )
for i in "${related_files[@]}"; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today ; done
for i in "${related_files[@]}"; do [ -L $i ] && unlink $i ; done

log_info "setting up symlinks..."
soft_link $CURRENT_DIR/vimrc $HOME/.vimrc
#soft_link $CURRENT_DIR/vim $HOME/.vim
soft_link $CURRENT_DIR/bashrc $HOME/.bashrc
soft_link $CURRENT_DIR/bash_profile $HOME/.bash_profile
soft_link $CURRENT_DIR/gitconfig $HOME/.gitconfig

log_info "source bashrc..."
source ~/.bashrc
