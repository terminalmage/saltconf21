include:
  - fiche.reqs

fiche-storage:
  docker_volume.present:
    - require:
      - pip: docker

