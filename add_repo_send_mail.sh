#!/bin/bash
# -----------------------------------------------------------------------------
# AUTHOR         : Meet Mehta
# FILE NAME      : svn_ci.sh
# DESCRIPTION    : This file take input for svn check in and sends email.
# -----------------------------------------------------------------------------

echo "Enter path of the file or directory"
read PATHSS
echo "Enter commit message"
read MSG

IFS='/' read -r -a ADDR <<< "$PATHSS"

#creatingTeMp file
rm -f TeMp
touch TeMp

LAST_ELEMENT="${ADDR[-1]}"

# Validating input file or directory
if [ -f "$LAST_ELEMENT" ]; then
  if git add $LAST_ELEMENT >> TeMp; then
    if git commit -m ""$MSG"" >> TeMp; then
      echo "File commited"
    else
      echo "File commit failed"
    fi
  else
    echo "File not exist"
  fi
elif [ -d "$LAST_ELEMENT" ]; then
  if git add $LAST_ELEMENT >> TeMp; then
    echo "Directory added"
    if git commit -m ""$MSG"" >> TeMp; then
      echo "Directory commited"
    else
      echo "Directory commit failed"
    fi
  else
    echo "Directory not exist"
  fi
else
  echo "Entered value is incorect"
fi 

send_mail() {
# Take Mail Input
  echo "Enter To. Address"
  read TO
  echo "Enter From. Address"
  read FROM
  echo "Enter Subject"
  read SUB
  
  sed -i "1s/^/Hello Team,\n/" TeMp
  sed -i "2s/^/\t"$MSG",\n/" TeMp
  echo "Thank You" >> TeMp
  echo "Meet Mehta" >> TeMp
  
  mail -s "$SUB" -r "$FROM" "$TO" < TeMp
}
