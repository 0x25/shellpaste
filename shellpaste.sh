#!/bin/bash
# date 29/03/2016
# author 0x25
# chmod +x <script.sh>

# send file with curl directly in shell
# need curl, openssl

# -h : help
# -s : send file (-s path/to/file)
# -g : get file (-g token)
# -n : get file but nodelete

# openssh password 
secret="3d1tMeF0rS3kurP4ss"
#pasteshell url:port
server="vps260977.ovh.net"
port="80"
# temporary file
tmp="/tmp/"
tmpName="file.des3"
# openssl encrypt parmeter
enc="-des3" # openssl list-cipher-commands

tmpFile=${tmp}${tmpName}
sendUrl="http://${server}:${port}"
getUrl="http://${server}:$port/p/"

function sendFile {

	file=$1
	if [ -e $file ]; then
		openssl enc $enc -salt -a -in $file -out $tmpFile -pass pass:${secret}
		if [ -e $tmpFile ]; then
			curl -s -X POST --data-binary @${tmpFile} $sendUrl
			rm $tmpFile
		else
			echo "fail to create temporay file ..."
			exit 2
		fi
	else
		echo "no file ..."
		exit 1
	fi
}


function getFile {

	value=$1
	action=$2 # if action no delete
	if [ ! -z $value ]; then
		if [ -z $action ]; then
			curl -s -H "Action: delete" -o $tmpFile ${getUrl}${value}
		else
			curl -s -o $tmpFile ${getUrl}${value}
		fi
			if [ -e $tmpFile ]; then
				openssl enc $enc -salt -a -d -in $tmpFile -out myFile.txt -pass pass:${secret}
				rm $tmpFile
			else
				echo "no temporary file writen ..."
			exit 4
			fi
	else
		echo "empty token ..."
		exit 3
	fi
}

function help {

	echo ""
	echo "$0 [ -h | -s path/to/file | -g token ]"
	echo " -s to send a file"
	echo " -g to get a file from the token (file is write in myfile.txt)"
	echo " -n same as -g but don't delete file on the serveur"
	echo "file is remove after download it"
	echo "you can use the service without the script:"
	echo " $ curl -X POST --data-binary @/tmp/config.txt http://$server:$port"
	echo " $ curl http://$server:$port/p/TOKEN > myfile.txt"
	echo ""
}

while getopts "s:g:n:h" option; do

	case $option in
	s)
		sendFile $OPTARG
	 	;;
	g)
	 	getFile $OPTARG
		;;
	n)
		getFile $OPTARG "nodelete"
	  	;;
	h)
	  	help
	  	;;
	:)
		echo "$OPTARG need argument"
		exit 5
		;;
	*|\?)
	  	help
		;;
	esac
done

if [ $OPTIND -eq 1 ]; then 
	help
fi

