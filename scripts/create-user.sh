#! /bin/bash
OPTIND=1         # Reset in case getopts has been used previously in the shell.

show_help ()
{
	echo "Usage: $(basename "$0") [-h] [-d ca_directory] USER_NAME -- program to create a server certificate request"
	echo "where:"
	echo "	-h: shows this help text"
	echo "	-d: specify the CA root directory. Defaults to the current working directory."
	echo "	USER_NAME: is name of the user. used in the certificate file name." 

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

#Determine the server name
if [[ ! $1 ]]; then
	echo "USER_NAME is required."
	show_help
	exit 0;
fi
USER_NAME=$1

#Create the user private key
openssl genrsa -aes128 \
      -out $CA_DIR/private/$USER_NAME.key.pem 1024
chmod 400 $CA_DIR/private/$USER_NAME.key.pem

#Make the csr directory in case it doesn't exist yet
mkdir -p $CA_DIR/csr

#Create the user request
openssl req -config $CA_DIR/openssl.cnf \
      -key $CA_DIR/private/$USER_NAME.key.pem \
      -new -sha256 -out $CA_DIR/csr/$USER_NAME.csr.pem
      
#Sign the certificate
openssl ca -config $CA_DIR/openssl.cnf \
      -extensions usr_cert -days 375 -notext -md sha256 \
      -in $CA_DIR/csr/$USER_NAME.csr.pem \
      -out $CA_DIR/certs/$USER_NAME.cert.pem
chmod 444 $CA_DIR/certs/$USER_NAME.cert.pem


