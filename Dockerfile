ARG NODE_VERSION=12
FROM node:${NODE_VERSION}
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl3 \
        libicu57

RUN rm -rf /var/lib/apt/lists/*
WORKDIR /azp
COPY ./start.sh /azp/
RUN chmod +x /azp/start.sh
CMD ["/azp/start.sh"]