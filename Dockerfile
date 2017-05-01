FROM php:fpm

MAINTAINER Scott Wilcox <scott@dor.ky>

# exit if a command fails
set -e

# Stop upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# Dependancies for extensions
RUN apt-get update -yqq
RUN apt-get install libicu-dev libpng-dev libjpeg-dev libbz2-dev  -yqq

# Install extensions
RUN docker-php-ext-install intl gd bz2

# Installer composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

EXPOSE 9000

CMD ["php-fpm"]
