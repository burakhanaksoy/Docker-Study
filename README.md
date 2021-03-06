<h1>Docker Study</h1>
<p align="center">
  
  <img width="450" height="350" src="https://user-images.githubusercontent.com/31994778/123071595-76f77100-d41d-11eb-8641-93f18c90d28c.png">
  
</p>

<b>Table Of Contents</b> |
------------ | 
[What is Docker?](#first) 
[VM vs Container](#vm-vs-cont)
[Drawbacks of VMs](#vm-drawbacks)
[Docker Architecture](#architecture)
[Development Workflow](#workflow)
[Docker Demo](#action)
[Image vs Container](#image-vs-cont)
[Linux Command Line](#linux-cli)
[Port Binding](#port-binding)
[Docker Network](#docker-network)
[Docker Compose](#docker-compose)
[Dockerfile](#dockerfile)
[Deploy Containerized App](#deploy-app)
[Run the APP](#run-the-app)
[Docker Volumes](#docker-volumes)
[Credits](#credits)
 
 <p id="first">
 <h2>What is Docker?</h2>
 </p>
 
 <p>
  <b><i>"Docker is a platform for building, running, and shipping applications in a consistent manner, so if your application run flawlessly in your development machine, it can run and function the same way in other machines."</b></i>
 </p>

If you have faced with the problem of smoothly running your application in a development machine, but not working in a different machine, this might be stemming from:

- One or more files are missing
- Software version mismatch
- Different configuration settings, such as env variables and etc.

In these cases, Docker comes to the rescue.

<b>With Docker, we can package our application with whatever configuration, files it needs and use it any machine we want</b>

<p align="center">
  <img width="350" height="250" alt="Screen Shot 2021-06-23 at 12 33 10 PM" src="https://user-images.githubusercontent.com/31994778/123073806-6cd67200-d41f-11eb-8693-bb2a330f848e.png">

</p>

As it is seen here, we can package our applications with docker so that it uses specific versions of technologies needed. This will cause every machine to be using the same versions.

<b>When you tell Docker to bring up your application with `docker-compose up`, Docker will automatically download and run these dependencies inside an isolated environment, called `Container`.</b>

<p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 12 39 07 PM" src="https://user-images.githubusercontent.com/31994778/123074521-0c940000-d420-11eb-9efc-c9a2f9d5e54b.png">
</p>

<b>This is the beauty of Docker! This isolated environment allows multiple applications use different versions of software side by side.</b>

As you can see here, while one application uses Node version 14, the other one uses Node version 9, and they can run side by side on the same machine without messing up with each other.


```diff
- Also, if we want to get rid of one application, i.e., we don't want to use it anymore, then we can erase that app and its dependencies with a single Docker command. This helps us not storing that application's dependencies in our machine, but instead in the docker container.

```

<p id="vm-vs-cont">
<h2>Virtual Machines vs Containers</h2>
</p>

<b>Container</b> | <b>VM</b>
------------ | ------------- 
An isolated environment for running an application | An abstraction of a machine or physical hardware, so that we can run several VMs in a physical machine |

<h3>Use of Virtual Machines</h3>

Regarding software development, we can run our applications in isolation inside virtual machines.

So, on a single physical machine, we can run two applications in isolation on two different virtual machines with each app has dependencies they need.

<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 1 01 19 PM" src="https://user-images.githubusercontent.com/31994778/123077927-297e0280-d423-11eb-82fa-792b8c339edd.png">
</p>

All these are running on the same machine but with different isolated environments. That's one of the benefits of virtual machines.

<p id="vm-drawbacks">
<h3>Problems</h3>
</p>

- Each virtual machine needs a copy of an OS that needs to be licensed, patched, and monitored.
- Slow to start, because the entire OS needs to be booted up, just like a physical computer.
- Resource intensive(Each VM runs with depending on physical resources such as RAM, HDD, CPU and etc.)
- So if you run multiple VMs in a single computer, the computer resources must be portioned between these VMs.
- This limits the number of VMs that we can run on a physical machine...
- Containers doesn't have this limitation..

<h3>Containers</h3>

- Allow running multiple apps in isolation
- Lightweight(doesn't need a full OS)
- All containers on a single machine share the OS of the host.
- This means we need to license, patch, and monitor a single operating system.
- Also, since the OS is dependent on the host, the container will start up pretty quickly.
- Need less hardware resources.
- This means in a host, we can run 10s and 100s of containers side by side.

<p id="architecture">
<h2>Docker Architecture</h2>
</p>

Docker uses a `Client-Server` architecture. So it has a client component that talks to the server component using a `REST API`.

<p align="center">
<img width="450" alt="Screen Shot 2021-06-23 at 1 18 30 PM" src="https://user-images.githubusercontent.com/31994778/123080372-87134e80-d425-11eb-9235-fa91a8027ae7.png">
</p>

The `Server`, also called `Docker Engine`, sits on the background and takes care of building and running docker containers.

<p align="center">
<img width="450" alt="Screen Shot 2021-06-23 at 1 21 10 PM" src="https://user-images.githubusercontent.com/31994778/123080716-e5d8c800-d425-11eb-91fc-3b4c88746c9d.png">
</p>

Technically a container is just a process, like the other processes running on a computer.

<b>Before, we said that containers share the OS of the host. But in fact, they share the `Kernel` of the host. Kernel is the core of the OS, it manages all aplications and hardware resources. Every OS has its own kernel, that's why we cannot run a Windows application on Mac or Linux, because under the hood this application talks to the Kernel of the underlying OS.</b>

So,

- On a Linux machine, we can only run Linux containers.
- On a Windows machine, we can run both Linux and Windows containers, because Win10 is now shipped with a custom built Linux kernel.
- On a Mac machine, since Mac doesn't have a container supporting kernel, Docker runs a lightweight Linux VM to run the containers.

<p align="center">
<img width="450" alt="Screen Shot 2021-06-23 at 1 28 39 PM" src="https://user-images.githubusercontent.com/31994778/123081760-f63d7280-d426-11eb-8c47-06a7de2c3fd2.png">
</p>

<p id="workflow">
<h2>Development Workflow</h2>
</p>

1- We take an application and `dockerize` it. This means to make a small change so that it can be run by Docker.
 - How? We just add a `Dockerfile` to it.
 - `Dockerfile` is a plaintext file that includes instructions that Docker uses to package up this application into an image.
 - This image contains everything our application needs to run.

<p align="center">

<img width="450" alt="Screen Shot 2021-06-23 at 1 50 41 PM" src="https://user-images.githubusercontent.com/31994778/123084652-128ede80-d42a-11eb-8140-f45ffacdaafa.png">
</p>

The image contains:

- A cut-down OS
- A runtime environment(e.g., Python)
- Application files
- Third-party Libraries
- Environment variables

We create a Dockerfile and give it to Docker for packaging our application into an image.

<b>Once we have an image, we tell Docker to start a `Container` using that image. Through `docker run ...` we tell Docker to start that application inside a container, an isolated environment.</b>

We can push this image into `DockerHub`. DockerHub to Docker is like Github to Git. It's a storage for Docker images anyone can use.

<b>Once our application image is on DockerHub, we can put it on any machine that runs Docker</b>

<p align="center">
  <img width="550" alt="Screen Shot 2021-06-23 at 2 17 43 PM" src="https://user-images.githubusercontent.com/31994778/123087949-d2315f80-d42d-11eb-898d-d5477f8279f3.png">
</p>

<p id="action">
<h2>Docker in Action</h2>
</p>

We are going to make a small demo. In this demo, we will `dockerize` our 'hello-docker' application.

1- Add `Dockerfile` inside your project. It's important that Dockerfile, with capital'D'.

<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 2 57 33 PM" src="https://user-images.githubusercontent.com/31994778/123092631-5d612400-d433-11eb-8b0a-67b10b4f1625.png">
</p>

Here, we have our main.py, which we want to run in a Docker container, and our Dockerfile.

2- Inside `Dockerfile`
<p align="center">
<img width="506" alt="Screen Shot 2021-06-23 at 2 59 19 PM" src="https://user-images.githubusercontent.com/31994778/123092859-9d280b80-d433-11eb-95ab-5e2d7cd62e2a.png">
</p>

We have:
- `FROM`: FROM is used for setting a baseImage to use for subsequent instructions. FROM must be the first instruction in a Dockerfile. Also, a base image is an image we pull from DockerHub on which we build our Dockerfile. Here, we use python:alpine, which is a Python image that runs on a Linux container which has `alpine` distribution.
- `COPY`: COPY is used for copying files we want to the base image of choice. Here, using `.` is to say that we want to copy every file in the directory to `/app` directory. Important thing to note is that `/app` is located on the image, not on our local machine.
- `WORKDIR`: WORKDIR is used for setting up the working directory of the base image. Here, by setting it to `/app`, we declare that the commands we run will be run on this directory, unless otherwise stated.
- `CMD`: CMD stands for command. This is the same thing that we use to run anything on the terminal. With this logic, to run main.py, we just write `CMD python main.py`.

3- Having written the Dockerfile, we can create an image by `docker build -t hello-docker .`.
<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 3 10 14 PM" src="https://user-images.githubusercontent.com/31994778/123094077-24c24a00-d435-11eb-913a-ce00f0ccc80b.png">
</p>

4- We need to check whether our image is created successfully by `docker image ls`

<p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 3 13 02 PM" src="https://user-images.githubusercontent.com/31994778/123094409-8682b400-d435-11eb-915d-e53e0226b5eb.png">

</p>

We can also verify this from `Docker Desktop` app.

<p align="center">
  <img width="600" alt="Screen Shot 2021-06-23 at 3 14 11 PM" src="https://user-images.githubusercontent.com/31994778/123094613-c053ba80-d435-11eb-80e1-2120b6cf3379.png">

</p>

5- Test!

With the command `docker run <image-id>` we have

<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 3 17 56 PM" src="https://user-images.githubusercontent.com/31994778/123094983-35bf8b00-d436-11eb-950c-462c123ba249.png">
</p>

6- We need to push the image to DockerHub so that we can use the image on another machine.

create a repository..

<p align="center">
<img width="600" alt="Screen Shot 2021-06-23 at 3 19 07 PM" src="https://user-images.githubusercontent.com/31994778/123095130-630c3900-d436-11eb-8c5a-0174f523f577.png">
</p>

Then, push..

<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 3 21 50 PM" src="https://user-images.githubusercontent.com/31994778/123095455-c5653980-d436-11eb-91be-17d4fc921a92.png">
</p>

7- Test through `play-with-docker`

Go [here](https://labs.play-with-docker.com/)

Pull the Docker image with `docker pull username/repository:tag`.

<p align="center">
<img width="500" alt="Screen Shot 2021-06-23 at 3 29 22 PM" src="https://user-images.githubusercontent.com/31994778/123096709-0ad63680-d438-11eb-861a-9f792d23519e.png">
</p>

And run `docker run username/repository:tag`

<p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 3 33 06 PM" src="https://user-images.githubusercontent.com/31994778/123096977-5852a380-d438-11eb-9c80-ee8c3f1c44e6.png">

</p>

<p id="image-vs-cont">
<h3>Image vs Container</h3>
</p>

<b>Image</b> | <b>Container</b>
------------ | ------------- 
Blueprint of the container | Instance of the image |
Image is a logical entity | Container is a real world entity |
Image is created only once | Containers are created any number of times using image. |
Images are immutable | Containers changes only if old image is deleted and new is used to build the container. |
Images does not require computing resource to work. | Containers requires computing resources to run as they run as Docker Virtual Machine. |
To make a docker image, you have to write script in Dockerfile. | To make container from image, you have to run `docker build <image-name>` command |
Docker Images are used to package up applications and pre-configured server environments. | Containers use server information and file system provided by image in order to operate. |
Images can be shared on Docker Hub. | It makes no sense in sharing a running entity, always docker images are shared. |
There is no such running state of Docker Image. | Containers uses RAM when created and in running state. |

<p id="linux-cli">
<h2>Linux Command Line</h2>
</p>

<b><i>We need to know about Linux CLI since Docker has its foundations in Linux, this is, Docker is built on basic Linux concepts.</b></i>

Go [here](https://hub.docker.com/_/ubuntu) and pull Ubuntu distribution of Linux

After the image is pulled, execute `docker run -it ubuntu`. This will run the image `interactively`

<p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 4 16 05 PM" src="https://user-images.githubusercontent.com/31994778/123103091-5ab7fc00-d43e-11eb-9959-e9575d8768d9.png">
</p>

Here, we successfully got to the shell. `root@574ab7f5810e:/#` means the following:

- `root` represents the currently logged in user. `root` user has the highest priviledges.
- `574ab7f5810e` is the name of the machine.
- `/` represents where we are in the file system. This is the root directory. The root directory is the highest directory in the system.
- `#` means we have the highest priviledges because we logged in as `root`. If we logged in as a normal user, we'd see `$`.

<p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 4 22 25 PM" src="https://user-images.githubusercontent.com/31994778/123104109-56401300-d43f-11eb-9d45-f4df0747e8d2.png">
</p>

- Echo prints out the value of what is called
- whoami prints the current logged in user
- Echo $0 prints the location of the shell program
- history prints the history of commands executed
- !<number> runs the command listed in history
- Linux is case sensitive and uses `/` for directories
- pwd prints the working directory (print working directory)

<h3>Package Managers</h3>
  
In software development, we currently use package managers such as `pip`, `npm` and so on.
  
In Linux, we have `apt` (advanced package tool)

  We can use `apt` to install packages(executable files)
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 4 49 12 PM" src="https://user-images.githubusercontent.com/31994778/123108277-f64b6b80-d442-11eb-89e9-df8b1fa88de8.png">
  </p>
  
  Here, we just installed Python3

  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 4 50 45 PM" src="https://user-images.githubusercontent.com/31994778/123108563-30b50880-d443-11eb-85db-49b08a443844.png">
  </p>
  
  <h3>Linux File System</h3>
  
  
  <p align="center" float="left">
  <img width="350" height="280.91" alt="Screen Shot 2021-06-23 at 4 53 19 PM" src="https://user-images.githubusercontent.com/31994778/123109002-90abaf00-d443-11eb-9031-56c7a3d33c2b.png"> 
    <img width="350" alt="Screen Shot 2021-06-23 at 4 53 29 PM" src="https://user-images.githubusercontent.com/31994778/123109027-93a69f80-d443-11eb-8dd9-dfa6940f1def.png">
  </p>
 
  <b>In Linux, everything is a file!</b>
  
  <p id="port-binding">
  <h2>Port Binding</h2>
  </p>
  
  <i><b>Port binding is an important concept. Since a running container can be regarded as another machine, its ports are different from host's ports.</b></i>

  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 8 12 17 PM" src="https://user-images.githubusercontent.com/31994778/123139874-5819ce80-d45f-11eb-9063-6ef570a1f37e.png">
  </p>
  
  Here, the first container is bound with host's 5000 port to its 5000 port.
  
  The second ant third containers both have their 3000 port bound to host's 3000 and 3001 ports. 
  
  >To put it more clearly, when you send a request to port 5000 from your computer, it will interact with port 5000 running container of Docker. Also, when you send a request to port 3000 of your computer, it will interact with port 3000 of container, and the same thing goes for port 3001 of your computer as well.
  
  Let's say that you already started running an `nginx` container with `docker run -p 5000:3000 nginx:1.20.1`
  
  <p align="center">
    <img width="500" alt="Screen Shot 2021-06-23 at 8 20 15 PM" src="https://user-images.githubusercontent.com/31994778/123140853-7207e100-d460-11eb-88c8-1a4085056978.png">
  </p>
  
  with `docker ps` we can see that our container is up and running..
  
  if you want to start another container with same host port though, it will print out error. (Port is already allocated)
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-23 at 8 21 27 PM" src="https://user-images.githubusercontent.com/31994778/123141033-9c599e80-d460-11eb-8dd6-738b231a9489.png">
  </p>
  
  When we bind host's 5001 port to container 3000, we can see that both containers are running without any problems.
  
  <p align="center">
    <img width="500" alt="Screen Shot 2021-06-23 at 8 24 27 PM" src="https://user-images.githubusercontent.com/31994778/123141492-1db13100-d461-11eb-8951-5a089ce1b0d4.png">
  </p>

<p id="docker-network">
<h2>Docker Network</h2>
</p>

<b><i>"Docker creates its own isolated network in which Docker containers run."</b></i>

<p align="center">
    <img width="500" alt="Screen Shot 2021-06-24 at 9 47 32 AM" src="https://user-images.githubusercontent.com/31994778/123215527-3b1de380-d4d1-11eb-8956-f104c9b5207c.png">
  </p>
  
  So, when we deploy two containers in the same Docker network, <b>They can talk to each other by just using the container name.</b> Without localhost, port number, etc.. <b>Just the container name.</b> Because they are in the same network.
  
  
<p align="center">
    <img width="500" alt="Screen Shot 2021-06-24 at 9 41 44 AM" src="https://user-images.githubusercontent.com/31994778/123215796-8c2dd780-d4d1-11eb-937e-821344cfded6.png">
  </p>
  
  <b>Applications running outside the Docker network has to talk to these containers using localhost:port-number</b>
  
  <p align="center">
    <img width="500" alt="Screen Shot 2021-06-24 at 9 42 07 AM" src="https://user-images.githubusercontent.com/31994778/123216007-c1d2c080-d4d1-11eb-8621-b9deb9e0fec7.png">
  </p>
  
  Later on, when we package our application into its own Docker image and run as a Docker container, 3 Docker containers will be talking to each other in Docker network, i.e., Node application, MongoDB, and MongoExpress..
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 9 42 27 AM" src="https://user-images.githubusercontent.com/31994778/123218874-e8462b00-d4d4-11eb-87f2-142050c1c52a.png">
  </p>

On top of these, we will connect to this network from outside by a Web Browser, as follows:

  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 9 42 55 AM" src="https://user-images.githubusercontent.com/31994778/123219151-3c510f80-d4d5-11eb-90bd-101c4b0b3356.png">
  </p>
  
  <h3>Creating Network</h3>
  
  Use `docker network create <network-name>`.
  
  After running `docker network create mongo-network` and `docker network ls`, we have the following picture:
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 10 43 16 AM" src="https://user-images.githubusercontent.com/31994778/123222854-06158f00-d4d9-11eb-99c4-2909817bf364.png">
  </p>

So, since we want to run our mongo container and mongo-express container in this network, we have to provide network option as we start containers..

```
docker run -p 27017:27017 -d \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=password \
--name mongodb --net mongo-network mongo
```

<b>Here, -e is for setting environment variables.</b>

We also need to docker run mongo-express

```
docker run -p 8081:8081 -d \
-e ME_CONFIG_MONGODB_SERVER=mongo-db \
-e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
-e ME_CONFIG_MONGODB_ADMINPASSWORD=password \
--net mongo-network --name mongo-express mongo-express
```
After running these, we can check the connection's success status by `docker logs <container-name>`

`docker logs mongo-express` gives us

  <p align="center">
  <img width="600" alt="Screen Shot 2021-06-24 at 11 02 00 AM" src="https://user-images.githubusercontent.com/31994778/123225690-9fde3b80-d4db-11eb-9f96-b6f95884adfc.png">
  </p>
  
  In the beginning of the log, it says `Mongo Express server listening at http://0.0.0.0:8081`, so everything is okay.
  
  This is what we have at `localhost:8081`
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 11 06 12 AM" src="https://user-images.githubusercontent.com/31994778/123226345-3f033300-d4dc-11eb-921f-12e5b77ceb68.png">
  </p>

<p id="docker-compose">
  <h2>Docker Compose</h2>
  </p>
  
  <b><i>"Docker Compose is used for running Docker containers as an alternative to manually typing docker run ... from terminal."</b></i>
  
  So far, we have run two Docker containers, and we used the following codes on terminal to run them.
  
```
docker run -p 27017:27017 -d \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=password \
--namemongodb --net mongo-network mongo
```
```
docker run -p 8081:8081 -d \
-e ME_CONFIG_MONGODB_SERVER=mongo-db \
-e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
-e ME_CONFIG_MONGODB_ADMINPASSWORD=password \
--net mongo-network --name mongo-express mongo-express
```

This was super tedious and error-prone. It's always good to do things in a more structured manner. Docker Compose helps us doing that.

<b><i>Docker Compose is a `.yaml` file.</b></i>

 <p align="center">
  <img width="550" alt="Screen Shot 2021-06-24 at 12 56 01 PM" src="https://user-images.githubusercontent.com/31994778/123244857-f738d780-d4ec-11eb-95f7-f60bdcf16522.png">

</p>
  
  This is the Docker Compose yaml structure. Here, we do a translation from docker run command to .yaml file.
  
  ```yaml
  version: '3'
  services:
    mongodb:
      image: mongo
      ports:
      - 27017:27017
      environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
```

Here, 

- version: '3' -> <b>Version of Docker Compose</b>
- services: -> <b>Container list is under services</b>
  - mongodb: -> <b>Container name</b>
  - ports: -> <b>HOST:CONTAINER</b>
  - environment: -> <b>Environment variables</b>

<b>As you can see, we do not have to declare --network flag here. This is just so because Docker Compose runs containers in the same Docker network.</b>

Together with mongo-express,

```yaml
version: '3'
services:
  mongodb:
    image: mongo
    ports:
    - 27017:27017
    environment:
    - MONGO_INITDB_ROOT_USERNAME=admin
    - MONGO_INITDB_ROOT_PASSWORD=password
  mongo-express:
    image: mongo-express
    ports:
    - 8081:8081
    environment:
    - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
    - ME_CONFIG_MONGODB_ADMINPASSWORD=password
    - ME_CONFIG_MONGODB_SERVER=mongodb
```

To remind once again, <b>Docker Compose takes care of creating a common network.</b>


  <h3>Starting Containers Using Docker Compose</h3>
  
  `docker-compose -f mongo.yaml up`
  
   <p align="center">
  <img width="550" alt="Screen Shot 2021-06-24 at 1 31 01 PM" src="https://user-images.githubusercontent.com/31994778/123248542-b773ef00-d4f0-11eb-84a9-2874f01a2f77.png">
  </p>
  
<p align="center">
  <img width="550" height="90" alt="Screen Shot 2021-06-24 at 1 33 59 PM" src="https://user-images.githubusercontent.com/31994778/123248746-f2762280-d4f0-11eb-85c2-02ee73f15610.png">
  </p>
  
  In the following picture, you can see that Docker Compose is automatically creating a Docker network.
  
  <p align="center">
  <img width="550" alt="Screen Shot 2021-06-24 at 1 38 31 PM" src="https://user-images.githubusercontent.com/31994778/123249385-919b1a00-d4f1-11eb-8477-c58b191a739f.png">
  </p>
  
  As you can see, in the first line it says `Creating network "myapp_default" with the default driver`.
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 1 45 54 PM" src="https://user-images.githubusercontent.com/31994778/123250277-8c8a9a80-d4f2-11eb-8ce4-c616e9af6b39.png">
  </p>
  
  Name of the network is: `app_default`
  
  <b>Note that everytime we remove or stop a container and create or restart it again, we lose the data and all the container configurations! This problem will be fixed with `Volumes`.</b>
  
<h3>Stopping Containers Using Docker Compose</h3>
    
  <b>In order to stop both containers at the same time, we can use `docker-compose -f mongo.yaml down`.</b>
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-24 at 1 58 10 PM" src="https://user-images.githubusercontent.com/31994778/123251769-3f0f2d00-d4f4-11eb-83e8-55509a7b4c02.png">
  </p>

<p id="dockerfile">
  <h2>Dockerfile</h2>
  </p>
 
 <b><i>"Dockerfile is a blueprint for creating Docker images."</b></i>
 
We're gonna create a Docker image from our Node, JS application.

- The first line of every Dockerfile is `FROM <some-image>`.
- We have to base our image on a base image with `FROM`.
- Second, we want to configure our environment variables with `ENV`. (Optional since we already set env vars in mongodb and mongo-express containers)
- Third, `RUN`-> `RUN mkdir -p /home/app`
- Fourth, `COPY` -> `COPY . /home/app`
- Last one, `CMD` -> `CMD ["node","server.js"]`

<b>Here, `COPY` and `RUN` are not interchangable since `COPY` copies files from the host machine to the container, but `RUN` runs commands inside a container.</b>

<b>Also, `CMD` is an entry point command, which means that it can be only one in a Dockerfile, on the other hand there can be multiple `RUN` commands.</b>

<b>Also, we are basing our image on a `Node` environment, which means that when the container is run, we don't have to install `Node`.</b>

  <p align="center">
<img width="230" alt="Screen Shot 2021-06-24 at 3 12 04 PM" src="https://user-images.githubusercontent.com/31994778/123260746-97e3c300-d4fe-11eb-9aa9-e1c782be1308.png">
  </p>

```Dockerfile
FROM node:13-alpine

RUN mkdir /home/app
COPY . /home/app
WORKDIR /home/app
CMD ["node","server.js"]
```

<b>Dockerfile name must be "Dockerfile"</b>

<h3>Building the Image</h3>

`docker build -t my-app:1.0 .`

Here, -t is used for naming the image as `my-app`.

`my-app:1.0`'s `1.0` is the tag of this image. It can be anything we want. For example, it can be `my-app:version-1`.

<p align="center">
<img width="500" alt="Screen Shot 2021-06-24 at 3 22 22 PM" src="https://user-images.githubusercontent.com/31994778/123261908-01180600-d500-11eb-98ca-aac6f6df1658.png">
  </p>

After completion, we can run `docker images` and see

<p align="center">
<img width="500" alt="Screen Shot 2021-06-24 at 3 23 48 PM" src="https://user-images.githubusercontent.com/31994778/123262103-33296800-d500-11eb-8e9a-db2aa9f7ff3d.png">
  </p>

`my-app` is created with tag `1.0`.

Then, run the container of the image with `docker run my-app:1.0`.

<p align="center">
<img width="500" alt="Screen Shot 2021-06-24 at 3 46 23 PM" src="https://user-images.githubusercontent.com/31994778/123265175-70432980-d503-11eb-95e5-aaab886fbdef.png">
</p>

Voila!

We can get inside the shell by `docker exec -it <container id> /bin/sh`

<p align="center">
<img width="650" alt="Screen Shot 2021-06-24 at 3 52 53 PM" src="https://user-images.githubusercontent.com/31994778/123266040-4e967200-d504-11eb-97aa-1edc7e1512d3.png">
 </p>
 
<b>As you can see, everything we did in the Dockerfile is reflected here! The folders that we have is due to `COPY` and `MKDIR` commands we used.</b>

<p id="deploy-app">
<h2>Deploy Containerized App</h2>
</p>

1- Push the image you created to DockerHub.

<p align="center">
<img width="733" alt="Screen Shot 2021-06-24 at 7 13 12 PM" src="https://user-images.githubusercontent.com/31994778/123297440-3e8c8b80-d520-11eb-9506-1e7f2b80e02c.png">
 </p>
 
 I am going to use image `burakhanaksoy/my-app:2.2`.
 
2- Change Docker compose .yaml file as follows:
```yaml
version: "3"
services:
  my-app:
    image: burakhanaksoy/my-app:2.2
    ports:
      - 3000:3000
  mongodb:
    image: mongo
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
  mongo-express:
    image: mongo-express
    ports:
      - 8081:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=mongodb
```

Here, we just added this part:
```yaml
my-app:
    image: burakhanaksoy/my-app:2.2
    ports:
      - 3000:3000
```

3- Start multiple containers with Docker compose as follows:

`docker-compose -f  mongo.yaml up`

<p align="center">
  <img width="700" alt="Screen Shot 2021-06-24 at 7 16 43 PM" src="https://user-images.githubusercontent.com/31994778/123298004-c1ade180-d520-11eb-899c-296d1038226b.png">
  </p>
  
4- Test!

Go to localhost:3000, and

<p align="center">
  <img width="400" height="550" alt="Screen Shot 2021-06-24 at 7 17 45 PM" src="https://user-images.githubusercontent.com/31994778/123298177-e904ae80-d520-11eb-9589-9d2bd665d689.png">
  </p>
  
  Voila!
  
  <p id="run-the-app">
  <h2>Run the App</h2>
  </p>
  
  To run the app:
  1 - Clone the repository and `cd app`
  
  <p align="center">
  <img width="500" alt="Screen Shot 2021-06-25 at 8 28 43 AM" src="https://user-images.githubusercontent.com/31994778/123374204-6ebf4300-d58f-11eb-8a8d-9ef9895c0c6e.png">
  </p>
  
  2- In the directory, run `docker-compose -f mongo.yaml up`
  
   <p align="center">
  <img width="600" alt="Screen Shot 2021-06-25 at 8 31 26 AM" src="https://user-images.githubusercontent.com/31994778/123374550-f442f300-d58f-11eb-82a9-9967b6b0a394.png">
  </p>
  
  3- Test!
  
  Go to `localhost:3000`
  
   <p align="center">
  <img width="350" height="450" alt="Screen Shot 2021-06-25 at 8 34 38 AM" src="https://user-images.githubusercontent.com/31994778/123374688-31a78080-d590-11eb-85b9-dc07a18af695.png">
  </p>


<p id="docker-volumes">
  <h2>Docker Volumes</h2>
  </p>
  
  <b><i>"Docker Volumes are used for data persistence in Docker."</b></i>

 <p align="center">
<img width="500" alt="Screen Shot 2021-06-25 at 5 49 53 PM" src="https://user-images.githubusercontent.com/31994778/123442667-cb494f00-d5dd-11eb-96b2-f8a91188e07e.png">
  </p>

<h3>When do we need Docker Volumes?</h3>


There might be different scenarios in which we might have to use Docker Volumes. One of them is data persistence.
- As we experienced here, using mongodb, or any other db, as a container itself is not enough for keeping the state of the db.
- This is to say that everytime we restart db container, our data is gone!

<b>Docker Volumes is used to help maintain the state (data) of the db.</b>

 <p align="center">
  <img width="500" alt="Screen Shot 2021-06-25 at 5 52 35 PM" src="https://user-images.githubusercontent.com/31994778/123443024-2da24f80-d5de-11eb-892a-2f9c91812a5f.png">
  </p>
  
  Here, our container has its own virtual file system and whenever we stop/start the container, data in its virtual file system is gone and starts from a fresh state.
  
  <b>Through Docker Volumes we actually mount the physical file system of our host to the virtual file system inside the container.</b>

 <p align="center">
  <img width="500" alt="Screen Shot 2021-06-25 at 6 29 41 PM" src="https://user-images.githubusercontent.com/31994778/123448315-76103c00-d5e3-11eb-9051-cdba0d34a94d.png">
  </p>

Here, one thing is very important to note. <b>File systems are `replicated` between host and container. This is to say that when some data change inside host file system, `same change happends inside container file system`, and vice-versa.</b>

So even though we restart the container with a fresh state, it's file system is automatically cloned to the host's file system and this solves the problem.

<h3>3 Volume Types</h3>

<h4>Host Volumes</h4>

- `docker run -v /home/mount/data:/var/lib/mysql/data`
- Here, the first one is the host file system directory, second one is the container file system directory.
- In this type, you can decide where on the host file system the reference is made

<p align="center">
  <img width="350" alt="Screen Shot 2021-06-25 at 6 37 53 PM" src="https://user-images.githubusercontent.com/31994778/123449871-bfad5680-d5e4-11eb-90c3-ef82393f8040.png">
  </p>
  
<h4>Automaticly Created Directory Volumes</h4>

In this type, you only specify the `container` file directory. We don't specify which directory on the host should be mounted.

`docker run -v /var/lib/mysql/data`

<b>For each container a folder is generated that gets mounted.</b>

<p align="center">
<img width="350" alt="Screen Shot 2021-06-25 at 9 08 27 PM" src="https://user-images.githubusercontent.com/31994778/123467878-ae227980-d5f9-11eb-94be-d9ac43e61e83.png">
  </p>

These types of volumes are called `Anonymous Volumes` because you don't have a reference to this automatically generated folder.

<h4>Named Volumes</h4>

This is very similar to the `Automatically Created Directory` volume type, but it differs in that <b>it specifies the name of the folder in the host file system.</b>

`docker run -v name:/var/lib/mysql/data`

<b>This type should be used because it's very beneficial and succinct.</b>

<h4>Docker Volumes in Docker Compose</h4>

<p align="center">
<img width="350" alt="Screen Shot 2021-06-25 at 9 15 55 PM" src="https://user-images.githubusercontent.com/31994778/123468550-95669380-d5fa-11eb-9911-b54839307df4.png">
  </p>

Here we use a `Named Volume` and `db-data` is the reference name and `/var/lib/mysql/data` is the name of the path in the container.

You may have other container instructions in Docker compose .yaml file, but you need to write

```yaml
volumes:
  db-data
```
once again at the end of the .yaml file.

<p align="center">
  <img width="350" alt="Screen Shot 2021-06-25 at 9 21 50 PM" src="https://user-images.githubusercontent.com/31994778/123469216-6a307400-d5fb-11eb-9d68-ec551366c226.png">
  </p>

here,

```yaml
volumes:
  db-data
```

should be at the same level as `services`.

<h4>Implementation</h4>

1- Change the `Docker Compose .yaml` file.

```yaml
version: "3"
services:
  frontend:
    image: burakhanaksoy/frontend:1.0
    ports:
      - 8080:8080
  backend:
    image: burakhanaksoy/backend:1.0
    ports:
      - 8000:8000
  mongodb:
    image: mongo
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
    volumes:
      - mongo-data:/data/db
  mongo-express:
    image: mongo-express
    ports:
      - 8081:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=mongodb
volumes:
  mongo-data:
    driver: local
```

Here, the last part

```yaml
volumes:
  mongo-data:
    driver: local
```

here, `driver: local` is an additional information for Docker so that it creates a physical storage on a local file system.

`mongo-data` is the name reference for the volume.

And also inside

```yaml
mongodb:
    image: mongo
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
    volumes:
      - mongo-data:/data/db
```

the last part

```yaml
volumes:
      - mongo-data:/data/db
```

here `/data/db` is the path inside the mongodb container. <b>It has to be the path where MongoDB persists its data.</b>

<b><i>In order to find the right filesystem path, in our case, for MongoDB, is `/data/db`, we can make a search on the Internet.</b></i>

<p align="center">
  <img width="550" alt="Screen Shot 2021-06-25 at 9 59 13 PM" src="https://user-images.githubusercontent.com/31994778/123473013-a31f1780-d600-11eb-8ecd-114a6ad1ee5c.png">
  </p>
  
  We can also check if this path exists by `docker exec -it <container-id> /bin/sh`
  
  <p align="center">
 <img width="800" alt="Screen Shot 2021-06-25 at 10 03 18 PM" src="https://user-images.githubusercontent.com/31994778/123473402-31939900-d601-11eb-9634-487bf82874ea.png">
  </p>
  
  <b>Note that each db has it's specific filesystem path, in other words path would likely to be different for MySQL or PostgreSQL. We should consult on the Internet.</b>
  
  For MySQL:`var/lib/mysql`
  
  For PostgreSQL:`var/lib/postgresql/data`

2- Run `docker-compose -f app.yaml up`

 <p align="center">
  <img width="672" alt="Screen Shot 2021-06-25 at 10 06 43 PM" src="https://user-images.githubusercontent.com/31994778/123473746-ac5cb400-d601-11eb-83b4-60a05ee388d0.png">
  </p>

3- Test!

Persists data into the DB and run `docker-compose -f app.yaml up` and `docker-compose -f app.yaml down` several times.

You'll see that our data won't disappear.

Awesome!

<p align="center">
 <img width="600" alt="Screen Shot 2021-06-25 at 10 20 39 PM" src="https://user-images.githubusercontent.com/31994778/123475133-a10a8800-d603-11eb-829a-df6acadf35d5.png">
  </p>


<p id="credits">
<h2>Credits</h2>
</p>

We finally made it! It was a nice 101. I want to thank Nana from [TechWorld with Nana](https://www.youtube.com/channel/UCdngmbVKX1Tgre699-XLlUA) and Mosh Hamedani from [Programming with Mosh](https://www.youtube.com/channel/UCWv7vMbMWH4-V0ZXdmDpPBA) for their amazing teaching skills and videos on YouTube. I watched their videos and prepared this document.

The videos I watched as I prepare this documentation is as follows:
- [Docker Tutorial for Beginners [2021]](https://www.youtube.com/watch?v=pTFZFxd4hOI)
- [Docker Tutorial for Beginners [FULL COURSE in 3 Hours]](https://www.youtube.com/watch?v=3c-iBn73dDE)
