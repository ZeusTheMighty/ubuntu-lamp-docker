FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get install -y php libapache2-mod-php php-mcrypt php-mysql && \
    apt-get install -y phpmyadmin php-mbstring php-gettext
    
    
RUN apt-get install -y mysql-server && \
    service mysql restart && \
    mysqladmin -u root password JRWPassword && \
    phpenmod mcrypt && \
    phpenmod mbstring

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

RUN /etc/init.d/apache2 restart
RUN /etc/init.d/mysql restart

EXPOSE 80

EXPOSE 443

EXPOSE 3306

ENTRYPOINT service apache2 restart && service mysql restart


