#!/bin/bash

# Create Dockerfile
echo "FROM node:latest
WORKDIR /usr/src/app
COPY package.json . 
RUN npm install
COPY . .
CMD [ \"npm\", \"start\" ]" > Dockerfile

# Create package.json
echo "{
  \"name\": \"test\",
  \"version\": \"0.0.1\",
  \"description\": \"\", 
  \"main\": \"server.js\",
  \"scripts\": {
    \"start\": \"node server.js\"
  },
  \"dependencies\": {
    \"$1\": \"*\"
  }
}" > package.json

# Create server.json
echo "const lib = require('$1')
lib();" > server.js

# Run things
# Reference: https://unix.stackexchange.com/a/336433
# Run tcpdump on the docker interface alongside it
(sudo tcpdump -i docker0 -w capture.pcap tcp port 80 or tcp port 443) &
# Build and run the docker container, kill everything when it's done
(sudo docker build --no-cache -t "test" . && sudo docker run test ; kill "$$") &
# Kill everything if it runs for more than 5 minutes
(sleep 5m && kill "$$") &
wait
