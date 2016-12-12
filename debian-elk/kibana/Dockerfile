FROM kibana:5.0.0-alpha4

RUN /usr/share/kibana/bin/kibana-plugin install timelion && \
    chown -R kibana:kibana /usr/share/kibana
