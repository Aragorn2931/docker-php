This settings for laravel project

#Nginx
In nginx conf file (cfg/nginx/nginx.conf) replace options.

#PHP-FPM
In php fpm conf file (cfg/php/www.conf) change user id from 1000 your host user id. (first created user by default has id 1000)

This need only for development.


#Run
docker-compose up --build
