d=$(date | sed s/\ /_/g | sed s/:/_/g)
cd ~/oslab/lab1
echo $d
mkdir -p crondir
mkdir crondir/$d
