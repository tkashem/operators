
## Push Manifest to quay.io
* Execute `login.sh` by providing your `quay.io` account user name and password as arguments
```bash
# Make sure you are at the root folder of the repo 
# First, grab a token from quay.io
$ TOKEN=$(./quay-login.sh ${USER_NAME} ${PASSWORD} | jq -r .token)

# Now, change directory to your desired manifest folder
$ cd rh-operators

# Make sure, you bump the version of the manifest.
# Bump the release specified in RELEASE in push.sh
RELEASE="1.1.0"

# Push the Manifest now.
$ ./push.sh
```