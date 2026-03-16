FROM php:8.2-apache

# Install extension MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Install tools
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Enable Apache rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy project
COPY . .

# Install PHP dependencies (Phinx)
RUN composer install

# Fix permission
RUN chown -R www-data:www-data /var/www/html
