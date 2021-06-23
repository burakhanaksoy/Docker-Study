<h1>Docker Study</h1>
<p align="center">
  
  <img width="450" height="350" src="https://user-images.githubusercontent.com/31994778/123071595-76f77100-d41d-11eb-8641-93f18c90d28c.png">
  
</p>
 
 <h2>What is Docker?</h2>
 
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

<h2>Virtual Machines vs Containers</h2>

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

<h3>Problems</h3>

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

<h2>Docker Architecture</h2>

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

<h2>Development Workflow</h2>

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

<h2>Docker in Action</h2>

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

<h3>Image vs Container</h3>

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


<h2>Linux Command Line</h2>

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
  
  
  <h2>Port Binding</h2>
  
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
