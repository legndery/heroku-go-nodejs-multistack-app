# go-nodejs Multistack application boilerplate for Heroku

**This is not production quality cause it doesn't have logging, health probes, auto restart etc. The repo is to give you hint on how to deploy multiple language in heroku free dyno**

## How it works:
Nginx runs at the `$PORT` heroku provides and adds a reverse proxy to other applications.

## How to deploy:
- clone the repo
  ```
  git clone git@github.com:legndery/heroku-go-nodejs-multistack-app.git
  ```
- setup your heroku(login, create app etc)
- using heroku CLI, Run `heroku stack:set container` or `make prepare`
- (optional) we want the HEROKU_URL environment variable to be set to periodically ping. and then push to heroku. Which I have included in the Makefile.
  - if you want to make sure the dyno doesn't sleep:
    ```
    heroku config:set HEROKU_URL=$(heroku info -s | grep web_url | cut -d= -f2)
    git push heroku HEAD:main
    ```
  - Otherwise:
    ```
    git push heroku HEAD:main
    ```
- To check go to`<urapp>/gv1/ping` for golang and `<urapp>/nv1/api/v1/healthz` for nodeJS

## Components
There are three components here. Node, Golang and Nginx

### NodeJS app:
The node.js app is located in `./node-stack/`. It's a simple Express application which runs at `3001` port.

### Golang App:
The golang app is located in `./go-stack`. It's a simple gin-ionic app which runs at `3000` port.

### Nginx:
Nginx works here as a reverse proxy for the node and golang app.

**The trick:** We have a template file in `infrastructure/nginx/default.conf.template` while deploying the `$PORT` is substitued with actual port that `$PORT` env variable provided by Heroku.
