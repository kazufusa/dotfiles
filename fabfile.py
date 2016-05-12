# vim: set fileencoding=utf-8 :
# Created:  2015-07-06

from fabric.api import env, settings, sudo, cd, run
from fabric.utils import puts
from fabric.colors import red, green
import cuisine
import os

def setup():
    env["CUISINE_MODE_LOCAL"] = False
    setup_packages()
    nvm()
    rbenv()
    pyenv()
    dotfiles()
    use_zsh()
    install_tig()

def setup_packages():
    cuisine.select_package('apt')
    puts(green('Installing Ubuntu packages'))
    with cuisine.mode_sudo():
        cuisine.package_update()
        cuisine.package_upgrade()
        cuisine.package_ensure([
            "aptitude",
            "build-essential",
            "curl",
            "git",
            "guake",
            "haskell-platform",
            "htop",
            "ibux-mozc",
            "libclang-dev",
            'libncursesw5-dev',
            "libssl-dev",
            "paco",
            "python3-dev",
            "tmux",
            "tree",
            "wget",
            "zip",
            "zsh",
            ])

def use_zsh():
    with cuisine.mode_sudo():
        cuisine.run("chsh -s `which zsh` $USER")

def install_tig():
    tar_gz_install(
            "https://github.com/jonas/tig/archive/tig-2.1.1.tar.gz",
            "LDLIBS=-lncursesw CFLAGS=-I/usr/include/ncursesw", 
            )

def tar_gz_install(url, option=""):
    archive = os.path.basename(url)
    package = archive.replace(".tar.gz", "")
    cuisine.run("wget {}".format(url), pty=False)
    cuisine.run("tar zxf {}".format(archive))
    directory = cuisine.run("""echo $(tar tvf {} | head -1 | egrep -o "[^ ]+/$")""".format(archive))

    with cuisine.cd(directory):
        cuisine.run("{} make".format(option))
        with cuisine.mode_sudo():
            cuisine.run("paco -lp {} \" {} make install\"".format(package, option))

    cuisine.run("rm -rf {} {}".format(archive, directory))

def git_clone(repo, path):
    if not cuisine.dir_exists(path):
        run("git clone --recursive {} {}".format(repo, path), pty=False)

def nvm():
    git_clone("https://github.com/creationix/nvm.git", "~/.nvm")

def pyenv():
    git_clone("git://github.com/yyuu/pyenv.git", "~/.pyenv")

def rbenv():
    git_clone("https://github.com/sstephenson/rbenv", "~/.rbenv")
    git_clone("https://github.com/sstephenson/ruby-build.git", "~/.rbenv/plugins/ruby-build")
    git_clone("https://github.com/sstephenson/rbenv-default-gems.git", "~/.rbenv/plugins/rbenv-default-gems")

def dotfiles():
    dotfiles = [
        [".pryrc",              "~/.pryrc"],
        [".tigrc",              "~/.tigrc"],
        [".zshrc",              "~/.zshrc"],
        [".vimrc",              "~/.vimrc"],
        [".vimrc.yaml",         "~/.vimrc.yaml"],
        [".rbenv/default-gems", "~/.rbenv/default-gems"],
    ]
    git_clone("https://github.com/kazufusa/dotfiles", "~/dotfiles")
    with cuisine.cd("~"):
        for target, sym in dotfiles:
            cuisine.run("ln -sf ~/dotfiles/{} {}".format(target, sym))

