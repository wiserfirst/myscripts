#!/bin/sh

if test -z "${1}" ; then
	echo "no filename option, using default"
	filename=mx300_ether
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
cd /home/root
echo -n "get \"${filename}\" from ftp server... "

if ! ftpget ${usr_pw} ${serverip}  ${filename} ${remotedir}${filename}
then 
	echo "get ${filename} from ${serverip} failed!"
	exit
fi

echo "done"
chmod +x ${filename}
touch /usr/afile && { rm /usr/afile; echo "read-write"; } || { echo "read-only"; mount -o remount, rw /usr; }

cp ${filename} ${dstdir}
cd ${dstdir}
ls -ld ${filename}
date
