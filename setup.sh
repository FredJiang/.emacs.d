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


# echoCo 'git pull'
#         git pull


# echoCo 'git submodule init'
#         git submodule init


# echoCo 'git submodule update'
#         git submodule update


function install_cscope {
    if [ ! -d ~/cscope-15.8b ]; then
        echoMe 'install_cscope'

        echoCo 'cd'
                cd

        if [ ! -f ~/cscope-15.8b.tar.gz ]; then
            echoCo 'wget "https://jaist.dl.sourceforge.net/project/cscope/cscope/15.8b/cscope-15.8b.tar.gz"'
                    wget "https://jaist.dl.sourceforge.net/project/cscope/cscope/15.8b/cscope-15.8b.tar.gz"
        fi

        echoCo 'tar -zxvf cscope-15.8b.tar.gz'
                tar -zxvf cscope-15.8b.tar.gz
        echoCo 'cd cscope-15.8b'
                cd cscope-15.8b
        echoCo './configure'
                ./configure
        echoCo 'make'
                make
        echoCo 'sudo make install'
                sudo make install
        echoCo 'sudo cp contrib/xcscope/cscope-indexer /usr/local/bin/'
                sudo cp contrib/xcscope/cscope-indexer /usr/local/bin/
        echoCo 'sudo chmod +x /usr/local/bin/cscope-indexer'
                sudo chmod +x /usr/local/bin/cscope-indexer
        echoCo 'cp contrib/xcscope/xcscope.el ~/.emacs.d/mypackages/'
                cp contrib/xcscope/xcscope.el ~/.emacs.d/mypackages/
    fi
}


function install_clang {
    if which clang > /dev/null; then
        echoMe 'clang has installed'
    else
        if which yum > /dev/null; then
            echoCo 'sudo yum install      -y epel-release'
                    sudo yum install      -y epel-release
            echoCo 'sudo yum install      -y clang'
                    sudo yum install      -y clang
            echoCo 'sudo yum install      -y clang-devel'
                    sudo yum install      -y clang-devel
            echoCo 'sudo yum groupinstall -y "Development Tools"'
                    sudo yum groupinstall -y "Development Tools"
        else
            echoMe 'yum not exist'
        fi
    fi
}


function install_clang_format {
    if which clang-format > /dev/null; then
        echoMe 'clang-format has installed'
    else
        if which brew > /dev/null; then
            echoCo 'brew install clang-format'
                    brew install clang-format
            echoCo 'brew install llvm'
                    brew install llvm
        else
            echoMe 'brew not exist'
        fi
    fi
}


function install_the_silver_searcher {
    if which ag > /dev/null; then
        echoMe 'ag has installed'
    else
        if which brew > /dev/null; then
            echoCo 'brew install            the_silver_searcher'
                    brew install            the_silver_searcher
        else
            echoMe 'brew not exist'
        fi

        if which yum > /dev/null; then
            echoCo 'sudo yum install     -y the_silver_searcher'
                    sudo yum install     -y the_silver_searcher
        else
            echoMe 'yum not exist'
        fi

        if which apt-get > /dev/null; then
            echoCo 'sudo apt-get install -y silversearcher-ag'
                    sudo apt-get install -y silversearcher-ag
        else
            echoMe 'apt-get not exist'
        fi
    fi
}


case "$OSTYPE" in
  solaris*)
    echoMe "SOLARIS"
    ;;
  darwin*)
    echoMe "OSX"
    install_clang_format
    ;; 
  linux*)
    echoMe "LINUX"
    install_cscope
    install_clang
    ;;
  bsd*) 
    echoMe "BSD"
    ;;
  msys*) 
    echoMe "WINDOWS"
    ;;
  *)
    echoMe "unknown: $OSTYPE"
    ;;
esac


install_the_silver_searcher


echoCo 'cd ~/.emacs.d'
        cd ~/.emacs.d
echoCo 'cp ~/.emacs.d/.jsbeautifyrc ~/'
        cp ~/.emacs.d/.jsbeautifyrc ~/


echoCo 'cd'
        cd


if which js-beautify > /dev/null; then
    echoMe 'js-beautify has installed'
else
    if which npm > /dev/null; then
        echoCo 'npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install js-beautify'
                npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install js-beautify
    else
        echoEr 'npm not exist'
    fi
fi


if which eslint > /dev/null; then
    echoMe 'eslint has installed'
else
    if which npm > /dev/null; then
        echoCo 'npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install eslint'
                npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install eslint
    else
        echoEr 'npm not exist'
    fi
fi


if [ -d ~/.all-the-icons-fonts ]
then
    echoMe "      ~/.all-the-icons-fonts exist"
else
    echoMe "      ~/.all-the-icons-fonts not exist"

    echoCo "mkdir ~/.all-the-icons-fonts"
            mkdir ~/.all-the-icons-fonts
fi



echoCo 'cp ~/.emacs.d/.eslintrc.js ~/'
        cp ~/.emacs.d/.eslintrc.js ~/



echoCo 'cd'
        cd
echoCo 'npm install --save-dev \
                               eslint \
                               eslint-config-standard \
                               eslint-plugin-html \
                               eslint-plugin-import \
                               eslint-plugin-node \
                               eslint-plugin-promise \
                               eslint-plugin-standard'
        npm install --save-dev \
                               eslint \
                               eslint-config-standard \
                               eslint-plugin-html \
                               eslint-plugin-import \
                               eslint-plugin-node \
                               eslint-plugin-promise \
                               eslint-plugin-standard
