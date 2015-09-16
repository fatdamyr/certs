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

#Determine the server name
if [[ ! $1 ]]; then
	echo "server_name is required."
	show_help
	exit 0;
fi
SERVER_NAME=$1

#Create the server private key
openssl genrsa -aes256 \
      -out $CA_DIR/private/$SERVER_NAME.key.pem 2048
chmod 400 $CA_DIR/private/$SERVER_NAME.key.pem

#Create the server request
openssl req -config $CA_DIR/openssl.cnf \
      -key $CA_DIR/private/$SERVER_NAME.key.pem \
      -new -sha256 -out $CA_DIR/csr/$SERVER_NAME.csr.pem
      
#Sign the certificate
openssl ca -config $CA_DIR/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in $CA_DIR/csr/$SERVER_NAME.csr.pem \
      -out $CA_DIR/certs/$SERVER_NAME.cert.pem
chmod 444 $CA_DIR/certs/$SERVER_NAME.cert.pem


