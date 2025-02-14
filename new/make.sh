#!/bin/sh
# もし make がインストール済みなら、それを利用する
if command -v make >/dev/null 2>&1; then
    exec make "$@"
fi

# 以降は make が存在しない場合のフォールバック処理

TARGET=${1:-all}  # 引数がなければ 'all' をデフォルトターゲットとする

if [ ! -f Makefile ]; then
    echo "Error: Makefile が見つかりません。"
    exit 1
fi

# awk を使って、指定ターゲットのコマンドを抽出
cmds=$(awk -v tgt="$TARGET" '
BEGIN { in_target=0; found=0 }
/^[^[:space:]]+:/ {
  # ターゲット行を検出
  split($1, arr, ":")
  if (arr[1] == tgt) {
      in_target=1; found=1;
      next
  } else if (in_target) {
      # 別のターゲットが現れたら終了
      in_target=0
  }
}
in_target && /^[[:space:]]/ {
  # インデントされた行はコマンド行とみなす（先頭の空白を除去）
  sub(/^[[:space:]]+/, "", $0)
  print $0
}
END { if (!found) exit 1 }
' Makefile)

if [ $? -ne 0 ]; then
    echo "Error: ターゲット '$TARGET' が Makefile 内に見つかりません。"
    exit 1
fi

echo "ターゲット '$TARGET' を実行します:"
# 抽出した各コマンドを実行
echo "$cmds" | while IFS= read -r cmd; do
    [ -z "$cmd" ] && continue
    echo "+ $cmd"
    sh -c "$cmd" || { echo "Error: コマンド失敗: $cmd"; exit 1; }
done
