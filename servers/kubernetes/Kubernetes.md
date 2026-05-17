# K8s

## Concepts

### Master
- apiserver = master = unique entry point
- cluster store (etcd) : key-value store
- kube-control-manager ( name controller, endpoints controller, ..)
- Scheduler

### Nodes ( minions )
- Kublet 
	Post 10255
- Container engine
	docker, rkt
- kube-proxy
	kubernetes networking, unique Ip, load balancer

### Pods
- group of containser
- unit of scale.
- not resurected.

### Replication controllers
- scales pods
- desired states

### Services
- stable networking
- single ip, dns to pods
- based on label selectors

### Deployments
- rolling updates and rollbacks


## Usage

~~~
minikube start
kubectl config current-context
kubectl get nodes
minikube dashboard
minikube stop
minikube delete
~~~