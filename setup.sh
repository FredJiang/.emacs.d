#! /bin/bash


echo 'git pull'
git pull



echo 'git submodule init'
git submodule init



echo 'git submodule update'
git submodule update




function install_cscope {
    if [ ! -d ~/cscope-15.8b ]; then
        echo 'install install_cscope'
        cd
        echo 'pwd' `pwd`
        if [ ! -f ~/cscope-15.8b.tar.gz ]; then
            wget "https://jaist.dl.sourceforge.net/project/cscope/cscope/15.8b/cscope-15.8b.tar.gz"
        fi
        tar -zxvf cscope-15.8b.tar.gz
        cd cscope-15.8b
        ./configure
        make
        sudo make install
        sudo cp contrib/xcscope/cscope-indexer /usr/local/bin/
        sudo chmod +x /usr/local/bin/cscope-indexer
        cp contrib/xcscope/xcscope.el ~/.emacs.d/mypackages/
    fi
}

function install_clang {
    if which clang >/dev/null; then
        echo 'clang has installed'
    else
        if which yum >/dev/null; then
            echo 'sudo yum install epel-release'
            sudo yum install epel-release
            echo 'sudo yum install -y clang'
            sudo yum install -y clang
        else
            echo 'yum not exist'
        fi
    fi
}

function install_clang_format {
    if which clang-format >/dev/null; then
        echo 'clang-format has installed'
    else
        if which brew >/dev/null; then
            echo 'brew install clang-format'
            brew install clang-format
        else
            echo 'brew not exist'
        fi
    fi
}


case "$OSTYPE" in
  solaris*)
    echo "SOLARIS" ;;
  darwin*)
    echo "OSX"
    install_clang_format
#    cp ~/.emacs.d/mypackages/all-the-icons/fonts/*.ttf /Library/Fonts/
    ;; 
  linux*)
    echo "LINUX"
    install_cscope
    install_clang
    ;;
  bsd*) 
      echo "BSD" ;;
  msys*) 
     echo "WINDOWS" ;;
  *)
    echo "unknown: $OSTYPE" ;;
esac


echo 'cd ~/.emacs.d'
cd ~/.emacs.d
echo 'pwd' `pwd`

echo 'git submodule init'
git submodule init

echo 'git submodule update'
git submodule update

echo 'cp ~/.emacs.d/mypackages/.jsbeautifyrc ~/'
cp ~/.emacs.d/mypackages/.jsbeautifyrc ~/

echo 'cd'
cd


if which js-beautify >/dev/null; then
    echo 'js-beautify has installed'
else
    if which npm >/dev/null; then
        echo 'npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install js-beautify'
        npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install js-beautify
    else
        echo 'npm not exist'
    fi
fi

if which eslint >/dev/null; then
    echo 'eslint has installed'
else
    if which npm >/dev/null; then
        echo 'npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install eslint'
        npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist -g install eslint
    else
        echo 'npm not exist'
    fi
fi


if [ -d $HOME/.all-the-icons-fonts ]
    then
        echo "$HOME/.all-the-icons-fonts exist"
    else
        echo "$HOME/.all-the-icons-fonts not exist"
        echo "mkdir $HOME/.all-the-icons-fonts"
              mkdir $HOME/.all-the-icons-fonts
fi
