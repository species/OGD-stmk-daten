#!/bin/bash

# written by Michael Maier (s.8472@aon.at)
# 
# 19.02.2014   - intial release
#

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.

###
### Standard help text
###

#if [ ! "$1" ] || [ "$1" = "-h" ] || [ "$1" = " -help" ] || [ "$1" = "--help" ]
if  [ "$1" = "-h" ] || [ "$1" = " -help" ] || [ "$1" = "--help" ]
then 
cat <<EOH
Usage: $0 [OPTIONS] 

$0 is a program to check OGD sources for updates - to finally add it to this repository

OPTIONS:
   -h -help --help     this help text

EOH
fi

###
### variables
###

ending=".url"

###
### working part
###


find . -maxdepth 1 -type d | while read -r line
do
  if [ "$line" = "." ]; then
    continue;
  fi
  echo "FOLDER: „$line“"

  cd "$line"

  urlfile=`ls -1 | grep "$ending\$"`
  #echo "urlfile(s): „$urlfile“"

    if [ ! "$urlfile" ]; then
      cd ..
      continue
    fi

  echo "$urlfile" | while read -r urlfilename
    do
      url=`cat "$urlfilename"`
      echo "Downloading file „$urlfilename“ from „$url“"
      wget -q -N $url
      if echo "${urlfilename%%.url}" | grep -q "zip$"; then
        cd Rohdaten
        echo "unzipping ${urlfilename%%.url}"
        unzip -f -o ../${urlfilename%%.url}
        cd ..
      fi
    done

  # wget - newer

  cd ..

done

# git add -u
# git commit -m "data update"
