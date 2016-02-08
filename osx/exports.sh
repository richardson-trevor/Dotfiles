#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export PATH
export PYTHONPATH
export M2_HOME
export M2="${M2_HOME}/bin"
export SSL_CERT_FILE

PATH=/usr/local/bin:/usr/local/sbin:$(brew --prefix ruby)/bin:~/.local/bin:$PATH
M2_HOME=$(brew --prefix maven)/libexec
SSL_CERT_FILE=$(brew --prefix)/etc/openssl/osx_cert.pem

export NVM_DIR=~/.nvm

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications";
