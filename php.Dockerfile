FROM centos:7

# Install Apache
RUN yum -y update
RUN yum -y install httpd httpd-tools

# Install EPEL Repo
RUN yum install epel-release yum-utils -y \
 && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Set PHP Version to be installed
RUN yum-config-manager --enable remi-php74

# Install PHP
RUN yum install php php-common php-bcmath php-opcache php-mcrypt php-cli php-gd php-curl php-mysql php-pear php-soap php-xml php-xmlrpc -y

# Install Node
RUN yum install -y composer
RUN curl –sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs

# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf

# Workaround for using systemctl
COPY ./tools/systemctl.py /usr/bin/systemctl
RUN chmod a+x /usr/bin/systemctl

# Vim who? + Utilities
RUN yum -y install nano
RUN yum -y install zip unzip

EXPOSE 80

# Start Apache
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]