#!/bin/bash

#Server connection details
HOST='172.19.7.251'
USER='ftpuser'
PASSWD='Bebeto'
#File to be transferred to the ftp server from the local directory
FILE='usersCreated.log'

#FTP operations:
#Connect to host
#Set file transfer mode to ascii(good when trasnferring only text files)
#change the remote directory
#transfer the file from local to remote system directory
#list remote directory files
#quit the FTP environment

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
ascii
cd upload
put $FILE
ls -la
quit
END_SCRIPT


#https://www.thegeekdiary.com/how-to-use-ftp-under-linux-to-transfer-files/