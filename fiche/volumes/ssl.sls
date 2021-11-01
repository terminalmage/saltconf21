include:
  - fiche.reqs

fiche-ssl:
  docker_volume.present:
    - require:
      - pip: docker
