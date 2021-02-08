source function.sh

#checking for number of arguments entered
if [ $# != 3 ]; then 
scriptinfo
exit 1
else
	echo "Your program started running......................"
fi

#Saving the parameters inside bash variables
par1=$1
par2=$2
par3=$3

d=$(date | sed s/\ /_/g | sed s/:/_/g)
echo "date_updated is $d"
mkdir -p $par2/temp
#tar -cvf $par2/$d.tar $par2/$d
dirstore $par1 $par3 $par2
