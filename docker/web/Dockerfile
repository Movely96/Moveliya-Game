# GCE web portal - Apache + PHP, same stack as the original VM setup script.
FROM php:8.2-apache

# The portal lives under /gce and is intentionally hidden by robots.txt,
# exactly like the original lab.
COPY html/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
