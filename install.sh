#! /bin/bash
# 
#################################################################################
#################################################################################
# Basic LEMP Setup
# Nginx, MariaDB, PHP7, ...
#
#
#################################################################################
#################################################################################
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
#
#
echo "--------------------------------------------------------------------"
echo ""
echo "                    SYSTEMUPDATE ; COMMON TOOLS ; NTP "
echo ""
echo "--------------------------------------------------------------------"
	apt-get update
	apt-get -y dist-upgrade
	apt-get -y install unzip software-properties-common python-software-properties ntp ntpdate git
echo "--------------------------------------------------------------------"
echo ""
echo ""
echo "Installiere Nginx, MariaDB, PHP7"
echo ""
echo ""
echo "--------------------------------------------------------------------"

#
# NGINX
#
	sudo apt-get install -y nginx
	sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
	sudo cp nginx-site /etc/nginx/sites-available/default.conf
	read -p "Nginx Datei editieren? (y/n)" MOD
		if [ $MOD = "y" ]; then
			sudo nano /etc/nginx/sites-available/default.conf
		fi
	sudo ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf
	sudo nginx -t
	sudo systemctl reload nginx
	sudo systemctl restart nginx
	systemctl enable nginx
	sudo echo 'cgi.fix_pathinfo=0' >> /etc/php/7.0/fpm/php.ini
		read -p "PHP.ini bearbeiten? (y/n)" INI
		if [ $INI = "y" ]; then
			sudo nano /etc/php/7.0/fpm/php.ini
		fi
		sudo systemctl restart php7.0-fpm
	sudo apt install -y mariadb-server mariadb-client
	systemctl enable mysql
mkdir ~/.ssh
chmod 700 ~/.ssh
	read -p "SSH Key hinterlegen? (y/n)" SSHKEY
		if [ $SSHKEY = "y" ]; then
			sudo nano  ~/.ssh/authorized_keys2
		fi
chmod 600 ~/.ssh/authorized_keys2
