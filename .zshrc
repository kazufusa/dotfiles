# include antigen settings
source ~/.zshrc.antigen

case "${OSTYPE}" in
# Linux
linux*)
     # python virtualenv
    if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        #export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
        source /usr/local/bin/virtualenvwrapper.sh
    fi
    ;;
# Mac(Unix)
darwin*)
     # Customize to your needs...
     export PATH=/opt/local/bin:/opt/local/sbin:$PATH
     export MANPATH=/opt/local/man:$MANPATH
     # python virtualenv
     PYTHON_VER=2.7
     export MACPORTS_PREFIX=/opt/local
     export VIRTUALENV_BIN=$MACPORTS_PREFIX/Library/Frameworks/Python.framework/Versions/$PYTHON_VER
     #export VIRTUALENVWRAPPER_VIRTUALENV=$VIRTUALENV_BIN/bin/virtualenv
     export PYTHONPATH=$MACPORTS_PREFIX/lib/python$PYTHON_VER/:$PYTHONPATH
     export WORKON_HOME=$HOME/.virtualenvs
     . $VIRTUALENV_BIN/bin/virtualenvwrapper.sh
    ;;
esac

 # multi version python virtualenv
 mkvenv () {
    base_python=`which python$1`
    mkvirtualenv --distribute --python=$base_python $2
 }

#z.sh settings
if [ ! -d $HOME/.zsh/z ] ; then
    cd $HOME/.zsh
    git clone https://github.com/rupa/z.git
fi
_Z_CMD=j
source ~/.zsh/z/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

#ruby rbenv
if [ -d $HOME/.rbenv ] ; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init - zsh)"
fi

