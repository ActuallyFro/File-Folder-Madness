#!/bin/bash

#List all directories in a folder, and thier sizes
folders=$(ls -l 2>/dev/null | grep "^d" | awk '{print $9}')

listFilesInFolderSizesDU(){
  for folder in $folders
  do
    echo "Folder: $folder"
    echo "Size: $(du -sh $folder 2>/dev/null)"
  done
}

listFilesInFolderSizes(){
  # for each folder, list all files and their sizes
  for folder in $folders; do
    folderSize=0
    echo "[debug] Folder: "$folder

    #for each file in the folder, add the size to the folderSize
    # THIS JUST LOOKS AT FILESIZE: for file in $(ls -l $folder | grep -v ^d | awk '{print $5}'); do
    # fileSize=$(echo $file | awk '{print $1}')

    FILES=("$folder"*)
    cd $folder
    for file in "${FILES[@]}"; do
      fileSize=$(ls -l "$file" 2>/dev/null | awk '{print $5}')
      echo "[debug]     Current File: "$file" (size:"$fileSize")"

      # echo "[debug]     Current File: "$file" (size:"$fileSize")"
      # folderSize=$(($folderSize + $fileSize))
    done
    cd ..

    sizeInKB=$(($folderSize / 1024))
    echo "[debug] Folder Size: "$folderSize" ("$sizeInKB" KB)"

  done
}


# Files in directory: du -s /mnt/c/Users/zasz_/Downloads/* | sort -n

getHumanByteSize(){
  #https://unix.stackexchange.com/questions/44040/a-standard-tool-to-convert-a-byte-count-into-human-kib-mib-etc-like-du-ls1
  echo "$1" | awk 'function human(x) {
          s=" B   KiB MiB GiB TiB EiB PiB YiB ZiB"
          while (x>=1024 && length(s)>1) 
                {x/=1024; s=substr(s,5)}
          s=substr(s,1,4)
          xf=(s==" B  ")?"%5d   ":"%8.2f"
          return sprintf( xf"%s\n", x, s)
        }
        {gsub(/^[0-9]+/, human($1)); print}'

}

PrintSubDirectorySizes(){
  # Top directory: du -s /mnt/c/Users/zasz_/Downloads/ | sort -n

  #store all directories in an array
  cd "$2"

  # folders="$(ls -l | grep "^d" | awk -F':[0-9]* ' '/:/{print $2}')" #https://unix.stackexchange.com/questions/70614/how-to-output-only-file-names-with-spaces-in-ls-al/70618
  #FAIL  folders=$(find -maxdepth 1 -type d)

  #iterate over each folder
  echo "FOLDER Sizes:"
  echo "============="
  # for folder in $folders; do
  while read -r folder; do
    # echo "[debug]     Folder: '"$folder"'"
    reportLine=`du -s "$folder" 2>/dev/null | sort -n`

    #HAX: WSL is reporting sizes in KB NOT BYTES... so appened a "K" to the end of the line -- remove 000 as needed
    sizeDu=`echo $reportLine | awk '{print $1"000"}'` 

    #split at first space:      sed 's/[^ ]* //'
    #remove leading whitespace: sed 's/ *$//g'
    fileName=`echo $reportLine | sed 's/[^ ]* //' | sed 's/ *$//g'`

    humanReportSize=`getHumanByteSize $sizeDu`
    padding=".............." #https://fabianlee.org/2021/06/09/bash-using-printf-to-display-fixed-width-padded-string/
    echo "($humanReportSize   ) | "$(printf "%s%s" "$sizeDu" "${padding:${#sizeDu}}")" | $fileName"
  done < <(find $searchFolder -maxdepth 1 ! -path . -type d) #ignore .
  # done < <(find $searchFolder -maxdepth 1 -type d)
}

# if $1 is "folder" then run PrintSubDirectorySizes $1
if [ "$1" == "folders" ]; then
  if [ "$2" == "" ]; then
    PrintSubDirectorySizes "$1" "./"
  else
    PrintSubDirectorySizes "$1" "$2"
  fi
else
  echo "[ERROR] Please re-run with option 'folders' or 'files'! (I don't understand '$1')"
  echo "        Ex: $0 folders <path>"
  echo "        Ex: $0 files <path>"
fi