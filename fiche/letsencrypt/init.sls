{%- from "fiche/map.jinja" import fiche with context %}
{%- set buildroot = '{}/fiche/letsencrypt'.format(fiche.docker_buildroot) %}

include:
  - fiche.reqs
  - fiche.volumes.ssl

fiche-letsencrypt:
  file.recurse:
    - name: {{ buildroot }}
    - source: salt://{{ tpldir }}/files
    - makedirs: True
    - template: jinja
    - context: {{ fiche | tojson }}
  docker_image.present:
    - name: {{ fiche.letsencrypt.image }}
    - tag: {{ fiche.letsencrypt.tag }}
    - build: {{ buildroot }}
    - require:
      - pip: docker
    - watch:
      - file: {{ buildroot }}
  docker_container.run:
    - name: {{ fiche.letsencrypt.container }}
    - image: {{ fiche.letsencrypt.image }}:{{ fiche.letsencrypt.tag }}
    - port_bindings: 80:80
    - ports: 80
    - binds:
      - {{ fiche.volumes.ssl }}:{{ fiche.ssl_dir }}:rw
    - replace: True
    - require:
      - pip: docker
      - docker_volume: {{ fiche.volumes.ssl }}
    - watch:
      - docker_image: {{ fiche.letsencrypt.image }}
    - order: first
