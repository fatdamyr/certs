#! /bin/bash
OPTIND=1         # Reset in case getopts has been used previously in the shell.

show_help ()
{
	echo "Usage: $(basename "$0") [-h] [-d ca_directory] server_name -- program to create a server certificate request"
	echo "where:"
	echo "	-h: shows this help text"
	echo "	-d: specify the CA root directory. Defaults to the current working directory."
	echo "	server_name: is dns name of the server. used in the certificate file name." 

}

# Initialize our own variables:
CA_DIR=`pwd`

while getopts "h?d:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    d)
        CA_DIR=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

#Determine the directory to create the CA file structure in
if [[ ! $1 ]]; then
	echo "server_name is required."
	show_help
	exit 0;
fi
SERVER_NAME=$1


