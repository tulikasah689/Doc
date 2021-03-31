# Base Imgae Tomcat 

FROM tomcat:latest

# Give the Label
LABEL maintainer = "shilpa bains"

# Copy the war file 
COPY target/first-web-app1.war /usr/local/tomcat/webapps/

#On which port it will run
EXPOSE 8095

# Run the tomcat server
CMD ["catalina.sh", "run"]

