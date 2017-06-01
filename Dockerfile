# grails-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Jacob Borella <jborella@redhat.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION x.x
ENV PATH $PATH:/opt/app-root/src/grails-3.3.0.M1/bin

#Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building grails" \
      io.k8s.display-name="builder x.y.z" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,grails"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum install -y zip
RUN wget https://github.com/grails/grails-core/releases/download/v3.3.0.M1/grails-3.3.0.M1.zip
RUN unzip grails-3.3.0.M1.zip
RUN rm grails-3.3.0.M1.zip
RUN yum install -y java-1.8.0-openjdk devel
RUN yum clean all -y


# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

#Set the default port for applications built using this image
EXPOSE 8080

#Set the default CMD for the image
CMD ["/usr/libexec/s2i/run"]

