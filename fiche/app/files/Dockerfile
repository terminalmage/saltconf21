FROM ubuntu:21.04

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install prereqs
RUN apt-get update
RUN apt-get -y install git build-essential

# Clone the project
RUN git clone {{ fiche_repo }} "{{ fiche_clone }}"

# Build and install
RUN make -C "{{ fiche_clone }}" && make -C "{{ fiche_clone }}" install

CMD ["fiche", "-S", "-d", "{{ fqdn }}", "-o", "{{ web_root }}"]
