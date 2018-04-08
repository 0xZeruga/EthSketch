## Docker

#### Build image
docker build -t backend-aspnet .

#### Run container
docker run -d -p 8080:80 --name backendapp backend-aspnet
