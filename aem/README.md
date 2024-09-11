# AEM Author Instance Docker Setup

This repository contains a Docker setup for running an **Adobe Experience Manager (AEM) Author** instance using OpenJDK 11.

## Dockerfile Overview

This Dockerfile sets up an AEM Author instance by using an OpenJDK 11 base image and runs the AEM Quickstart JAR file with author mode enabled. 

### Steps in the Dockerfile:

1. **Use the base OpenJDK 11 image**:
   - The image `adoptopenjdk:11-jre-hotspot` is used as the base to provide the Java runtime environment required to run AEM.

2. **Set environment variables**:
   - `AEM_HOME`: The directory where AEM will be installed (`/opt/aem`).
   - `AEM_JAR`: The name of the AEM Quickstart JAR (`aem-quickstart.jar`).
   - `AUTHOR_PORT`: The port where the AEM Author instance will run (`4502`).
   - `AEM_RUNMODE`: Specifies that the instance will run in `author` mode.
   - `JAVA_OPTS`: Java runtime options including memory settings (`-Xms2g -Xmx4g`) and `MaxPermSize`.

3. **Create necessary directories**:
   - The directories for AEM (`/opt/aem`), the quickstart installation, and the license file are created in this step.

4. **Copy AEM JAR and license**:
   - The `aem-quickstart.jar` is copied into the AEM home directory. You can adjust this to match your setup for the license file if needed.

5. **Expose the AEM Author port**:
   - Expose port `4502` to make the AEM Author instance accessible.

6. **Set the working directory**:
   - The working directory is set to `/opt/aem`, where the AEM instance will run from.

7. **Stop signal configuration**:
   - Set the stop signal to `SIGINT`, which simulates a `Ctrl+C` to gracefully shut down the AEM process when stopping the container.

8. **Run AEM**:
   - The default command to run AEM Author is `java -jar aem-quickstart.jar -r author -p 4502`.

## Usage Instructions

### Prerequisites

Ensure you have Docker installed and running on your machine.

### Build the Docker Image

To build the Docker image, run the following command in the directory where your `Dockerfile` is located:

```bash
docker build -t aem-author .
