#!/bin/sh

if test -z "${1}" ; then
	echo "no filename option, replacing v300 copper FPGA file"
	filename=eth120_copper.bin
else
	echo "option is ${1}"
	filename=${1}
fi
echo "${filename}"
host=6
dstdir=/usr/local/bin/
serverip=192.168.8.${host}
if [ x${host} == x106 ]; then
	remotedir=
	usr_pw=
else
	remotedir=ftproot/
	usr_pw="-u qwu -p qwu123"
fi
echo "remote dir is ${remotedir}"
echo "usr_pw is ${usr_pw}"

# Get new executable from ftp server
cd ${dstdir}

touch /usr/afile && { rm /usr/afile; echo "read-write"; } || { echo "read-only"; mount -o remount, rw /usr; }

echo -n "get \"${filename}\" from ftp server... "
if ! ftpget ${usr_pw} ${serverip}  ${filename} ${remotedir}${filename}
then
  echo "Failed to get \"${filename}\" from ftp server... "
	exit
fi
echo "done"

ls -ld ${filename}
date