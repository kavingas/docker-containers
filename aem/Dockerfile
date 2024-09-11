# Step 1: Use the base OpenJDK 11 image
FROM adoptopenjdk:11-jre-hotspot

# Step 2: Set environment variables
ENV AEM_HOME=/opt/aem
ENV AEM_JAR=aem-quickstart.jar
ENV AUTHOR_PORT=4502
ENV AEM_RUNMODE=author
ENV JAVA_OPTS="-Xms2g -Xmx4g -XX:MaxPermSize=512m"

# Step 3: Create necessary directories
RUN mkdir -p ${AEM_HOME} ${AEM_HOME}/crx-quickstart ${AEM_HOME}/license

# Step 4: Copy the AEM jar and license file into the container
COPY ${AEM_JAR} ${AEM_HOME}/${AEM_JAR}

# Step 5: Expose port for AEM Author
EXPOSE ${AUTHOR_PORT}

# Step 6: Set the working directory
WORKDIR ${AEM_HOME}

STOPSIGNAL SIGINT

# Step 7: Command to run AEM Author
CMD ["sh", "-c", "java $JAVA_OPTS -jar $AEM_JAR -r $AEM_RUNMODE -p $AUTHOR_PORT"]
