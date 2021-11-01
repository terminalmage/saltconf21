#!/usr/bin/env sh

fqdn={{ fqdn }}
ssl_dir={{ ssl_dir }}
key_dir="$ssl_dir/keys"
key_file="$key_dir/$fqdn.key"
account_key="$key_dir/account.key"
csr_dir="$ssl_dir/csrs"
csr_file="$csr_dir/$fqdn.csr"
cert_dir="$ssl_dir/certs"
cert_file="$cert_dir/$fqdn.crt"

# Abort if anything fails
set -e

# Check whether renewing or not
renew_cert=no
while getopts r arg
do
    case "$arg" in
        r) renew_cert=yes;;
    esac
done

if test -e "$cert_file"; then
    if test "$renew_cert" != "yes"; then
        # Cert exists and not renewing
        echo "$cert_file exists and -r not passed, exiting."
        exit 0
    fi
fi

# Make directories if they don't already exist, and make sure keys dir has the
# proper permissions
mkdir -p "$key_dir" "$csr_dir" "$cert_dir"
chmod 700 "$key_dir"

# Make account and domain keys if not already present
test -e "$account_key" || openssl genrsa 4096 > "$account_key"
test -e "$key_file" || openssl genrsa 4096 > "$key_file"

# Generate the CSR
openssl req -new -sha256 -key "$key_file" -subj "/CN=$fqdn" > "$csr_file"

# Start nginx
nginx

# Generate the cert
python "{{ acme_clone }}/acme_tiny.py" \
    --account-key "$account_key" \
    --csr "$csr_file" \
    --acme-dir "{{ challenge_root }}" > "$cert_file.tmp"

# Now that we're sure the cert creation succeeded, rename temp cert file
mv "$cert_file.tmp" "$cert_file"

# Stop nginx
kill `cat "{{ nginx_pid_file }}"`
