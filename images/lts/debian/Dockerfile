FROM sonarqube:lts

ENV SONARQUBE_HOME /opt/sonarqube

# Add SonarQube plugins
RUN set -ex; \
    cd $SONARQUBE_HOME/extensions/plugins; \
    curl \
        -L "https://binaries.sonarsource.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-2.2.0.608.jar" \
        -o sonar-ldap-plugin-2.2.0.608.jar \
    ; \
    curl \
        -L "https://github.com/gabrie-allaigre/sonar-auth-gitlab-plugin/releases/download/1.3.2/sonar-auth-gitlab-plugin-1.3.2.jar" \
        -o sonar-auth-gitlab-plugin-1.3.2.jar \
    ;

# Arguments to label built container
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION=lts

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>" \
      product="SonarQube" \
      version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Monogramm/docker-sonarqube" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="SonarQube" \
      org.label-schema.description="Open Source product for continuous inspection of code quality" \
      org.label-schema.url="https://www.sonarqube.org" \
      org.label-schema.vendor="SonarSource" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/Monogramm/docker-sonarqube" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="SonarQube" \
      org.opencontainers.image.description="Open Source product for continuous inspection of code quality" \
      org.opencontainers.image.url="https://www.sonarqube.org" \
      org.opencontainers.image.vendor="SonarSource" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.authors="Monogramm maintainers <opensource at monogramm dot io>"
