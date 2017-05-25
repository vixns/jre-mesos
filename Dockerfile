FROM openjdk:8-jre

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF \
    && echo "deb http://repos.mesosphere.com/debian jessie main" | tee -a /etc/apt/sources.list.d/mesosphere.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y --force-yes \
    mesos \
    && mkdir -p /jars /config \
    && rm -rf /var/lib/apt/lists/*

ENV MESOS_NATIVE_LIBRARY=/usr/local/lib/libmesos.so \
    MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so

COPY kafka.yml /config/kafka.yml
ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.9/jmx_prometheus_javaagent-0.9.jar /jars

RUN chmod 444 /jars/* && chmod 444 /config/*