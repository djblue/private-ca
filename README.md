# private-ca

Simple repo to manage all of my self-signed ssl certificates using my own
private certificate authority (ca). This repo just includes the scripts I
use.

I always forget the openssl commands and this way I wont have to remember
anything. Also by creating a private ca, I can import it once and then
generate as many self signed certificates and they will all be recognized.

# configuration

All of the config variable are located in `vars.sh` which get imported
when needed.

# setup a ca

To get up and running, you need to setup your private ca as follows:

    $ ./ca.sh <ca-name>

For me, I would run:

    $ ./ca.sh 'DJBLUE CA'

    -- vars ------------------
    country = US
    state = Arizona
    locality = Prov
    organization = 
    --------------------------
    Generating RSA private key, 4096 bit long modulus
    ...++
    e is 65537 (0x10001)
    key added at ca/ca.key
    No value provided for Subject Attribute O, skipped
    ca 'DJBLUE CA' added at ca/ca.crt

Now I have a newly generate ca in the `ca/` directory. I am going to
import the public `ca/ca.crt` into any  browser/device/phone I want to
trust my self signed certificates. Any certificate I generate for a domain
will be signed by this ca.

# add a domain

    $ ./domain.sh www.example.com

    Adding www.example.com
    Generating RSA private key, 4096 bit long modulus
    ...++
    e is 65537 (0x10001)
    -- vars ------------------
    country = US
    state = Arizona
    locality = Prov
    organization = 
    --------------------------
    No value provided for Subject Attribute O, skipped
    Signature ok
    subject=/C=US/ST=Arizona/L=Prov/CN=www.example.com
    Getting CA Private Key

# refs

All of the work in this repo is based off on the tutorial [here](http://www.debiantutorials.com/create-your-private-certificate-authority-ca/).

NOTE: A change I made was to remove `-des3` from many of the commands
because I don't like entering passwords.

# license - MIT

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

