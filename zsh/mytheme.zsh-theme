# murilasso, muse
# venv, rvenv は入力行末尾において消したい
# setopt promptsubst
# autoload -U add-zsh-hook
# 
# PROMPT_SUCCESS_COLOR=$FG[117]
# PROMPT_FAILURE_COLOR=$FG[124]
# PROMPT_VCS_INFO_COLOR=$FG[242]
# PROMPT_PROMPT=$FG[077]
# GIT_DIRTY_COLOR=$FG[133]
# GIT_CLEAN_COLOR=$FG[118]
# GIT_PROMPT_INFO=$FG[012]
# 
# ZSH_THEME_GIT_PROMPT_PREFIX="("
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%})"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}✘"
# ZSH_THEME_GIT_PROMPT_CLEAN=" %{$GIT_CLEAN_COLOR%}✔"
# ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}✚%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%}✹%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}✖%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}═%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}✭%{$reset_color%}" 

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local rvm_ruby='%{$terminfo[bold]$fg[red]%}[RBENV:$(rvm_prompt_info || rbenv_prompt_info)]%{$reset_color%}'
local venv='%{$terminfo[bold]$fg[red]%}[VENV:`echo $VIRTUAL_ENV | cut -d/ -f5`]%{$reset_color%}'

PROMPT="${user_host}:${current_dir}
%B$%b "
# PROMPT="${user_host}:${current_dir}
# %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}ᐅ%{$reset_color%} "
RPROMPT="${venv}${rvm_ruby}"
# necessary or not?
# RPS1="${return_code}"

