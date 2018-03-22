FROM mesosphere/mesos-slave:1.0.1-2.0.93.ubuntu1404

# ***************************************************************
#    JAVA 8 and python 3.5.1
# ***************************************************************

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN apt-get update && apt-get install -y wget software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 20000 && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 20000

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

COPY core-site.xml $HADOOP_CONF_DIR
COPY hdfs-site.xml $HADOOP_CONF_DIR

RUN add-apt-repository ppa:fkrull/deadsnakes && \
    apt-get update && apt-get install -y --force-yes python3.5



