FROM ubuntu:21.04

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install prereqs
RUN apt-get update
RUN apt-get -y install nginx

# Copy config
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx"]
