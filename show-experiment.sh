
export NS=$(sh ns)

kubectl get experiment  -n $NS -w
