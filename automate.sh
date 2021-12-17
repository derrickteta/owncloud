#!/bin/bash
##install docker
sudo apt update 
sudo apt -y install curl 

#First, in order to ensure the downloads are valid, 
#add the GPG key for the official Docker repository to your system:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get update
sudo apt-get install -y docker-ce

#If you want to avoid typing sudo whenever 
#you run the docker command, add your username to the docker group:
sudo usermod -aG docker ${USER}

#To apply the new group membership, you can log 
#out of the server and back in, or you can type the following:
su - ${USER} #after this it ask user password


# install simplescreenrecorder

sudo add-apt-repository --yes ppa:maarten-baert/simplescreenrecorder
sudo apt-get update
sudo apt-get -y install simplescreenrecorder

#install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \ 
chmod +x kubectl

#move kubectl in user execution folder
sudo mv ./kubectl /usr/local/bin/kubectl

#see kubectl version

kubectl version

## install minikube
#load minikube binary
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& chmod +x minikube

#move minikube in user binary folder

sudo mv minikube /usr/local/bin
#see minikube version
minikube version

#create a cluster minikube 
minikube start

#launch the dashboard

minikube dashboard

#clone owcloud repository
git clone https://github.com/derrickteta/ocis.git

#enter in the folder
cd ocis

#create image from the docker file 
docker build -t ocisimage .

#run the container

docker container run -d --name ocis -it -p 9200:9200 ocisimage 


#stop the container
docker stop ocis

#launch the deployment on kubernetes

kubectl create -f ocis-deployment.yaml

# launch the service 

kubectl create -f ocis-service.yaml






