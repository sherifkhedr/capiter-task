# syllabus
- build jar
- Dockerfile and Docker Compose
- Github Actions
- Push Docker image on dockerHub
- Create Helm Chart for Java app
- deploy traefik ingress contoller

## steps
1. build the jar 
first we can use `mvn`  to build the jar
`mvn clean package`  and to skip tests we can use `-DskipTests`

2. Dokcerfile and Docker Compose 
`docker-compose build`
`docker-compose up`
[the files is mentioned in Docker-files](Docker-files)

3. push image in dockerHub
`docker tag sherifkhedr/capiter:capiter-task_java-app`
`docker push sherifkhedr/capiter:capiter-task_java-app `

