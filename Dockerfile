FROM php:8.0.0-apache
WORKDIR /var/www/html
ADD . /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chown -R www-data:www-data /var/www/html
RUN apt-get update -y && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
COPY . /var/www/html/
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN service apache2 restart
EXPOSE 80