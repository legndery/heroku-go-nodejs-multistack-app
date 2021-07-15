export PORT="${PORT:-8080}"
envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
/root/portfolio-app 2>&1 &
npm start 2>&1 &
nginx -g 'daemon off;'