docker build --tag=birt .

docker image ls

    docker run -d -p 9999:8080 birt

    docker container ls

docker login

docker tag birt username/birt:latest

docker push username/birt:latest

docker volume create birt

docker volume ls

docker volume inspect birt

docker run -d -p 9999:8080 birt

docker run -d --name birt -v birt:/opt/tomcat/webapps/birt/reports birt:latest