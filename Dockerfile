FROM nvidia/cuda:10.0-base-ubuntu18.04


ENV GRADLE_VERSION 4.10.2
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install Python 3.6
RUN apt-get update && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:deadsnakes/ppa && \
        apt-get update -y  && \
        apt-get install -y build-essential python3.6 python3.6-dev python3-pip && \
        apt-get install -y git  && \
        python3.6 -m pip install pip --upgrade && \
        python3.6 -m pip install wheel


# Install JAVA 8
RUN apt-get update && \
    apt-get -y install openjdk-8-jdk wget curl unzip xz-utils python build-essential ssh git locales

# Configure locale to UTF-8
RUN locale-gen en_US.UTF-8

# Setup certificates in openjdk-8
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Set path
ENV PATH ${PATH}:/usr/local/gradle-$GRADLE_VERSION/bin

RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip