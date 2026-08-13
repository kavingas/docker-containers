FROM opensearchproject/opensearch:2.19.4
ENV discovery.type=single-node
RUN rm -rf plugins/opensearch-security
ENTRYPOINT ["./opensearch-docker-entrypoint.sh"]
CMD ["opensearch"]
