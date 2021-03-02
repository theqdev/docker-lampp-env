
## Docker based LAMPP environment

This is a docker based LAMPP like environment, based on 3 containers:

* web-server _(CentOS 7, Apache 2.4, PHP 7.2)_
* mysql-server _(MariaDB 10.5.9)_
* pma-server _(phpMyAdmin 5.0.1)_

### Installation

```
git clone https://github.com/theqdev/docker-lampp-env.git 
cd docker-lampp-env
docker-compose up -d
```

### Running your code

Place your code under `html` directory. The web server is available at [http://localhost:8080](http://localhost:8080/).
You can access your web-server by SSH-ing into it using the following command:

```
docker exec -it web-server /bin/bash SSH into container
```

### Managing your database

The PMA container can be accessed at [http://localhost:5000](http://localhost:5000/). For larger imports you can place your mysql export files in the `mysql` directory then import using something like this:

```
docker exec -it mysql-server /bin/bash SSH into container
cd /home/mysql
mysql -u root -p my_database < DatabaseBackup.sql
```

You can find the default mysql credentials below:

```
mysql_host:mysql-server
mysql_user:root
mysql_pass:secret
```


##### Other useful commands:

* `docker ps` _List containers and their state_
* `docker logs -f web-server` _Get container logs_
* `docker ps -a -q | ForEach { docker stop $_ }` _Stop all containers_
* `docker exec -it web-server /bin/bash` _SSH into container_
* `docker rm -f $(docker ps -aq)` _Remove all containers_
* `docker-compose up -d --build` _Rebuild containers in the background_

_**Note***_ If ran on Windows, try to make sure you run both your docker instance + terminal as administrator, to avoid any weird issues.
