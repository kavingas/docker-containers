# Use the official Apache image as a base
FROM httpd:2.4

# Set environment variables for user and group IDs
ARG USERID=1000
ARG GROUPID=1000

# Add a new user and group with the specified IDs
RUN groupadd -g ${GROUPID} custom_group && \
    useradd -u ${USERID} -g custom_group -d /var/www/html -s /bin/bash custom_user && \
    chown -R custom_user:custom_group /usr/local/apache2/htdocs

# Set environment variables for Apache to use the custom user/group
ENV APACHE_RUN_USER=custom_user \
    APACHE_RUN_GROUP=custom_group

# Expose port 80
EXPOSE 80 443

# Start Apache in the foreground
CMD ["httpd-foreground"]
