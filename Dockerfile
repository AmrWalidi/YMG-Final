FROM openjdk:8-jdk

ENV GLASSFISH_VERSION 4.1.1
ENV GLASSFISH_HOME /glassfish


RUN apt-get update && \
    apt-get install -y curl unzip zip inotify-tools && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://download.oracle.com/glassfish/4.1.1/release/glassfish-${GLASSFISH_VERSION}.zip \
    && unzip glassfish-${GLASSFISH_VERSION}.zip -d / \
    && mv /glassfish4 ${GLASSFISH_HOME} \
    && rm glassfish-${GLASSFISH_VERSION}.zip

EXPOSE 8080 4848 

WORKDIR /usr/local/glassfish4

COPY dist/HelloWeb.war  /glassfish/glassfish/domains/domain1/autodeploy/

CMD ["sh", "-c", "${GLASSFISH_HOME}/bin/asadmin start-domain -v"]
