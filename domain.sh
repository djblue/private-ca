#!/bin/bash

# quickly sign a domain given that you have already setup your private ca

usage () {
  echo "USAGE: $0 <domain>"
  exit 1
}

if [ $# -ne 1 ]; then
  echo 'please specify domain you want to add'
  usage
fi

CA_KEY=ca/ca.key
CA_CRT=ca/ca.crt

if [ ! -f $CA_KEY ]; then
  echo "ca key not found at $CA_KEY"
  exit 1
fi

if [ ! -f $CA_CRT ]; then
  echo "ca certificate not found at $CA_CRT"
  exit 1
fi

DOM=$1 # domain name to add

echo "Adding $DOM"

DIR=${DOM}

mkdir -p $DIR

KEY=$DIR/server.key
CSR=$DIR/server.csr
CRT=$DIR/server.crt
BITS=4096
DAYS=365

if [ ! -f $KEY ]; then
  openssl genrsa -out $KEY $BITS
else
  echo "key already exists in $KEY"
  exit 1
fi

source vars.sh
CN=$DOM       # domain name

if [ ! -f $CSR ]; then
  openssl req -new -key $KEY  \
                   -out $CSR  \
                   -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$CN"
else
  echo "csr already exists in $CSR"
  exit 1
fi

if [ ! -f $CRT ]; then
  openssl x509 -req -days $DAYS     \
                    -in $CSR        \
                    -CAkey $CA_KEY  \
                    -CA $CA_CRT     \
                    -set_serial 01  \
                    -out $CRT
else
  echo "crt already exists in $CRT"
  exit 1
fi
