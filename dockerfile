# Use the official NGINX image as the base
FROM nginx:alpine

# Copy your static website files to the default NGINX directory
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80
