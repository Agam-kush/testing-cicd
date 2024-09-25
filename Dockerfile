FROM openjdk:11-jdk

# Install Jenkins
RUN wget -O /usr/local/bin/jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

# Create a Jenkins user
RUN useradd --system --shell /bin/bash jenkins

# Create a directory for Jenkins data
RUN mkdir -p /var/jenkins_home

# Set ownership of the data directory
RUN chown -R jenkins:jenkins /var/jenkins_home

# Expose Jenkins port
EXPOSE 8080

# Run Jenkins as the Jenkins user
USER jenkins
CMD ["java", "-jar", "/usr/local/bin/jenkins.war"]
