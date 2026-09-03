#!/usr/bin/env bash
# Port-forward Prometheus rồi mở browser
set -e
ns=$(kubectl get ns -o name | sed 's|namespace/||' | fzf --prompt="namespace> " --height=100%)
[ -z "$ns" ] && exit 0
svc=$(kubectl get svc -n "$ns" -o name | sed 's|service/||' | fzf --prompt="service> " --height=100% --query=prometheus)
[ -z "$svc" ] && exit 0
port=$(kubectl get svc -n "$ns" "$svc" -o jsonpath='{.spec.ports[0].port}')
echo "Port-forward $ns/$svc :9090 -> $port (Ctrl-C để dừng)"
(sleep 2 && open "http://localhost:9090") &
kubectl port-forward -n "$ns" "svc/$svc" 9090:"$port"
