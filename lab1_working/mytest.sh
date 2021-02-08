#hey honey 
#this is a hello function

Hello_func(){
	for dir in $1/*
	do 
		if [ -d $dir ]; then 
			echo $dir
		else 
			echo "$dir is not a directory"
		fi 
	done 


}

Hello_func $1
