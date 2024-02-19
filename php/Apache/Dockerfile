# -*- coding: utf-8 -*-

FROM httpd:alpine

# Enable proxy and fcgi modules
RUN sed -i \
    -e 's/^#\(LoadModule proxy_module modules\/mod_proxy.so\)/\1/' \
    -e 's/^#\(LoadModule proxy_fcgi_module modules\/mod_proxy_fcgi.so\)/\1/' \
    /usr/local/apache2/conf/httpd.conf

# Add vhost configuration and copy vhost file
#COPY conf/httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
RUN sed -i \
    -e 's/#Include\ conf\/extra\/httpd-vhosts.conf/Include\ conf\/extra\/httpd-vhosts.conf/' \
    /usr/local/apache2/conf/httpd.conf

# Create users, directories and update permissions
RUN addgroup -g 1000 app \
    && adduser -D -H -h /var/www/html -s /sbin/nologin -G app -u 1000 app \
    && mkdir -p /var/www/html /usr/local/apache2/logs \
    && chown -R app:app /var/www/html /usr/local/apache2/logs

# Change owner and group
USER app:app

# Change workdir
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Start apache
CMD ["httpd-foreground"]
