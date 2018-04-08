## Docker

#### Build image
docker build -t backend-aspnet .

#### Run container
docker run -d -p 8080:80 --name backendapp backend-aspnet

## Test if it's working
Start up your browser and visit http://localhost:8080/api/pixels/test
It's working if you get a 'test is working' message.