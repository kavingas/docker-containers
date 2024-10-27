## Install Bash-it for rich cli experiance

https://bash-it.readthedocs.io/en/latest/installation/

```
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh
```

## Adobe Commerce install
```
php -d memory_limit=4G bin/magento setup:install \
--base-url=http://127.0.0.1/m247/pub/ \
--db-host=mariadb \
--db-name=m247 \
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
--search-engine=opensearch \
--opensearch-host=opensearch \
--opensearch-port=9200 \
--opensearch-index-prefix=m247
```
## VSCode Xdebug
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html/${workspaceFolderBasename}":"${workspaceFolder}"
            },
        }
    ]
}
```

## m2install

```
m2install.sh -f -v 2.4.7-p1 -s composer
```

## Sample data install CE

```
composer require magento/module-bundle-sample-data magento/module-catalog-sample-data magento/module-sales-sample-data magento/module-customer-sample-data magento/module-cms-sample-data magento/module-widget-sample-data magento/module-theme-sample-data magento/module-downloadable-sample-data magento/module-wishlist-sample-data magento/module-review-sample-data magento/module-tax-sample-data magento/module-configurable-sample-data magento/module-product-links-sample-data magento/module-msrp-sample-data magento/module-grouped-product-sample-data magento/module-catalog-rule-sample-data magento/module-sales-rule-sample-data magento/module-swatches-sample-data magento/module-offline-shipping-sample-data magento/sample-data-media
```

## RabbitMQ

```
bin/magento setup:config:set --amqp-host="rabbitmq" --amqp-port="5672" --amqp-user="guest" --amqp-password="guest" --amqp-virtualhost="/"
```