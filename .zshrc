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

