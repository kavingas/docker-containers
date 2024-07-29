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

## m2install

```
m2install.sh -f -v 2.4.7-p1 -s composer
```

## Sample data install CE

```
composer require magento/module-bundle-sample-data magento/module-catalog-sample-data magento/module-sales-sample-data magento/module-customer-sample-data magento/module-cms-sample-data magento/module-widget-sample-data magento/module-theme-sample-data magento/module-downloadable-sample-data magento/module-wishlist-sample-data magento/module-review-sample-data magento/module-tax-sample-data magento/module-configurable-sample-data magento/module-product-links-sample-data magento/module-msrp-sample-data magento/module-grouped-product-sample-data magento/module-catalog-rule-sample-data magento/module-sales-rule-sample-data magento/module-swatches-sample-data magento/module-offline-shipping-sample-data magento/sample-data-media
```