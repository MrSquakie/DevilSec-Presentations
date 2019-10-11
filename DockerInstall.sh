#!/bin/bash
echo -e "\e[92mAdding PGP Key..."
echo -e "\e[39m"
#Add PGP Key
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi

echo -e "\e[92mAdding Docker to APT repo..."
echo -e "\e[39m"
#Add Docker APT repo 
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list

if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi

echo -e "\e[92mUpdating Repo..."
echo -e "\e[39m"
#update
apt-get update

if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi

echo -e "\e[92mInstalling Docker...\n"
echo -e "\e[39m"
#Install docker itself
apt-get install docker-ce
if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi

echo -e "\e[92mStarting Docker Service...\n"
echo -e "\e[39m"
#run Docker
systemctl start docker
if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi


echo -e "\e[92mStarting Docker on boot...\n"
echo -e "\e[39m"
#Start docker on boot
systemctl enable docker
if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi

echo -e "\e[92mTesting docker install...\n"
echo -e "\e[39m"
#Test
docker run hello-world
if [ $? -eq 0 ] 
then
	echo -e "\e[92mSuccess \e[39m"
else
	echo -e "\e[91 Error... Aborting."
	exit
fi




##Setup for todays lecture
echo -e "\e[92mInstalling DVWA Docker container...\n \e[39m"
docker run -d --rm -it -p 80:80 vulnerables/web-dvwa #start docker container in background

#browser check
ps aux | grep firefox | grep -v grep >/dev/null #check if firefox is opened
if [ $? -eq 1 ]
then
	echo -e "\e[92m Browser is not open \e[39m"
	echo -e "\e[92m Opening browser \e[39m"
	firefox http://127.0.0.1/ &
else
	echo -e "\e[91mBrowser is open \e[39m"
	echo -e "\e[33mPlease navigate to http://127.0.0.1/  \e[39m"
fi


echo -e "\e[92mInstall successfull. Credentials are admin:admin but if you reset the database it will be admin:password \e[39m"
