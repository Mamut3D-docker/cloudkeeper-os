FROM ubuntu:16.04

ENV name="cloudkeeper-os"

LABEL application=${name} \
      description="A tool for synchronizing appliances between AppDB and OpenStack site" \
      maintainer="janca@cesnet.cz"

SHELL ["/bin/bash", "-c"]

# update + dependencies
RUN apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install python-pip git gcc && \
    pip install --upgrade pip && \
    pip install grpcio pbr python-glanceclient keystoneauth1 oslo-config oslo-log && \
    pip install git+https://github.com/the-cloudkeeper-project/cloudkeeper-os.git

EXPOSE 50051

ENTRYPOINT ["cloudkeeper-os"]