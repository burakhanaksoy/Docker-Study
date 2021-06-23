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

