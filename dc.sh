#! /bin/bash

echo "Enter filename: "  
read name
count=1

mkdir downloadingtemp
curl -L $1 | grep -Eoi '<img [^>]+>' | cut -d\' -f6 | grep -v img > ./downloadingtemp/temp
file="./downloadingtemp/temp"

while read line
do
  wget -O ./downloadingtemp/$count $line
  soffice --headless --convert-to pdf ./downloadingtemp/$count --outdir ./downloadingtemp/
  ((count++))
done < $file

pdfunite $(find ./downloadingtemp/ -type f -name "*.pdf" | sort -V) "$name".pdf && rm -r downloadingtemp
