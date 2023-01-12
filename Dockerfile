FROM alpine:3.14

RUN apk add \
    bash                \
    mc                  \
    apache2             \
    apache2-ssl         \
    apache2-proxy       \
    apache2-proxy-html  \
    mysql-client        \
    graphicsmagick      \
    php7                \
    php7-apache2        \
    php7-pdo_mysql      \
    php7-mysqli         \
    php7-mysqlnd        \
    php7-pdo_sqlite     \
    php7-session        \
    php7-gd             \
    php7-xml            \
    php7-simplexml      \
    php7-xmlreader      \
    php7-xmlwriter      \
    php7-zip            \
    php7-intl           \
    php7-fileinfo       \
    php7-iconv          \
    php7-tokenizer      \
    php7-phar           \
    php7-curl           \
    php7-json           \
    php7-posix          \
    php7-pcntl          \
    php7-mbstring       \
    php7-gmp            \
    php7-bcmath         \
    php7-opcache        \
    php7-pecl-apcu      \
    php7-ctype          #

# fix a dompdf problem...
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
