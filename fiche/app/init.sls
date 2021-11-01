{%- from "fiche/map.jinja" import fiche with context %}
{%- set buildroot = '{}/fiche/app'.format(fiche.docker_buildroot) %}

include:
  - fiche.reqs
  - fiche.volumes.storage

fiche-app:
  file.recurse:
    - name: {{ buildroot }}
    - source: salt://{{ tpldir }}/files
    - makedirs: True
    - template: jinja
    - context: {{ fiche | tojson }}
  docker_image.present:
    - name: {{ fiche.app.image }}
    - tag: {{ fiche.app.tag }}
    - build: {{ buildroot }}
    - require:
      - pip: docker
    - watch:
      - file: {{ buildroot }}
  docker_container.running:
    - name: {{ fiche.app.container }}
    - image: {{ fiche.app.image }}:{{ fiche.app.tag }}
    - port_bindings: 9999:9999
    - binds:
      - {{ fiche.volumes.storage }}:{{ fiche.web_root }}:rw
    - require:
      - pip: docker
      - docker_volume: {{ fiche.volumes.storage }}
    - watch:
      - docker_image: {{ fiche.app.image }}
