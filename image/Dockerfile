FROM jenkins/jenkins:jdk21

ENV JENKINS_HOME='/var/jenkins'
ENV CASC_JENKINS_CONFIG='/var/jenkins/casc_config'
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

WORKDIR ${JENKINS_HOME}
COPY config/ ${CASC_JENKINS_CONFIG}
COPY config/plugins.txt plagins.txt

RUN jenkins-plugin-cli --plugin-file ${JENKINS_HOME}/plagins.txt

RUN mkdir -p /var/jenkins_home/.ssh && \
    ssh-keyscan github.com >> /var/jenkins_home/.ssh/known_hosts && \
    chown -R jenkins:jenkins /var/jenkins_home/.ssh && \
    chmod 700 /var/jenkins_home/.ssh


