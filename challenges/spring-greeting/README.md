# Spring Greeting Service

A [simple api](https://github.com/AgarwalConsulting/DockerTraining/tree/master/examples/1-web-apps/spring-greeting/go) service.

## Endpoints

`GET /greeting` - It takes an optional `name` as query parameter.

## Environment Variables

- `PORT` - default value is `8080`

The app is packaged as a docker image at [agarwalconsulting/spring-greeting](https://hub.docker.com/repository/docker/agarwalconsulting/spring-greeting).

### Goals/Questions

- Write a pod spec
- Write a service spec
  - Questions
    - What happens when you delete the pods?
- Write a deployment spec
