# Simple Laravel app container

This image is based on the official php image for mor info click this link
https://hub.docker.com/_/php 

## In the box:
1.  Apache
2.  Composer
3.  PHP:7.4
4.  [mlocati php-extension-installer _(click for more details...)_](https://github.com/mlocati/docker-php-extension-installer)


## Default environment variables apart from the default php container environment
```
#   Set to production if you deploy
1.  APP_ENV=null

#   Location of your source code optional
2.  WORKING_DIRECTORY=/usr/src/myapp
```
## Usage:

### 1.  Docker file implementation
```Dockerfile
FROM raven1994/laravel-app:latest

# Copy source code to default app path
COPY . $WORKING_DIRECTORY

# write access to the storage and cache folders
RUN chgrp -R www-data $WORKING_DIRECTORY/storage $WORKING_DIRECTORY/bootstrap/cache
RUN chmod -R ug+rwx $WORKING_DIRECTORY/storage $WORKING_DIRECTORY/bootstrap/cache

# install packages
RUN composer install -n --no-dev
```
### 2.  docker-compose
```yml
version: "3.8"

services: 
    app:
        image: mywebapp
        ports: 
            - 8000:80
        volumes: 
            - ./:/usr/src/myapp
```


## Installing extensions
This image utilises mlocati/php-extension-installer . Install your extensions as shown below.

```Dockerfile
FROM raven1994/laravel-app:latest

# install extenstions
RUN install-php-extensions gmp zip

RUN composer install -n --no-dev
```

There are better options out there like *Velocity* , *laradock*, *Homestead* . I just love less in my environments

