FROM php:7.4-apache

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
COPY --from=composer /usr/bin/composer /usr/bin/

ENV WORKING_DIRECTORY /usr/src/myapp
ENV APACHE_DOCUMENT_ROOT $WORKING_DIRECTORY/public

COPY init.sh ${PATH}/init.sh
RUN chgrp -R www-data ${PATH}/init.sh
RUN chmod -R ug+rwx ${PATH}/init.sh

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite headers

WORKDIR $WORKING_DIRECTORY/

CMD ${PATH}/init.sh