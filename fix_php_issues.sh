#Fixes PHP issues after installation (blank page, yiimp errors etc.)
#!/usr/bin/env bash

set -euxo pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

# PHP fixes
echo -e " Installing required PHP Packages..."

sudo apt install php8.1-memcache php8.1-memcached php7.3-memcache php7.3-memcached memcached php-memcached -y
sudo apt install php8.1-mysql php8.1-curl -y
sudo apt install php7.3-mysql php7.3-curl -y
sudo service nginx restart

set +euxo pipefail
cd $HOME
