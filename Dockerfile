FROM jenkins/jenkins:latest

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG docker_gid

USER root

RUN echo "DOCKER_GID=${docker_gid}" \
    && apt-get update \
    && apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get -y install docker-ce \
    && update-rc.d -f docker remove \
    && groupmod -g ${docker_gid} docker \
    && usermod -a -G docker ${user}

USER ${user}

