#!/usr/bin/env bash
# 依次渲染三个 Quarto 项目：根落地页、英文书、中文书。
# 顺序固定为 根 -> en-US -> zh-CN，根项目会清理它记录的产物，必须先渲染。
set -euo pipefail
cd "$(dirname "$0")"

# 两个语言版本的章节文件必须一一对应，否则语言切换会跳到不存在的页面
diff <(cd en-US && find . -name '*.qmd' -not -path './_extensions/*' | sort) \
     <(cd zh-CN && find . -name '*.qmd' -not -path './_extensions/*' | sort)

quarto render .
quarto render en-US
quarto render zh-CN

echo
echo "完成，产物在 docs/："
echo "  docs/index.html      语言选择页"
echo "  docs/en-US/          英文书"
echo "  docs/zh-CN/          中文书"
