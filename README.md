# grails-demo
This is a demo of running grails on OpenShift. The demo requires a grails source-to-image image, which can be made in the following steps:
```
cd s2i-grails
docker build -t grails-centos7 .
```

This will create the s2i image

You can then run an image with the following commands
```
s2i build https://github.com/jacobborella/grails-demo grails-centos7 grails-app
docker run -p 8080:8080 grails-app
```

This will start up a container with the source code installed. You can of course also refer to your own source repo instead. Mine is just added for convenience.

To run the s2i in OpenShift, create the docker image from the Dockerfile on the server, which hosts the OpenShift registry. Alternatively use *docker save* to export the image from your local machine and *docker load* to import it into the OpenShift registry. Then build the application in the following steps:

```
oc new-project demo
oc new-app grails-centos7~https://github.com/jacobborella/grails-demo
```

References:
* https://blog.openshift.com/create-s2i-builder-image/
* http://docs.grails.org/latest/guide/gettingStarted.html
