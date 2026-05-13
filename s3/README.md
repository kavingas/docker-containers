# Testing S3 Remote Storage Integration with Adobe Commerce using MinIO

## Overview

This guide demonstrates how to set up and test Amazon S3 remote storage integration with Adobe Commerce in a local development environment using MinIO. MinIO is an open-source, S3-compatible object storage server that allows developers to test S3 functionality without requiring access to an actual AWS S3 bucket.

**Note:** This guide is intended for local development and testing purposes only. For production environments with access to AWS S3, follow the official Adobe Commerce S3 integration documentation.

## What is MinIO?

MinIO is a high-performance, S3-compatible object storage system that can run locally via Docker. It provides the same API as Amazon S3, making it an ideal solution for:
- Local development and testing
- CI/CD pipelines
- Situations where AWS access is not available or practical

**Official Repository:** https://github.com/minio/minio

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker and Docker Compose
- Adobe Commerce installation (local development environment)
- Access to modify Adobe Commerce core files (for local testing only)
- Basic understanding of Docker and Adobe Commerce CLI commands

## Setup Instructions

### Step 1: Deploy MinIO with Docker Compose

Create a `docker-compose.yaml` file with the following configuration:

```yaml
services:
  minio:
    image: quay.io/minio/minio:latest
    container_name: minio
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: minio
      MINIO_ROOT_PASSWORD: minio123
    ports:
      - "8880:9000"  # S3 API endpoint
      - "8881:9001"  # Web console
    volumes:
      - minio-data:/data
    restart: unless-stopped

volumes:
  minio-data:
    driver: local
```

**Port Configuration:**
- Port `8880`: S3-compatible API endpoint (mapped from container port 9000)
- Port `8881`: MinIO web console for bucket management

Start the MinIO service:

```bash
docker-compose up -d
```

Verify the service is running:

```bash
docker ps | grep minio
```

### Step 2: Access MinIO Console and Create Bucket

1. Open your web browser and navigate to: `http://localhost:8881`
2. Log in with the credentials:
   - **Username:** `minio`
   - **Password:** `minio123`
3. Create a new bucket named `pub-media` (or your preferred bucket name)
4. Set the bucket access policy to allow read/write operations

### Step 3: Configure Adobe Commerce for Remote Storage

Execute the following Adobe Commerce CLI command to configure S3 remote storage:

```bash
bin/magento setup:config:set \
  --remote-storage-driver="aws-s3" \
  --remote-storage-bucket="pub-media" \
  --remote-storage-region="us-east-1" \
  --remote-storage-key=minio \
  --remote-storage-secret=minio123 \
  --remote-endpoint=http://localhost:8881 \
  -n
```

**Configuration Parameters:**
- `--remote-storage-driver`: Set to `aws-s3` (required for S3 compatibility)
- `--remote-storage-bucket`: Name of the bucket created in MinIO
- `--remote-storage-region`: Use any valid AWS region (e.g., `us-east-1`)
- `--remote-storage-key`: MinIO access key (matches `MINIO_ROOT_USER`)
- `--remote-storage-secret`: MinIO secret key (matches `MINIO_ROOT_PASSWORD`)
- `--remote-endpoint`: MinIO console endpoint

### Step 4: Modify Adobe Commerce S3 Driver (Development Only)

**⚠️ Important:** This modification is required only for local MinIO testing because Adobe Commerce's S3 driver does not expose a configuration option for custom endpoints. This change should **NEVER** be applied to production environments.

Edit the file: `app/code/Magento/AwsS3/Driver/AwsS3Factory.php`

Locate the `createConfigured` method and add the endpoint override:

```php
public function createConfigured(
    array $config,
    string $prefix,
    string $cacheAdapter = '',
    array $cacheConfig = []
): RemoteDriverInterface {
    $config = $this->prepareConfig($config);
    
    // Add this line to override the S3 endpoint to point to MinIO
    $config['endpoint'] = 'http://localhost:8880';
    
    $client = new S3Client($config);
    $adapter = new AwsS3V3Adapter($client, $config['bucket'], $prefix);
    $cache = $this->cacheInterfaceFactory->create(
        // Custom cache prefix required to distinguish cache records for different sources.
        // phpcs:ignore Magento2.Security.InsecureFunction
        $this->cachePrefix ? ['prefix' => $this->cachePrefix] : ['prefix' => md5($config['bucket'] . $prefix)]
    );
    
    // ... rest of the method
}
```

**Why is this necessary?**
Adobe Commerce's S3 integration is designed to work exclusively with AWS S3 endpoints. There is no exposed configuration option to specify a custom S3-compatible endpoint. By adding the endpoint override in the code, we redirect all S3 API calls to our local MinIO instance at `http://localhost:8880`.

### Step 5: Apply Configuration and Test

After making the configuration changes, clean the Adobe Commerce cache:

```bash
bin/magento cache:clean
bin/magento cache:flush
```

For production mode, also run:

```bash
bin/magento setup:di:compile
bin/magento setup:static-content:deploy -f
```

### Step 6: Verify Remote Storage Integration

1. **Upload test media:**
   - Upload images through the Adobe Commerce admin panel
   - Or use the CLI to import products with images

2. **Check MinIO console:**
   - Navigate to `http://localhost:8881`
   - Browse to the `pub-media` bucket
   - Verify that files are being stored in MinIO

3. **Verify file access:**
   - Access product images on the storefront
   - Ensure images load correctly from MinIO

## Troubleshooting

### Common Issues

**Issue:** Images not appearing on the storefront
- **Solution:** Verify the MinIO container is running and accessible at `http://localhost:8880`
- Check Adobe Commerce logs: `var/log/system.log` and `var/log/exception.log`

**Issue:** Access denied errors
- **Solution:** Ensure the bucket policy in MinIO allows read/write operations
- Verify the access key and secret key are correctly configured

**Issue:** Connection timeout
- **Solution:** Check Docker container network settings
- Ensure ports 8880 and 8881 are not blocked by firewall

## Best Practices

1. **Never apply code modifications to production:** The endpoint override in `AwsS3Factory.php` is for local development only
2. **Use environment-specific configurations:** Consider using different credentials for different environments
3. **Secure your MinIO instance:** In shared environments, use strong passwords
4. **Monitor storage usage:** Regularly check MinIO storage to avoid disk space issues
5. **Backup important data:** MinIO data is stored in Docker volumes; ensure proper backup procedures

## Additional Resources

- [MinIO Documentation](https://min.io/docs/minio/linux/index.html)
- [Adobe Commerce Remote Storage Guide](https://experienceleague.adobe.com/docs/commerce-operations/configuration-guide/storage/remote-storage/remote-storage.html)
- [AWS S3 PHP SDK Documentation](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/welcome.html)

## Conclusion

Using MinIO for local S3 integration testing provides a cost-effective and efficient way to develop and test Adobe Commerce's remote storage capabilities without requiring AWS infrastructure. This setup is ideal for development, testing, and CI/CD pipelines.

For production deployments, always use genuine AWS S3 buckets with proper security configurations, IAM roles, and access policies.

---

**Last Updated:** November 2025  
**Tested with:** Adobe Commerce 2.4.x, MinIO Latest, Docker 20.x+