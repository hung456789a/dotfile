#!/usr/bin/env bash
# Chọn context bằng fzf rồi mở k9s
set -e
ctx=$(kubectl config get-contexts -o name | fzf --prompt="k8s context> " --height=100%)
[ -n "$ctx" ] && k9s --context "$ctx"
