#printing how the program works
function scriptinfo(){
echo "To run this program you have to enter 3 arguments:"
echo -e "\t1.name of directory to be backed up\n\t2.name of directory you wanna back up into\n\t3.encryption key"

}

#Checking for the number of arguments
function checkforargs(){
if [ $# != 3 ]; then 
	scriptinfo
else 
	echo "The Program Started............................"

fi




}

#printing parameters for testing
function echoparams(){
echo "parameter 1 is $1"
echo "parameter 2 is $2"
echo "parameter 3 is $3"

}

#looping over the directories in a certain directory
#it takes 5 parameters
#1. name of dir to loop over
#2. date variable update for renaming
#3. name of the tar file to update
#4. encryption key
#5. the folder to be backed up into 
function dirloop(){
a=0
#a is a flag to detect if there are somefiles
for dir in $1/*
do 

	      	
		updatedDir=$(echo $dir | perl -ne 'print "$1" if /.*\/(.*)/')
	       	echo "updated_intermediate dir name is $updatedDir"
		updated_name=$dir"_"$2.tgz
		updatedDir2=$(echo $updated_name | perl -ne 'print "$1" if /.*\/(.*)/')
		#echo "updated_nameforRenaming is $updated_name"
	if [ -d $dir ];then
		echo "$dir is a directory"
		tar -cPvf $updated_name.tar $dir
		gzip $updated_name.tar
		gpg --pinentry-mode loopback --passphrase $4 --symmetric $updated_name.tar.gz
		#mv $dir.tar.gz $updated_name
		echo "your third param is $3"
		echo "your naming is $updatedDir2.tar.gz"
		echo "your naming is $updated_name.tar.gz"
		cd $1
		tar -uPvf ../$3 $updatedDir2.tar.gz.gpg
		rm -r $updatedDir2.tar.gz $updatedDir2.tar.gz.gpg
		cd ..
	elif [ -f $dir ];then
		echo "$dir is a file"
		echo "$5 is the fifth param"
		cd $1
		tar -uPvf ../$5/files"_"$2.tar $updatedDir
		a=1
		cd ..


	fi 

done

if [ $a == 1 ];then 
cd $5

gzip files"_"$2.tar
gpg --pinentry-mode loopback --passphrase $4 --symmetric files"_"$2.tar.gz
tar -uPvf $2.tar files"_"$2.tar.gz.gpg
rm -r files"_"$2.tar.gz  files"_"$2.tar.gz.gpg
cd ..
fi
}


#looping over the directories in a certain directory TO RESTORE THEM
#it takes four parameters
#1. name of dir to loop over
#2. encryption key
#3. dir to restore the backup
#4. encryption key

function dirstore(){
a=0
#a is a flag to detect if there are somefiles
echo "This is the begining of dirstore"		
#name_created=$(echo $dir | perl -ne 'print "$1" if /.*\/(.*).tar.gpg/')
#name_created=$(echo $dir | perl -ne 'print "$1" if /.*\/(.*).tar.gpg/')

for dir in $1/*
do 	
	
	      	
		name_created=$(echo $dir | perl -ne 'print "$1" if /.*\/(.*).tar.gpg/')
	       	echo "updated_intermediate dir name is $name_created"
gpg --pinentry-mode loopback --passphrase $2 --output $3/temp/$name_created.tar --decrypt $dir 

cd $3/temp
mkdir $name_created
cd $name_created
tar -xvf ../$name_created.tar
cd ..
rm -r $name_created.tar
cd ..

echo "the required path is "
pwd
cd temp
	for subdir in $name_created/*
	do 
		echo "the subdirectory is $subdir"
		name_created2=$(echo $subdir | perl -ne 'print "$1" if /.*\/(.*).tar.gz.gpg/')
	       	echo "updated_intermediate2 dir name is $name_created2"
gpg --pinentry-mode loopback --passphrase $2 --output $name_created/$name_created2.tar.gz --decrypt $subdir
cd $name_created
tar -xzvf $name_created2.tar.gz 
rm -r $name_created2.tar.gz $name_created2.tar.gz.gpg
cd ..
pwd
done
cd ..
cd ..
pwd

done

if [ $a == 1 ];then 
cd $5

gzip files"_"$2.tar
gpg --pinentry-mode loopback --passphrase $4 --symmetric files"_"$2.tar.gz
tar -uvf $2.tar files"_"$2.tar.gz.gpg
rm -r files"_"$2.tar.gz  files"_"$2.tar.gz.gpg
cd ..
fi


}
