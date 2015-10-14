# OpenSSL Scripts

This project contains bash shell scripts to ease the use for creating certificates with OpenSSL.

## Create a Certificate Authority
To create a new certificate authority, run the _create-ca.sh_ script. By default this creates the CA in the current directory, but you can provide the directory to use as the first parameter.

```bash
create-ca.sh /etc/ca
```

## Create an Intermediate Certificate Authority
To create a new certificate authority, run the _create-intermediate-ca.sh_ script. By default this creates the intermediate CA using the CA in the current directory, but you can provide the CA directory to use as the first parameter. This will create the intermediate CA files in the <CA directory>/intermediate directory.

```bash
create-intermediate-ca.sh /etc/ca
```

