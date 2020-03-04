#!/bin/bash

#if you want to use something else than "dictionary" as a dictionary for zstd then you should change it. e.g. dictionary -> $2 (which you will input it when running the command e.g. ./decompress myzippedfile.zst mydictionary
#What could we automate? an extension identifier should be useful (automatically identify .zip .zstd .bzip2 .lz4)
#either with folder or not we should not care about the unzip arguments. (there is not a special argument (e.g. -r --folder ) which we should care about.

#$1 is the first attribute, which is the name of the file which we want to decompress (e.g. zipped.zst zipped.lz4...)




suffix=$(echo $1 | cut -d "." -f2 ) #we get the ending (suffix) of a file and we store it in a variable
case "$suffix" in

".lz4")

lz4 -d $1

".zst")
#
#
#    Create the dictionary
#
#    zstd --train FullPathToTrainingSet/* -o dictionaryName
#
#    Compress with dictionary
#
#    zstd -D dictionaryName FILE
#
#    Decompress with dictionary
#
#    zstd -D dictionaryName --decompress FILE.zst

zstd -D dictionary --decompress $1 #the dictionary filename SHOULD BE dictionary


".bzip2")

bzip2 -d $1

".zip")

unzip $1 #if the file exists already ,in this step we will be asked to select if we want to replace it or not.

".7z")

7z e $1

echo "example of usage: ./decompress myzippedfile.zst .zip .bzip2 .lz4 folder_to_be_decompressed"

;;
esac
