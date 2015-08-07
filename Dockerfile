############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM phusion/baseimage

# Update the repository
RUN apt-get update && \
    apt-get install -y nginx supervisor

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Copy supervisord configuration file
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod -R 777 /var/log/supervisor
RUN chmod -R 777 /etc/supervisor
RUN adduser vcap sudo; exit 0

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 8080

# Install Meteor
#RUN curl  https://install.meteor.com/ | sh
#RUN meteor create --example todos
#WORKDIR /todos

# Run Meteor and Nginx
# CMD ["/usr/bin/supervisord"]
CMD service nginx start