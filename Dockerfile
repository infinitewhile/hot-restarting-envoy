# Pinning our use of Envoy to v1.14.1 (current stable as of writing)
FROM envoyproxy/envoy:v1.14.1

# Install python and clean up the build process
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Copy our start up files into the container image
COPY docker-bin/hot-restarter.py /usr/local/bin/hot-restarter.py
COPY docker-bin/start-envoy.sh /usr/local/bin/start-envoy.sh

# Just make 100% sure the start up scripts are executable
RUN chmod +x /usr/local/bin/hot-restarter.py
RUN chmod +x /usr/local/bin/start-envoy.sh

# Expose our Envoy listener port and the admin port
EXPOSE 10000
EXPOSE 9901

# Run our start up scripts on, well, start up
CMD ["/usr/local/bin/hot-restarter.py", "/usr/local/bin/start-envoy.sh"]