# Base Imgae Tomcat 

FROM tomcat:latest

# Give the Label
LABEL maintainer = "tulika"

# Copy the war file 
COPY target/First-web-app.war /usr/local/tomcat/webapps/

#On which port it will run
EXPOSE 8080

# Run the tomcat server
CMD ["catalina.sh", "run"]

