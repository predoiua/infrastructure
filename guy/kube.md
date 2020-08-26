
# K3s

## Get kube config locally

~~~
scp predoiua@192.168.10.143:~/.kube/config ~/.kube/config-msi
export KUBECONFIG=~/.kube/config-msi
kubectl version --client
kubectl get nodes
source <(kubectl completion bash)
ansible all -a "shutdown now" -b
~~~

## Prometheus + Grafana

https://github.com/coreos/kube-prometheus

~~~
kubectl get pods -n monitoring
kubectl get ingress -n monitoring


kubectl create namespace drupal
kubectl apply -f drupal.yaml
kubectl get pods -n drupal -o wide
~~~


https://github.com/carlosedp/cluster-monitoring
https://medium.com/@carlosedp/building-a-hybrid-x86-64-and-arm-kubernetes-cluster-e7f94ff6e51d