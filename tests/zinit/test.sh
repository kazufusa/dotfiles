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
  eval p=$p
  t [ -d $p ] || echo $p if not found
done <./directories.txt

while read p; do
  eval p=$p
  t [ -x $p ] || echo $p is not executable
done <./executables.txt

exit $gst
