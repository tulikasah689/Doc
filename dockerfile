# Base Imgae Tomcat 

FROM tomcat:latest

# Give the Label
LABEL maintainer = "shilpa bains"

# Copy the war file 
COPY target/first-webapp1.war /usr/local/tomcat/webapps/

#On which port it will run
EXPOSE 8080

# Run the tomcat server
CMD ["catalina.sh", "run"]

