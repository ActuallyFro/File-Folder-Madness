#!/bin/bash

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
  cd "$2"

  echo "FOLDER Sizes:"
  echo "============="
  while read -r folder; do
    reportLine=`du -s "$folder" 2>/dev/null | sort -n`

    #HAX: WSL is reporting sizes in KB NOT BYTES... so appened a "K" to the end of the line -- remove 000 as needed
    sizeDu=`echo $reportLine | awk '{print $1"000"}'` 

    #split at first space:      sed 's/[^ ]* //'
    #remove leading whitespace: sed 's/ *$//g'
    fileName=`echo $reportLine | sed 's/[^ ]* //' | sed 's/ *$//g'`

    humanReportSize=`getHumanByteSize $sizeDu`
    padding=".............." #https://fabianlee.org/2021/06/09/bash-using-printf-to-display-fixed-width-padded-string/
    echo "($humanReportSize   ) | "$(printf "%s%s" "$sizeDu" "${padding:${#sizeDu}}")" | $fileName"
  done < <(find $searchFolder -maxdepth 1 -type d) #ignore .
}

if [ "$1" == "folders" ]; then
  if [ "$2" == "" ]; then
    PrintSubDirectorySizes "$1" "./"
  else
    PrintSubDirectorySizes "$1" "$2"
  fi
else
  echo "[ERROR] Please re-run with option 'folders'! (I don't understand '$1')"
  echo "        Ex: $0 folders <path>"

  # echo "[ERROR] Please re-run with option 'folders' or 'files'! (I don't understand '$1')"
  # echo "        Ex: $0 files <path>"
fi