#!/bin/bash

# Get curl with HTTP/2 and openssl with ECDSA: 'brew install curl openssl'
curl=/usr/local/opt/curl/bin/curl
openssl=/usr/local/opt/openssl/bin/openssl

# --------------------------------------------------------------------------

deviceToken=714800B9F3FABD2FFA3513C49C2C89E36681A0ECBCBB488C52D0FD50899A6CA3
# deviceToken=CFA3033864D7EBFB0F2EE6CEC90C7053D2BFBE159F6495D99114EDA9C2485F99

authKey="./APNsAuthKey_Y9JHHPYRM7.p8"
authKeyId=Y9JHHPYRM7
teamId=QKNV954376
bundleId=ru.keegan.apnsTest
endpoint=https://api.development.push.apple.com


read -r -d '' payload <<-'EOF'
{
   "aps": {
      "alert": {
         "body": "Game Request",
      }
      
   },
}
EOF

# --------------------------------------------------------------------------

base64() {
   $openssl base64 -e -A | tr -- '+/' '-_' | tr -d =
}

sign() {
   printf "$1"| $openssl dgst -binary -sha256 -sign "$authKey" | base64
}

time=$(date +%s)
header=$(printf '{ "alg": "ES256", "kid": "%s" }' "$authKeyId" | base64)
claims=$(printf '{ "iss": "%s", "iat": %d }' "$teamId" "$time" | base64)
jwt="$header.$claims.$(sign $header.$claims)"

   # --header "apns-collapse-id: test1" \

$curl --verbose \
   --header "content-type: application/json" \
   --header "authorization: bearer $jwt" \
   --header "apns-topic: $bundleId" \
   --data "$payload" \
   $endpoint/3/device/$deviceToken