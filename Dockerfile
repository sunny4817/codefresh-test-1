FROM ruby:2.2.0

RUN apt-get update
RUN gem install fluentd 
RUN mkdir /etc/fluent
RUN apt-get install -y libcurl4-gnutls-dev make
RUN /usr/local/bin/gem install fluent-plugin-kafka && \
  /usr/local/bin/gem install fluent-plugin-secure-forward && \
  /usr/local/bin/gem install fluent-plugin-netflow && \
  /usr/local/bin/gem install fluent-plugin-gcloud-pubsub && \
  /usr/local/bundle/bin/secure-forward-ca-generate /tmp/ notasecret
#RUN /usr/local/bin/gem install fluent-plugin-elasticsearch
ADD fluent.conf /etc/fluent/
CMD ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]

