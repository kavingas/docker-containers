# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set the environment variable for the non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    curl \
    --no-install-recommends

# Install OpenJDK 11 (Java 11 Runtime)
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless \
    --no-install-recommends

# Clean up APT when done to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable for convenience
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Verify Java installation
RUN java -version

# Default command
CMD ["java", "-version"]
