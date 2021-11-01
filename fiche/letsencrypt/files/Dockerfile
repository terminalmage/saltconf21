FROM ubuntu:21.04

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install prereqs
RUN apt-get update
RUN apt-get -y install nginx git python

# Clone the repo for the letsencrypt client
RUN git clone {{ acme_repo }} "{{ acme_clone }}"

# Make the challenge dir and subdirs needed by acme-tiny
RUN mkdir -p "{{ challenge_root }}"

# Copy config and script
COPY nginx.conf /etc/nginx/nginx.conf
COPY genssl.sh /usr/bin
RUN chmod +x /usr/bin/genssl.sh

CMD ["/usr/bin/genssl.sh"]
