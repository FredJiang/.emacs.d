#! /bin/sh

function install_cscope {
    if [ ! -f ~/cscope-15.8b ]; then
        echo 'install install_cscope'
        cd
        wget "https://jaist.dl.sourceforge.net/project/cscope/cscope/15.8b/cscope-15.8b.tar.gz"
        tar -zcvf cscope-15.8b.tar.gz
        cd cscope-15.8b
        ./configure
        make
        sudo make install
        sudo cp contrib/xcscope/cscope-indexer /usr/local/bin/
        sudo chmod +x /usr/local/bin/cscope-indexer
        cp contrib/xcscope/xcscope.el ~/.emacs.d/mypackages/
    fi
}

case "$OSTYPE" in
  solaris*)
    echo "SOLARIS" ;;
  darwin*)
    echo "OSX" ;; 
  linux*)
    echo "LINUX"
    install_cscope
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
echo 'pwd' `pwd`

if which yum >/dev/null; then
    echo 'sudo yum install -y clang'
    sudo yum install -y clang
else
    echo yum not exist
fi

if which brew >/dev/null; then
    echo 'brew install clang-format'
    brew install clang-format
else
    echo brew not exist
fi

if which npm >/dev/null; then
    echo 'npm -g install js-beautify'
    npm -g install js-beautify
else
    echo npm not exist
fi

