# syllabus
- build jar
- Dockerfile and Docker Compose
- Github Actions
- Push Docker image on dockerHub
- Deploy java image and mysql on kubernetes with Helm Chart 
- deploy traefik ingress contoller

## steps
1. build the jar 
first we can use `mvn`  to build the jar
`mvn clean package`  and to skip tests we can use `-DskipTests`

2. Dokcerfile and Docker Compose 
```
docker-compose build
docker-compose up
```
[the files is mentioned in Docker-files](Docker-files)

3. push image in dockerHub
```
docker tag sherifkhedr/capiter:capiter-task_java-app
docker push sherifkhedr/capiter:capiter-task_java-app
```
4. GitHub Actions for Pipeline
[files mentioned in mavenfile](.github/workflows)

5. Deploy Mysql and Java image on kubernest by Helm chart
> *Note: 
I don't used Minikube and instead I used my existing kubernetes cluster consist of one master node and 2 worker nodes;
 the cluster have Rook-Cehpfs as Persistent Storage*
 
 - ###### Deploy mysql with Helm Chart as custer with 3 instances ; i used [Bitnami Helm Chart](https://bitnami.com/stack/mysql/helm) for the deploy
 
 `kubectl create ns mydb`
  ```
 helm install mysql \
  --set global.storageClass=rook-cephfs\
  --set secondary.replicaCount=2\
  --set auth.rootPassword=mypassword\
  --set auth.database=springboot_mysql_example\
  --set auth.username=test\
  --set auth.password=test \
    bitnami/mysql -n mydb 
  ```
    
 > *Note:
    the previous command will create one master and 2 slaves also create `springboot_mysql_example` database and use `rook-cephfs` as persistent volume
    
- ###### Deploy java image on kubernetes
```
kubectl create ns myapp
helm create myapp
helm install myapp .
```


      
    
