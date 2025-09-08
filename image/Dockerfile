FROM jenkins/jenkins:jdk21

ENV JENKINS_HOME='/var/jenkins'
ENV CASC_JENKINS_CONFIG='/var/jenkins/casc_config'
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

WORKDIR ${JENKINS_HOME}
COPY config/ ${CASC_JENKINS_CONFIG}
COPY config/plugins.txt plagins.txt

RUN jenkins-plugin-cli --plugin-file ${JENKINS_HOME}/plagins.txt


