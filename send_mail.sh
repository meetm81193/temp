#!/bin/bash

send_mail () {
echo "Enter To. Address"
read TO
echo "Enter From. Address"
read FROM
echo "Enter Subject"
read SUB
echo "Enter message .txt file"
read MSG

EXT=$(echo $MSG | cut -f 2 -d '.')

if [ -f "$MSG" ]; then
  if [ "$EXT" == "txt" ]; then
    echo "Enter is the correct file"
  else
    echo "Entered extension is incorrect"
  fi
else
  echo "Entered file is incorrect"
fi
}
