{%- from "fiche/map.jinja" import fiche with context %}

docker:
  pkg.installed:
    - pkgs: {{ fiche.reqs | tojson }}
  service.running:
    - name: {{ fiche.docker_service }}
    - enable: True
    - require:
      - pkg: docker
  pip.installed:
    - require:
      - pkg: docker
