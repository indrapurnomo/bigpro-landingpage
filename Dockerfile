#FROM php:7.3.22-apache-stretch

#WORKDIR /var/www/html/

#COPY . .

FROM nginx

COPY . /usr/share/nginx/html/
