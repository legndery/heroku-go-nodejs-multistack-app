deploy_heroku:
	heroku config:set HEROKU_URL=$(shell heroku info -s | grep web_url | cut -d= -f2)
	git push heroku HEAD:main