FROM php:7.4-apache

RUN apt-get update &&\
    apt-get install git unzip vim -y

ENV WORKING_DIRECTORY /usr/src/myapp
ENV APACHE_DOCUMENT_ROOT $WORKING_DIRECTORY/public

RUN docker-php-ext-install bcmath pdo_mysql

COPY init.sh ${PATH}/init.sh

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite headers

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR $WORKING_DIRECTORY/

CMD ${PATH}/init.sh