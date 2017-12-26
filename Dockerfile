FROM jenkins/jenkins:lts
MAINTAINER miiro@getintodevops.com
USER root

# Install the latest Docker CE binaries
RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce \
#TODO the group ID for docker group on my Maipo is 999, therefore I can only run docker commands if I have same group id inside. 
# Otherwise the socket file is not accessible. Needs environment variables.
#ENV DOCKER_GID_ON_HOST “”
#
# This is not tested. Besides how to detect ifthe GID is not already taken ?
#
# define default command
# CMD if [ -n “$DOCKER_GID_ON_HOST” ]; then groupadd -g $DOCKER_GID_ON_HOST docker && gpasswd -a go docker; fi;
# When starting the container you can pass in this variable with
# -e “DOCKER_GID_ON_HOST=$(getent group docker | cut -d: -f3)”
#
#
  groupadd -g 999 docker && \
  usermod -a -G docker jenkins 
  
