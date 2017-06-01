# grails-demo
This project demoes how to create a grails source to image (s2i) build. Be aware of the following restrictions:
* Produced image is based on centos, which isn't for production use. I've used it for your convenience.
* The image only works for jar files. grails assemble must produce one and only one jar file in the build/libs folder.

To make the s2i builder available, run the following commands on the machine, where your docker installation resides:
```
cd s2i-grails
docker build -t grails-centos7 .
```

This will create the s2i image

You can then run an image with the following commands locally
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
