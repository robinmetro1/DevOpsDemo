FROM openjdk:17
EXPOSE 9090
ADD target/devops-demo.jar devops-demo.jar
ENTRYPOINT ["java","-jar","/devops-demo.jar"]