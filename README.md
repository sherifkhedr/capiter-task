# syllabus
1. build jar
2. Dockerfile and Docker Compose
3. Github Actions
4. Push Docker image on dockerHub
5. Deploy java image and mysql on kubernetes with Helm Chart 
6. install traefik ingress contoller
7. install Prometheus on kubernetes
8. How to debug mysql and java performance

## steps
1. build the jar 
first we can use `mvn`  to build the jar
`$ mvn clean package`  and to skip tests we can use `-DskipTests`

2. Dokcerfile and Docker Compose 
```
$ docker-compose build
$ docker-compose up
```
[the files is mentioned in Docker-files](Docker-files)

3. push image in dockerHub
```
$ docker tag sherifkhedr/capiter:capiter-task_java-app
$ docker push sherifkhedr/capiter:capiter-task_java-app
```
4. GitHub Actions for Pipeline
[files mentioned in mavenfile](.github/workflows)

5. Deploy Mysql and Java image on kubernest by Helm chart
> *Note: 
I don't used Minikube and instead I used my existing kubernetes cluster consist of one master node and 2 worker nodes;
 the cluster have Rook-Cehpfs as Persistent Storage*
 
 - ###### Deploy mysql with Helm Chart as custer with 3 instances ; i used [Bitnami Helm Chart](https://bitnami.com/stack/mysql/helm) for the deploy
 
 `$ kubectl create ns mydb`
  ```
 $ helm install mysql \
  --set global.storageClass=rook-cephfs\
  --set secondary.replicaCount=2\
  --set auth.rootPassword=mypassword\
  --set auth.database=springboot_mysql_example\
  --set auth.username=test\
  --set auth.password=test \
    bitnami/mysql -n mydb 
  ```
    
>* *Note:
the previous command will create one master and 2 slaves also create `springboot_mysql_example` database and use `rook-cephfs` as persistent volume*
    
- ###### Deploy java image on kubernetes
```
$ kubectl create ns myapp
$ helm create myapp
$ helm install myapp .
```

6. Deploy Traefik as Ingress-Controller 
>* *Note: the purpose of using [traefik](https://doc.traefik.io/traefik/getting-started/install-traefik/) instead of nginx-controler to avoid annotaion problems.*
```
$ kubectl create ns traefik-ingress
$ helm repo add traefik https://helm.traefik.io/traefik
$ helm repo update
$ helm install --namespace=traefik-ingress \
    traefik traefik/traefik
```
- create ingress file mentioned in 

- ######Bonus:  Deploy MetalLB as a load Balancer in from of Ingress-Controller , this is Bonus from me
```
MetalLB configs are set in values.yaml under configInLine:
configInline:
  address-pools:
   - name: default
     protocol: layer2
     addresses:
     - 192.168.1.240-192.168.1.250

$ helm repo add metallb https://metallb.github.io/metallb
$ helm install metallb metallb/metallb -f values.yaml
```
###### to caccess from my browser
```
cat >> /etc/hosts
<metallb ip>  myapp.capiter.com   
```
## Resourses that used in this Task
- [Kubernetes.io](https://kubernetes.io/)
- [Traefik.io](https://doc.traefik.io/traefik/)
- [MetalLB](https://metallb.universe.tf/installation/)


