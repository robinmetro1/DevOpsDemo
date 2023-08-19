FROM openjdk:17
EXPOSE 8080
ENV key="value"
ADD target/devops-demo.jar devops-demo.jar
ENTRYPOINT ["java","-jar","/devops-demo.jar"]
CMD ["-start"]