# RVStore

The RV store is a mock e-commerce application. Your task is to get the application running on a Kubernetes cluster.

There are six services plus a Mongo DB, each with their own Docker image:

- Angular UI running in Nginx
- Product service
- Order service
- Auth service
- Order simulator
- Gateway edge service

You can read more about the services here: [RVStore](https://github.com/AgarwalConsulting/rvstore/blob/master/services.md).

Your humble instructor is playing the role of developer. I’ve written an application made up of 6 services. But I need your expertise to get it running on Kubernetes. All I know is the application code and environment variables needed.

## Goals/Steps

- Set up the application to run in Kubernetes. For this hackathon, Minikube or Docker Kubernetes for Desktop is fine.

- Centralize configurations (environment variables)

- Put any sensitive information into secrets

- Ensure that only public services are accessible outside the cluster. These are the gateway service and the UI.

- Make the app fault-tolerant
  - Increase service redundancy
  - Set up probes
  - Try to break it!

- For MongoDB, set up a volume mapping to your hard drive so that the MongoDB pod can be thrown out and not lose orders.

- Once everything is running, release version 2.0 of the UI. Once verified, you’ve realized that there’s a problem (the styling is hideous). Try rolling back.

## Learning through the pain

Exercises so far have been very simple and superficial. This is by design, as I want you to get the deep dive knowledge from this hackathon.

This hackathon is designed to push you. It is intended to make you a little uncomfortable. You may not enjoy it (at least until the end when you have it working)!

The struggle is where the learning is. You will scratch your head, wonder what’s going on. I have deliberately left out some important information. In some cases I have given bad information. This is designed to mimic real life so that you can troubleshoot, then come to me (the developer) to get the proper information.

## Helpful hints

- It is best to start out as simple as possible. Eliminate any variables that might muddy up what you’re doing.

- Pick a service that is the simplest and start there. Implement it, get it running, then move on. Don’t try to just write all the files at once then wonder why things aren’t working.

- Build from simple to complex in an iterative process. The product API is a good place to start since it just serves static information and has no dependencies.

- Save things like fault-tolerance for later. Don’t use multiple copies of a service yet. Don’t add probes. Save that for once it’s working.
