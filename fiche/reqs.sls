reqs:
  pkg.installed:
    - pkgs:
      - python3-pip
      - docker.io

docker:
  pkg.installed:
    - pkgs:
      - python3-pip
      - docker.io
  service.running:
    - enable: True
    - require:
      - pkg: docker
  pip.installed:
    - require:
      - pkg: reqs
