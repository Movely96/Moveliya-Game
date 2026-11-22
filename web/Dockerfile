# GCE web portal - PHP + Apache. Works on Windows/macOS/Linux via Docker.
FROM php:8.2-apache

# Site lives under /gce/ (robots.txt discloses it - that is the intended recon clue)
COPY index.php /var/www/html/index.php
COPY robots.txt /var/www/html/robots.txt
COPY gce/ /var/www/html/gce/

# Avoid directory listings and hide the Apache version
RUN a2dismod -f autoindex \
    && printf 'ServerTokens Prod\nServerSignature Off\n' > /etc/apache2/conf-available/hardening.conf \
    && a2enconf hardening \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
