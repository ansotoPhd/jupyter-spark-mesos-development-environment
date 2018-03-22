FROM ubuntu:16.04

# ***************************************************************
#    SO applications
# ***************************************************************

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default lsb-release && \
  apt-get install -y python3=3.5.1* python3-setuptools python3-pip vim && \
  apt-get clean all


# ***************************************************************
#    MESOS
# ***************************************************************

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
    CODENAME=$(lsb_release -cs) && \
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main"|  tee /etc/apt/sources.list.d/mesosphere.list && \
    apt-get update && \
    apt-get -y install mesos


# ***************************************************************
#    HADOOP
# ***************************************************************

ENV HADOOP_VERSION 2.7.2
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN wget -q http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar -xzf hadoop-$HADOOP_VERSION.tar.gz -C /usr/ \
    && rm -rf $HADOOP_HOME/share/doc \
    && rm hadoop-$HADOOP_VERSION.tar.gz


# ***************************************************************
#    SPARK
# ***************************************************************

ENV SPARK_HOME /opt/spark
RUN cd /tmp && wget http://apache.rediris.es/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz && \
    tar -xvf spark-2.2.0-bin-hadoop2.7.tgz && mv spark-2.2.0-bin-hadoop2.7 /opt/spark


# ***************************************************************
#    JUPYTER AND APACHE TOREE
# ***************************************************************

RUN alias python=python3
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade jupyter
RUN python3 -m pip install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0/snapshots/dev1/toree-pip/toree-0.2.0.dev1.tar.gz && \
    jupyter toree install --spark_home=/opt/spark
RUN python3 -m pip install --upgrade jupyter-client==5.2.3


ADD ./apache-toree-kernel/kernel.json /usr/local/share/jupyter/kernels/apache_toree_scala
ADD ./pyspark-kernel/* /usr/local/share/jupyter/kernels/python3/

COPY ./hdfs-conf-files/core-site.xml $HADOOP_CONF_DIR
COPY ./hdfs-conf-files/hdfs-site.xml $HADOOP_CONF_DIR

ENV SHELL /bin/bash

# ***************************************************************
#    ENTRYPOINT
# ***************************************************************

RUN mkdir /workspace && echo "jupyter notebook --allow-root --notebook-dir=/workspace --NotebookApp.token=''" \
    > run_jupyter.sh && chmod +x run_jupyter.sh
ENTRYPOINT /run_jupyter.sh