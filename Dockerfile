FROM ubuntu:16.04

ARG branch=master
ARG version

ENV name="cloudkeeper-os"

LABEL application=${name} \
      description="A tool for synchronizing appliances between AppDB and OpenStack site" \
      maintainer="janca@cesnet.cz"
      version=${version} \
      branch=${branch}

SHELL ["/bin/bash", "-c"]

# update + dependencies
RUN apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install python-pip git gcc && \
    pip install --upgrade pip && \
    pip install grpcio pbr python-glanceclient keystoneauth1 oslo-config oslo-log webob && \
    pip install -e https://github.com/Mamut3D-docker/cloudkeeper-os.git.git@$vesion

# env
RUN useradd --system --shell /bin/false --create-home ${name} && \
    usermod -L ${name}

EXPOSE 50051 50505

USER ${name}

ENTRYPOINT ["cloudkeeper-os"]
