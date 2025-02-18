# dotfiles

## zsh

- [x] zim
- [x] abbreviations
- [x] history
- [x] fzf
  - [x] history search
- [x] zoxide

## tmux

- [x] Copy/Paste on mac
- [x] good style

## vim

### Install required python3 package in Mac

```sh
$ brew deps vim | grep python # determine python version
python@3.10
$ brew link python@3.10 --force --overwrite # make links to the dependent python
$ which python3
/usr/local/bin/python3

$ pip3 install -U pynvim # install pynvim
```

