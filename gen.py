import argparse
import os.path
import jwt
from datetime import datetime

parser = argparse.ArgumentParser(description='''Generate a JWT token from a PEM file''')
parser.add_argument('app_id', help="The ID of the GitHub App")
parser.add_argument('pem', help="Path to .pem file downloaded from the GitHub App's page")
args = parser.parse_args()

# curl -H "Accept: application/vnd.github.machine-man-preview+json" https://api.github.com/apps/appname | jq .id
app_id = args.app_id
pem = args.pem

with open(pem) as fh:
    secret = fh.read()

ts = int(datetime.now().timestamp())
payload = {'iat': ts, 'exp': ts + 600, 'iss': app_id}

encoded = jwt.encode(payload, secret, algorithm = 'RS256')
print(encoded.decode('utf-8'))
