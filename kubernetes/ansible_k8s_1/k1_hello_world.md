
# Ansible for Kubernets

## Chapter 1 - Hello World!

enable autocomplete
~~~
source <( kubectl completion bash )
source <( minikube completion bash )              # autocomplet for minikube
~~~

~~~
minikube start --cpus 4 --memory 4g               # start minikube
eval $(minikube docker-env)                       # connect local docker to minikube one
cd ~/git/guy/hello-go                             # location for my Dockerfile and go prog
docker build -t hello-go .                        # build image with name (tag)
kubectl create deployment hello --image=hello-go  # create Deployment resource
kubectl get deployment                            # check its status. READY 0/1
kubectl get pods                                  # check error in STATUS
kubectl describe pods                             # see more details about error
kubectl edit deployments.apps hello               # fix deployment. imagePullPolicy from Always to IfNotPresent
kubectl expose deployment hello --type=LoadBalancer --port=8180 # expose deployment
kubectl get services hello                        # check its expternal IP ( not working with minikube )
minikube service hello                            # ask minikube to simulate external connection, or teke port from previous 
kubectl logs -l app=hello                         # check app logs
kubectl scale deployments/hello --replicas=4      # scale up
kubectl get deployments                           # ckeck it's status

~~~

log per pod
~~~
for pod in $(kubectl get po -l app=hello -oname); do 
    echo $pod; 
    kubectl logs $pod; 
done;
~~~

clean up
~~~
kubectl delete service hello
kubectl delete deployment hello
docker rmi hello-go
minikube stop 
~~~