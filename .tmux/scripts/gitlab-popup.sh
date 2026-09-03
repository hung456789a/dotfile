#!/usr/bin/env bash
# Menu thao tác GitLab nhanh bằng glab + fzf
set -e
choice=$(printf '%s\n' \
  "mr list        : xem MR đang mở" \
  "mr view        : xem MR của branch hiện tại" \
  "ci status      : trạng thái pipeline" \
  "ci view        : xem pipeline chi tiết" \
  "issue list     : xem issues" \
  "repo view      : mở repo trên browser" \
  | fzf --prompt="glab> " --height=100% | awk -F: '{print $1}' | xargs)
[ -z "$choice" ] && exit 0
glab $choice
read -n1 -p "Nhấn phím bất kỳ để đóng..."
