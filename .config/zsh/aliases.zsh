# --- kubectl aliases ---
alias k='kubectl'

# get
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgpw='kubectl get pods -w'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kgn='kubectl get nodes'
alias kgi='kubectl get ingress'
alias kgsec='kubectl get secrets'
alias kgcm='kubectl get configmaps'
alias kge='kubectl get events --sort-by=.lastTimestamp'

# describe / edit / delete
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias ke='kubectl edit'
alias kdel='kubectl delete'

# logs / exec
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kx='kubectl exec -it'

# apply / dry-run
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdr='kubectl apply --dry-run=client -o yaml -f'

# context / namespace (fzf)
kctx() {
  local ctx=$(kubectl config get-contexts -o name | fzf --prompt="context> " --height=40%)
  [ -n "$ctx" ] && kubectl config use-context "$ctx"
}
kns() {
  local ns=$(kubectl get ns -o name | sed 's|namespace/||' | fzf --prompt="namespace> " --height=40%)
  [ -n "$ns" ] && kubectl config set-context --current --namespace="$ns"
}
alias kcur='kubectl config current-context'

# cluster shortcuts
alias knhc='kubectl --context aks-ai-prod-weu -n nhc-property-cockpit'
alias kdev='kubectl --context aks-ai-dev-weu'
alias kstage='kubectl --context aks-ai-stage-weu'

# pick pod bằng fzf rồi xem logs / exec
klp() {
  local pod=$(kubectl get pods -o name | sed 's|pod/||' | fzf --prompt="logs pod> " --height=40%)
  [ -n "$pod" ] && kubectl logs -f "$pod" "$@"
}
kxp() {
  local pod=$(kubectl get pods -o name | sed 's|pod/||' | fzf --prompt="exec pod> " --height=40%)
  [ -n "$pod" ] && kubectl exec -it "$pod" -- sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

# completion cho alias k
compdef k=kubectl 2>/dev/null

# --- dotfiles (bare repo) ---
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
