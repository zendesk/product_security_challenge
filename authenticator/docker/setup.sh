#!/bin/bash
#
# Generates self-signed certificate for nginx. Execute from within the
# authenticator/ directory

set -e

openssl req -newkey rsa:2048 -x509 -nodes -days 365 -keyout docker/localhost.key -out docker/localhost.crt -subj "/C=AU/ST=Victoria/L=Melbourne/O=Authentic Co./CN=localhost"