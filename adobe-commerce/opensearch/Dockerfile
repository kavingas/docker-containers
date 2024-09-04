FROM opensearchproject/opensearch:2.12.0
ENV discovery.type=single-node
USER root
RUN yum -y install zip && \
    zip -q -d /usr/share/opensearch/lib/log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class && \
    yum remove -y zip && \
    yum -y clean all && \
    rm -rf /var/cache

ADD docker-healthcheck.sh /docker-healthcheck.sh
ADD docker-entrypoint.sh /docker-entrypoint.sh 
RUN chmod +x /docker-healthcheck.sh /docker-entrypoint.sh

USER opensearch
RUN rm -rf plugins/opensearch-security
RUN bin/opensearch-plugin install -b analysis-icu && \
    bin/opensearch-plugin install -b analysis-phonetic

ENTRYPOINT ["./opensearch-docker-entrypoint.sh"]
CMD ["opensearch"]