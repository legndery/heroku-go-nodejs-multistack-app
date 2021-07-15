# All Encompassing App
```
docker build --build-arg PORT=8080 -t portfolio-golang:0.0.1 . --progress=plain

docker run -p "8080:8080" portfolio-golang:0.0.1
```
```
heroku config:set HEROKU_URL=$(heroku info -s | grep web_url | cut -d= -f2)
```