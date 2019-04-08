#! /bin/bash


function echoCo {
    echo -e "\033[32m$@\033[0m"
}

function echoMe {
    echo -e "\033[35m$@\033[0m"
}

function echoWa {
    echo -e "\033[33m$@\033[0m"
}

function echoEr {
    echo -e "\033[31m$@\033[0m"
}


function install_elpa_elpy {
    if which apt-get > /dev/null; then
        echoCo ' sudo apt install elpa-elpy'
                 sudo apt install elpa-elpy
    fi
}


# https://github.com/jorgenschaefer/elpy
install_elpa_elpy


# https://github.com/jorgenschaefer/elpy
echoCo 'sudo -H bash -c "$(which pip) install rope jedi flake8 autopep8 yapf"'
        sudo -H bash -c "$(which pip) install rope jedi flake8 autopep8 yapf"
