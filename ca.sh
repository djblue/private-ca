#!/bin/bash

DIR=ca            # directory to put certs
KEY=$DIR/ca.key   # key filename
CRT=$DIR/ca.crt   # certificate filename
BITS=4096         # number of bits for key
DAYS=3650         # number of days the ca is valid (10 years default)

usage () {
  echo "USAGE: $0 <ca-name>"
  exit 1
}

if [ $# -ne 1 ]; then
  echo 'please specify certificate authority name'
  usage
fi

source vars.sh
CN=$1

mkdir -p $DIR

# generate a private ca key, you will need to set the passphrase
if [ ! -f $KEY ]; then
  openssl genrsa -out $KEY $BITS
  chmod 600 $KEY
else
  echo "key already exists in $KEY"
  exit 1
fi

echo "key added at $KEY"

# generate the ca certificate, this is the top level certificate you will
# need to import into devices to get them to trust your signed
# certificates. The output file is public.
if [ ! -f $CRT ]; then
  openssl req -new -x509        \
                   -days $DAYS  \
                   -key $KEY    \
                   -out $CRT    \
                   -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$CN"
else
  echo "certificate already exists in $CRT"
  exit 1
fi

echo "ca '$CN' added at $CRT"

