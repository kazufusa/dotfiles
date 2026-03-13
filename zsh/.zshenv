ZDOTDIR=$HOME/.config/zsh

# Usage: _eval_cache <cache_file> <validator_file> <cmd> [args...]
# Sources <cache_file>, regenerating it by running <cmd> when:
#   - cache doesn't exist, or
#   - <validator_file> is newer than cache
function _eval_cache() {
  local cache=$1 validator=$2
  shift 2
  if [[ ! -f $cache || $validator -nt $cache ]]; then
    mkdir -p ${cache:h}
    "$@" >| $cache
  fi
  source $cache
}
