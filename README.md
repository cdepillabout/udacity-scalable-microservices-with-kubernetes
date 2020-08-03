
Build the server monolith:

```console
$ cd src/github.com/udacity/ud615/app/
$ mkdir bin
$ go build -o bin/monolith ./monolith/
```

Build statically and create docker container:

```console
$ cd src/github.com/udacity/ud615/app/monolith
$ go build --tags netgo --ldflags '-extldflags "-lm -lstdc++ -static"'
$ docker build -t monolith:1.0.0 .
```

Tag the docker image and push to Docker Hub:

```console
$ docker tag monolith:1.0.0 cdepillabout/monolith:1.0.0
$ docker login
$ docker push cdepillabout/monolith:1.0.0
```

Run server monolith:

```console
$ ./bin/server -http 0.0.0.0:10080 -health 0.0.0.0:10081
```

Or, run the server monolith in docker, and get the IP:

```console
$ docker run -d monolith:1.0.0
$ docker inspect ...
```

In a different console, test the insecure endpoint:

```console
$ curl http://localhost:10080
```

Test the secure endpoint:

```console
$ curl http://localhost:10080/login -u user:password
{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE1OTU4MTE0NzIsImlhdCI6MTU5NTU1MjI3MiwiaXNzIjoiYXV0aC5zZXJ2aWNlIiwic3ViIjoidXNlciJ9.i12LFwX9nYAv-j7cjJhRL1MTlDHsNx5A1vVqDkb8F3g"}
$ curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE1OTU4MTE0NzIsImlhdCI6MTU5NTU1MjI3MiwiaXNzIjoiYXV0aC5zZXJ2aWNlIiwic3ViIjoidXNlciJ9.i12LFwX9nYAv-j7cjJhRL1MTlDHsNx5A1vVqDkb8F3g" http://localhost:10080/secure
```

------------------------------

Build the microservices:

```console
$ cd src/github.com/udacity/ud615/app/
$ mkdir bin
$ go build -o bin/hello ./hello/
$ go build -o bin/auth ./auth/
```

Build statically and create docker container:

```console
$ cd src/github.com/udacity/ud615/app/hello
$ go build --tags netgo --ldflags '-extldflags "-lm -lstdc++ -static"'
$ docker build -t hello:1.0.0 .
```

```console
$ cd src/github.com/udacity/ud615/app/auth
$ go build --tags netgo --ldflags '-extldflags "-lm -lstdc++ -static"'
$ docker build -t auth:1.0.0 .
```

Tag the docker images and push to Docker Hub:

```console
$ docker tag hello:1.0.0 cdepillabout/hello:1.0.0
$ docker tag auth:1.0.0 cdepillabout/auth:1.0.0
$ docker login
$ docker push cdepillabout/hello:1.0.0
$ docker push cdepillabout/auth:1.0.0
```

Run the microservices (in two different consoles):

```console
$ ./bin/hello -http 0.0.0.0:10082 -health 0.0.0.0:10083
```

```console
$ ./bin/auth -http :10090 -health :10091
```

In a different console, test the insecure endpoint:

```console
$ curl http://localhost:10082
```

Test the secure endpoint:

```console
$ curl http://localhost:10090/login -u user:password
{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE1OTU4MTE0NzIsImlhdCI6MTU5NTU1MjI3MiwiaXNzIjoiYXV0aC5zZXJ2aWNlIiwic3ViIjoidXNlciJ9.i12LFwX9nYAv-j7cjJhRL1MTlDHsNx5A1vVqDkb8F3g"}
$ curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE1OTU4MTE0NzIsImlhdCI6MTU5NTU1MjI3MiwiaXNzIjoiYXV0aC5zZXJ2aWNlIiwic3ViIjoidXNlciJ9.i12LFwX9nYAv-j7cjJhRL1MTlDHsNx5A1vVqDkb8F3g" http://localhost:10082/secure
```
