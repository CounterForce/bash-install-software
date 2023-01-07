#!/bin/bash

# Check if the system is RHEL or Debian-based
if [ -f /etc/redhat-release ]; then
  # This is a RHEL system
  PKG_MANAGER="yum"
  APACHE2_PKG="httpd"
  NGINX_PKG="nginx"
  PHP_PKG="php"
  MARIADB_PKG="mariadb-server"
  PHPMYADMIN_PKG="phpmyadmin"
else
  # This is a Debian-based system
  PKG_MANAGER="apt-get"
  APACHE2_PKG="apache2"
  NGINX_PKG="nginx"
  PHP_PKG="php"
  MARIADB_PKG="mariadb-server"
  PHPMYADMIN_PKG="phpmyadmin"
fi

# Prompt the user to choose a web server
echo "Which web server do you want to install?"
echo "1. Apache2"
echo "2. Nginx"
read -p "Enter your choice [1-2]: " choice

# Install the selected web server
case $choice in
  1)
    # Check if Apache2 is installed
    if ! command -v apache2 > /dev/null; then
      # Install Apache2
      sudo $PKG_MANAGER update
      sudo $PKG_MANAGER install -y $APACHE2_PKG
    fi
    # Print the version of Apache2
    apache2 -v
    ;;
  2)
    # Check if Nginx is installed
    if ! command -v nginx > /dev/null; then
      # Install Nginx
      sudo $PKG_MANAGER update
      sudo $PKG_MANAGER install -y $NGINX_PKG
    fi
    # Print the version of Nginx
    nginx -v
    ;;
esac

# Check if PHP is installed
if ! command -v php > /dev/null; then
  # Install PHP
  sudo $PKG_MANAGER update
  sudo $PKG_MANAGER install -y $PHP_PKG
fi

# Check if MariaDB is installed
if ! command -v mysql > /dev/null; then
  # Install MariaDB
  sudo $PKG_MANAGER update
  sudo $PKG_MANAGER install -y $MARIADB_PKG
fi

# Check if PHPMyAdmin is installed
if [ ! -d "/usr/share/phpmyadmin" ]; then
  # Install PHPMyAdmin
  sudo $PKG_MANAGER update
  sudo $PKG_MANAGER install -y $PHPMYADMIN_PKG
fi

# Print the version of PHP
php -v

# Print the version of MariaDB
mysql -V
