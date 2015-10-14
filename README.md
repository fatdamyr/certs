# OpenSSL Scripts

This project contains bash shell scripts to ease the use for creating certificates with OpenSSL.

## Create a Certificate Authority
To create a new certificate authority, run the _create-ca.sh_ script. By default this creates the CA in the current directory, but you can provide the directory to use as the first parameter.

```bash
create-ca.sh /etc/ca
```

This scripts creates the following directory structure:
* certs - Stores the generated public certificates for the CA as well as any servers signed by this authority.
* crl - Stores the certificate revocation list
* private - Stores the private key files for the CA and any certificates create by these scripts.
* csr - Stores certificate request files


## Create an Intermediate Certificate Authority
To create a new certificate authority, run the _create-intermediate-ca.sh_ script. By default this creates the intermediate CA using the CA in the current directory, but you can provide the CA directory to use as the first parameter. This will create the intermediate CA files in the <CA directory>/intermediate directory.

```bash
create-intermediate-ca.sh /etc/ca
```

## Create a Server Certificate 
To create a server certificate, run the _create-server.sh_ script. By default this creates the certificate using the CA in the current directory, but you can provide the CA directory to use using the -d parameter. The name of the server should be passed as the first parameter. The signed server certificate will be placed in the <CA directory>/certs and the generated private key in the <CA directory>/private.

```bash
create-server.sh -d /etc/ca www.example.com
```

