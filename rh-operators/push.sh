#!/bin/sh

FILENAME="rh-operators"
NAMESPACE="operators"
REPOSITORY="rh-operators"
RELEASE="1.1.0"

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
