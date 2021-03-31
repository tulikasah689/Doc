# Base Imgae Tomcat 

FROM tomcat:latest

# Give the Label
LABEL maintainer = "Shilpa"

# Copy the war file 
COPY First-web-app/target/Firstweb-app.war /usr/local/tomcat/webapps/

#On which port it will run
EXPOSE 8095

# Run the tomcat server
CMD ["catalina.sh", "run"]

