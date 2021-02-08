#!/bin/bash

source ~/oslab/lab1/function.sh

#checking for number of arguments entered
if [ $# != 3 ]; then 
scriptinfo
exit 1
else
	echo "Your program started running......................"
fi

#Saving the parameters inside bash variables
cd $1
par1=${PWD##*/}
echo "parameter1 is $par1"

cd $2
par2=${PWD##*/}
echo "parameter2 is $par2"

par3=$3

d=$(date | sed s/\ /_/g | sed s/:/_/g)
echo "date_updated is $d"
cd $2
cd ..
mkdir $par2/$d
echo 
#tar -cvf $par2/$d.tar $par2/$d
tar -cPf $par2/$d.tar -T /dev/null
dirloop $par1 $d $par2/$d.tar $par3 $par2
cd $par2
gpg --pinentry-mode loopback --passphrase $par3 --symmetric $d.tar
rm -r $d.tar $d
cd ..
