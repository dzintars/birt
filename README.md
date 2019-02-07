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

docker run -d -p 9999:8080 --name birt -v birt:/opt/tomcat/webapps/birt/reports birt:latest

# Enable TLS (HTTPS) - need to modify /opt/tomcat/webapps/birt/WEB-INF/viewer.properties and uncomment base_url variable. Change url to domain and port your Birt application will be accessible.
# Restart container
docker exec -it birt bash
apt install nano
nano /opt/tomcat/webapps/birt/WEB-INF/viewer.properties

# edit url

# Restart container
