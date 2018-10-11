# Specify a base image
# in this case, the image is node:alpine;
# node is the base image, alpine is the version of that image, alpine means the most compact version,
# you can also specify a version such as node:10.11.0 
FROM node:alpine



# specify working directory for the container
WORKDIR /usr/node-mongo-app



COPY ./package.json ./
# copy package.json or other files into container, so we can run the npm install etc
# ./ means the container's root directory IF no WORKDIR specifiied in Dockerfile, 
# otherwise, it will be the WORKDIR, in this case, the  ./ measns the /usr/app directory
# if we made some changes e.g. add a new dependency in the package.json file, then the docker will re-run the npm install


# install some dependencies
RUN npm install


# copy the entire foler into the WORKDIR in the container
# the reason we copy the entire foler files after "RUN npm install" is that, if we don't make change to the package.json file, then docker dont need to run the npm install again
# which means, if we only make changes to other files such as app.js / index.js, it won't run npm install again. all the above steps will be cached and only need to run the below steps e.g. copy the entire folder into container's WORKDIR and CMD
COPY ./ ./


EXPOSE 80

# default command (when start this image using "docker run imageName")
CMD ["npm","start"]




#NOTES:
# run "docker build . " in the terminal to build this image
# or tag the image with a tag name 
# run "docker build -t yourDockerAccount/mynodeimage ." 
#after building the image, run "docker run yourDockerAccount/mynodeimage"



#port mapping
#port mapping is only needed when we run the container.
# run "docker run -p 8080:8080 yourDockerAccount/mynodeimage"
# first 8080 means the local host port; second 8080 means the port inside the container
# anytime a request comes from 8080 port at localhost, will redirect to the 8080 port in the container
# ports do have to be the same e.g. can be 5000:8080



