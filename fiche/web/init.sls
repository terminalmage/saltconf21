{%- from "fiche/map.jinja" import fiche with context %}
{%- set buildroot = '{}/fiche/web'.format(fiche.docker_buildroot) %}

include:
  - fiche.reqs
  - fiche.volumes.storage
  - fiche.volumes.ssl

fiche-web:
  file.recurse:
    - name: {{ buildroot }}
    - source: salt://{{ tpldir }}/files
    - makedirs: True
    - template: jinja
    - context: {{ fiche | tojson }}
  docker_image.present:
    - name: {{ fiche.web.image }}
    - tag: {{ fiche.web.tag }}
    - build: {{ buildroot }}
    - require:
      - pip: docker
    - watch:
      - file: {{ buildroot }}
  docker_container.running:
    - name: {{ fiche.web.container }}
    - image: {{ fiche.web.image }}:{{ fiche.web.tag }}
    - port_bindings: 443:443
    - binds:
      - {{ fiche.volumes.storage }}:{{ fiche.web_root }}:ro
      - {{ fiche.volumes.ssl }}:{{ fiche.ssl_dir }}:ro
    - require:
      - pip: docker
      - docker_volume: {{ fiche.volumes.storage }}
    - watch:
      - docker_image: {{ fiche.web.image }}
