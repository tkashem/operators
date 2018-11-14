#!/bin/sh

FILENAME="optional.configmap"
NAMESPACE="operators"
REPOSITORY="optional"
RELEASE="1.9.0"

# Remove leading and trailing double quotes, if there are any.
TOKEN="${TOKEN%\"}"
TOKEN="${TOKEN#\"}"

function cleanup() {
    rm -f ${FILENAME}.tar.gz
}
trap cleanup EXIT

tar czf ${FILENAME}.tar.gz ${FILENAME}.yaml

BLOB=$(cat ${FILENAME}.tar.gz | base64 -w 0)

curl -H "Content-Type: application/json" -H "Authorization: ${TOKEN}" -XPOST https://quay.io/cnr/api/v1/packages/${NAMESPACE}/${REPOSITORY} -d '
{
    "blob": "'"${BLOB}"'",
    "release": "'"${RELEASE}"'",
    "media_type": "helm"
}'
