#!/bin/bash
#######################################
# 
# Author: Forest Wang <jlq.zhulin@gmail.com>
#
#######################################

BASE_PATH=$(cd "$(dirname "$0")";pwd)
SECRET_FILE=$BASE_PATH"/.secret-file"

function init {

	if ! hash gpg 2>/dev/null ; then
            echo "Please ensure that GnuPG is installed!"
            exit 1
        fi
    
	if ! hash expect 2>/dev/null; then
	    echo "Please ensure that expect is installed!"
	    exit 2
	fi

	if ! hash oathtool 2>/dev/null ; then
            echo "Please ensure that oathtool is installed!"
            exit 3
        fi

	if [ ! -f $SECRET_FILE ]; then
		echo "It seems like you are using this tool for the first time."
		initSecretFile
	fi

	clear
	sshLogin ;
}

function initSecretFile {
	echo "You will be asked to enter the password to protect the secret key"
	echo -n "Please enter your verify key -> "
	read verifyKey
	echo $verifyKey | gpg --symmetric --out $SECRET_FILE
}

function sshLogin {
	local secret="$(gpg --quiet < $SECRET_FILE)"
	local verificationCode="$(oathtool --base32 --totp $secret)"
	$(which expect) $BASE_PATH/totp_input.ex ${verificationCode}
	# echo $verificationCode
}

init ;
