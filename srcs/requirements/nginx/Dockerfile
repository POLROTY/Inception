# Use the Debian Buster base image for this container
FROM debian:buster

RUN apt update -y
RUN apt upgrade -y

# intall vim to do vim stuff in container
#RUN apt install vim -y 

# install NGINX in container
# -y is auto yes for install and updates
RUN apt install nginx -y
# update NGINX
# RUN apt update nginx -y


# install OPENSSL in container
RUN apt install openssl -y
# update OPENSSL
# RUN apt update OpenSSL -y


# create a directory for the TLS files
RUN mkdir -p /etc/nginx/ssl

# create certificate need to comment for the different flags
RUN openssl req \
	-x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost/UID=rpol"

# create a directory to store the NGINX config file
RUN mkdir -p /var/run/nginx

# Copy our config file to our container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# give the permissions for root
RUN chmod 755 /var/www/html

# give the ownership of the directory to the user
RUN chown -R www-data:www-data /var/www/html

# launch NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]