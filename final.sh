#!/bin/bash
# The first arg ($1) is either lz4, zstd, bzip2, zip
# The second arg ($2) is the filename
# The third arg ($3) is either /home (folder we need)
#The first version of this script will zip files,(2nd version ) we might want in the future to have folders too, encryption might be added later, also remote backup is in plans too.
# we could also add some arguments (even regex) to match filenames (multiple filenames starting with AVAFO ,for example... ending with .h5...)

#
#################################################################################
#	example ./final.sh bzip2 (encrypted) user@192.168.1.5			#
#	example2 ./final.sh bzip2 user@192.168.1.5				#
#										#
#	example3 ./final.sh bzip2 /home/backuped_files				#
#the example below is currently correct      #
#	example4 ./final.sh bzip2 test.log file 				#
#################################################################################
#Some Colors would be nice too:
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
#tput setaf [1-7]
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`



##################################################
#echo "${red}red text ${green}green text${reset}"#
##################################################
echo "execution of $0 with PID: $red $$ $reset with total number of $yellow $# $reset arguments, which $magenta $@ $reset are in total "
#this is just a show off and reminder what these parameters do ;)

case "$3" in	#$3 is the third argument, where it should check if it's a file or a folder
"file")


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

zip $2.zip $2			#-e -> encrypt

elif [ $1 = "7z" ];
then
7z a $2

else

echo "none selected!"

fi

;;
######################################################################################################################################################################################
"folder") # $3 -> The third argument is defines if we have a folder or a file.
#run the same algorithms with folders...



if [ $1 = "lz4" ];
then

tar -I lz4 -cf folder.lz4 $2 # $2 is the folder's name OK IT WORKS!!
echo "$1"

elif [ $1 = "zstd" ];
then

zstd -D --train  * -o dictionary #create a dictionary given all the current directory files and name it "dictionary" NOTE THAT ZSTD ALGORITHMS NEEDS A LOT OF SMALL FILES TO TRAIN
#zstd -D dictionary "$2" #zip it using the dictionary created
tar -cf zstdfolder.tar "$2" #archive it as a file
#zstd -D dictionary "$2" #zip it using the dictionary created

echo "$1"

elif [ $1 = "bzip2" ] ;
 then
tar -cjf "$2".tar.bz2 $2
echo "$1"

elif [ $1 = "zip" ] ;
then

zip -r $2.zip $2

else

echo "none selected!"

fi

;;

*)
echo "Wrong selection , $3 is not a valid 3rd dargument"
;;
esac



echo "Example of usage: $red ./final.sh $cyan  bzip2/zstd/zip/lz4 $magenta  test.log $green file/folder $reset "

exit 0  #if script has ended with no errors it prints exit code 0
