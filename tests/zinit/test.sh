#!/bin/sh
cd `dirname $0`

gst=0

t() {
  "$@"
  local s=$?
  gst=$((gst+$s))
  return $s
}

while read p; do
  t [ -d $HOME/.zinit/plugins/"$p" ] || echo $HOME/.zinit/plugins/$p not found
done <./directories.txt

while read p; do
  eval p=$p
  t [ -x $p ] || echo $p is not executable
done <./executables.txt

exit $gst
