FROM ubuntu:22.04

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    gnupg2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add the Jenkins repository key and repository
RUN wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
RUN apt-get update && apt-get install -y jenkins \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose the Jenkins port
EXPOSE 8080

# Start Jenkins and keep the container running
CMD service jenkins start && tail -f /var/log/jenkins/jenkins.log
