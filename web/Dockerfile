# GCE web portal - PHP + Apache. Works on Windows/macOS/Linux via Docker.
FROM php:8.2-apache

# Site lives under /gce/ (robots.txt disallows it - that's an intended recon clue)
COPY robots.txt /var/www/html/robots.txt
COPY gce/ /var/www/html/gce/

RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
