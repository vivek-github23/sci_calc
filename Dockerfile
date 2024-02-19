FROM openjdk:11
COPY ./target/sci_calc-1.0-SNAPSHOT-jar-with-dependencies.jar.jar ./
WORKDIR ./
CMD ["java", "-jar", "sci_calc-1.0-SNAPSHOT-jar-with-dependencies.jar.jar"]
