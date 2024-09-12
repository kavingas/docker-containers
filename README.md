# Docker containers for multiple use cases

### AC install CLI command
```
php -d memory_limit=4G bin/magento setup:install \
--base-url=https://local.test/mysql-slave/pub/ \
--db-host=127.0.0.1:3406 \
--db-name=m246p5 \
--db-user=root \
--admin-firstname=Admin \
--admin-lastname=Test \
--admin-email=admin@test.com \
--admin-user=admin \
--admin-password=123123q \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--backend-frontname=admin \
--search-engine=elasticsearch7 \
--elasticsearch-host=127.0.0.1 \
--elasticsearch-port=9200 \
--elasticsearch-index-prefix=mysql_slave
```

## Galera Cluster

Under galera-cluster

```
docker-compose up
```
Node 1 - 3406
Node 2 - 3407
