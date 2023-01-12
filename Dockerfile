FROM alpine:3.1

RUN apk update
RUN apk add             \
    bash                \
    mc                  \
    apache2             \
    apache2-ssl         \
    apache2-proxy       \
    apache2-proxy-html  \
    mysql-client        \
    postgresql-client   \
    php                 \
    php-apache2         \
    php-pdo_mysql       \
    php-mysqli          \
    php-pdo_sqlite      \
    php-gd              \
    php-xml             \
    php-xmlreader       \
    php-zip             \
    php-intl            \
    php-iconv           \
    php-phar            \
    php-curl            \
    php-json            \
    php-posix           \
    php-gmp             \
    php-bcmath          \
    php-opcache         \
    php-pdo_pgsql       \
    php-zip             \
    php-opcache         \
    php-apcu            \
    php-gettext         \
    php-gd              \
    php-memcache        \
    php-openssl         \
    php-soap            \
    php-zlib            \
    imagemagick         #

# fix a bug: AH00526: Syntax error on line 43 of /etc/apache2/conf.d/ssl.conf: Invalid command 'SSLMutex', perhaps misspelled or defined by a module not included in the server configuration
COPY etc/apache2/conf.d/ssl.conf /etc/apache2/conf.d/ssl.conf
COPY etc/apache2/httpd.conf /etc/apache2/httpd.conf

# fix a dompdf problem...
# RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
# ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

# RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
