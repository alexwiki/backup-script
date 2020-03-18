#$1 is for the path we want to UNZIP FILES FROM (INCOMING FOLDER)

#$2 is for the path where we want to STORE the files (OUTGOING FOLDER)

#example ./scriptfor7z.sh /home/user/zippedfilesIN /home/user/unzippedfilesOUT LE_PASSWORD

for ourfile in "$1"/*
do
  echo "$ourfile"
  7z e  $ourfile  -o$2 -p$3
done

#The loop above returns us every file in the directory we write in our input


echo "example: ./scriptfor7z.sh /home/user/zippedfilesIN /home/user/unzippedfilesOUT LE_PASSWORD"

##### ./scriptfor7z.sh test test2 -pYOURPASS ####
