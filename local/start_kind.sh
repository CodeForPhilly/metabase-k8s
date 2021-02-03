# Create kind cluster
kind create cluster --config=local/kind_config.yml
sleep 10

# Set context
kubectl cluster-info --context kind-kind

# Adds ingress
# This version of quickstart known to work: https://raw.githubusercontent.com/projectcontour/contour/release-1.11/examples/render/contour.yaml
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
kubectl patch daemonsets -n projectcontour envoy -p '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'
