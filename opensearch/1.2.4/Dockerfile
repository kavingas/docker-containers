FROM opensearchproject/opensearch:1.2.4
ENV discovery.type=single-node
RUN rm -rf plugins/opensearch-security
ENTRYPOINT ["./opensearch-docker-entrypoint.sh"]
CMD ["opensearch"]