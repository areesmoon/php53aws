# Dockerfile
FROM seti/php53
COPY conf/php.ini /etc/php.ini
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt install nano -y

#INSTALL AWS MANUALLY
## Prepare Install dir
RUN mkdir -p /usr
RUN mkdir -p /usr/local
RUN mkdir -p /usr/local/aws-cli
RUN mkdir -p /usr/local/aws-cli/v2
RUN mkdir -p /usr/local/aws-cli/v2/2.17.60
RUN mkdir -p /usr/local/aws-cli/v2/2.17.60/dist
RUN mkdir -p /usr/local/bin

## Copy app files
COPY app/aws/dist/ /usr/local/aws-cli/v2/2.17.60/dist/

## Copy and run installer
RUN mkdir /root/aws
COPY app/aws/install /root/aws/install
COPY app/file.zip /root/file.zip
WORKDIR /root
RUN sudo ./aws/install
RUN rm -rf aws
RUN rm -f /root/file.zip

RUN service apache2 restart
CMD ["/usr/local/bin/run"]