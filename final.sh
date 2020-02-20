#!/bin/bash
# The first arg ($1) is either lz4, zstd, bzip2, zip
# The second arg ($2) is the filename
# The third arg ($3) is either /home (folder we need)
#The first version of this script will zip files, we might want in the future to have folders too, encryption might be added later, also remote backup is in plans too.
#################################################################################
#	example ./final.sh bzip2 (encrypted) user@83.212.97.54			#
#	example2 ./final.sh bzip2 user@83.212.97.54				#
#										#
#	example3 ./final.sh bzip2 /home/backuped_files				#
#################################################################################

echo "execution of $0 with PID: $$ with total number of $# arguments, which $@ are in total "
#this is just a show off and reminder what these parameters do ;)


#1st segment where we check which compression algorithm the user wants to use
if [ $1 = "lz4" ];
then

lz4 $2
echo "$1"

elif [ $1 = "zstd" ];
then

zstd -D --train  * -o dictionary #create a dictionary given all the current directory files and name it "dictionary" NOTE THAT ZSTD ALGORITHMS NEEDS A LOT OF SMALL FILES TO TRAIN
zstd -D dictionary "$2" #zip it using the dictionary created
echo "$1"

elif [ $1 = "bzip2" ] ;
 then

bzip2 -zkf $2 #z: zip ,k keep ,f force overwrite existing output
echo "$1"

elif [ $1 = "zip" ] ;
then

zip $2.zip $2

else

echo "none selected!"

fi

#ok ,step 2 is to select or not the directory - pretty much the same with the file compression, just a "-r" in some commands











































exit 0  #if script has ended with no errors it prints exit code 0
