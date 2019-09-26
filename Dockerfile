FROM php:7.3-fpm


#update repositories
RUN apt update

#install some stuff like nano editor and git
RUN apt -y install nano \
    && apt -y install git

#install PHP extensions
RUN apt install -y libzip-dev zlib1g-dev libxml2-dev  libssl-dev \
    && docker-php-ext-install mysqli zip xml json pdo pdo_mysql \
    && docker-php-ext-enable mysqli zip xml json pdo pdo_mysql

RUN apt install -y libgd-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir  \
    && docker-php-ext-install gd

#install NodeJs
RUN apt install -y curl \
    && curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && apt -y install software-properties-common \
    && apt install -y nodejs

#create workdir
RUN mkdir -p /var/www/site

#set work dir
WORKDIR /var/www/site

#install composer package manager
RUN cd /var/www/site \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin  --filename=composer \
    && php -r "unlink('composer-setup.php');"

#make php.ini file (dev-mod) from template
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
#copy php-fpm conf
COPY ./cfg/php/www.conf /usr/local/etc/php-fpm.d/

#make user for solve permissions problem while editing file from host
RUN adduser yng --home=/home/yng --uid=1000
