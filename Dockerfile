FROM php:8.2-cli

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Установка расширений PHP
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd intl zip

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Установка рабочей директории
WORKDIR /app

# Копирование файлов приложения
COPY . .

# Установка зависимостей
RUN composer install --no-dev --optimize-autoloader

# Запуск приложения
EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:$PORT", "-t", "."]