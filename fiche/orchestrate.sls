get_ssl_cert:
  salt.function:
    - name: state.apply
    - tgt: fichedemo
    - arg:
      - fiche.letsencrypt

run_app:
  salt.function:
    - name: state.apply
    - tgt: fichedemo
    - arg:
      - fiche
