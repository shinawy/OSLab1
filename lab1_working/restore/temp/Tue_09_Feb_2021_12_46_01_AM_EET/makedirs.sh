a=0
function making(){
mkdir ../new_backup

for i in {3..10}
do 
	mkdir "test$i"
	touch "./test$i/test$i.cpp"
	tar -cvf "../new_backup/test$i.tar" "test$i" 
	gzip ../new_backup/"test$i.tar" 
	
done

}
