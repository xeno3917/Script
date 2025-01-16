# Note: déployer avec un bridge de type macvlan pour forcer des IP sur le routage
FROM eclipse-temurin:21-jre-alpine
RUN mkdir -p /var/hah
WORKDIR /var/hah
ENTRYPOINT ["sh", "-c", "java -jar HentaiAtHome.jar --disable_logging"]
