# grails-s2i
This project demoes how to create a grails source to image (s2i) build. Be aware of the following restrictions:
* Produced image is based on centos, and isn't for production use. I've used it for your convenience.
* The image only works for jar files.
* *grails assemble* must produce one and only one jar file in the build/libs folder.

## Prerequisites
Install:
* Java (OpenJDK or Oracle distro, should work with both)
* Docker CE (https://www.docker.com/)
* s2i (https://github.com/openshift/source-to-image)
* git (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Then clone this project to a prefered place on your computer.

## Walk through
To make the s2i builder available, run the following commands, starting from the path you cloned the git repo to:
```
cd s2i-grails
docker build -t grails-centos7 .
```

This will create the s2i image

You can then run an image with the following commands locally
```
s2i build https://github.com/jacobborella/grails-demo grails-centos7 grails-app
docker run -d -p 8080:8080 grails-app
```
This will start up a container with the source code installed. You can of course also refer to your own source repo instead. Mine is just added for convenience.

Then you should be able to access the service, if using my code:
```
curl localhost:8080
```

To run the s2i in OpenShift, create the docker image from the Dockerfile on the server, which hosts the OpenShift registry. Alternatively use *docker save* to export the image from your local machine and *docker load* to import it into the OpenShift registry. Then build the application in the following steps:

```
oc new-project demo
oc new-app grails-centos7~https://github.com/jacobborella/grails-demo
```
Alternatively the folder *ocp-templates* contains a template called *grails-s2i.yaml* for deploying a grails application in OpenShift using the image. To make it available, use
```
oc create -f grails-s2i.yaml -n openshift
```
Now the template will be available in the GUI or you can use *oc process* from the command line.

References:
* https://blog.openshift.com/create-s2i-builder-image/
* http://docs.grails.org/latest/guide/gettingStarted.html
