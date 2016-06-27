#!/bin/bash

echo "###########################################"
echo "#"
echo "# Installing PHP..."
echo "#"
echo "###########################################"

apt-get install -y php5
apt-get install -y php5-common
apt-get install -y php5-dev

echo "###########################################"
echo "#"
echo "# Installing PHP extensions..."
echo "#"
echo "###########################################"

apt-get install -y php5-cli
apt-get install -y php5-fpm
apt-get install -y php5-curl
apt-get install -y php5-intl
apt-get install -y php5-xdebug
apt-get install -y php5-mcrypt
# apt-get install -y php5-redis
# apt-get install -y php5-mongo
apt-get install -y php5-gd
apt-get install -y php5-mysql

if [ ! -e "/etc/php5/fpm/conf.d/mcrypt.ini" ]; then
    cd /etc/php5/fpm/conf.d && sudo ln -s ../../mods-available/mcrypt.ini
fi

if [ ! -e "/usr/local/bin/composer" ]; then
    echo "###########################################"
    echo "#"
    echo "# Installing Composer..."
    echo "#"
    echo "###########################################"
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
fi
sudo composer self-update

echo "###########################################"
echo "#"
echo "# Configuring PHP FPM..."
echo "#"
echo "###########################################"

sed -i 's#listen = /var/run/php5-fpm.sock#listen = 127.0.0.1:9000#' /etc/php5/fpm/pool.d/www.conf

echo "###########################################"
echo "#"
echo "# Enabling PHP errors..."
echo "#"
echo "###########################################"

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
