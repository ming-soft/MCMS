FROM java
VOLUME /tmp
ADD docker-springboot-0.0.1-SNAPSHOT.jar app.jar
RUN bash -c 'touch /app.jar' ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]