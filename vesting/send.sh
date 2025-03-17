#!/bin/bash

if [[ -z "${EXEC_PATH}" ]]; then
  EXEC_PATH=/usr/bin/ion
fi

if [[ -z "${SRC_PATH}" ]]; then
  SRC_PATH=/usr/src/ion
fi

CRYPTO_EXEC_PATH=${EXEC_PATH}/crypto
CRYPTO_SRC_PATH=${SRC_PATH}/crypto

fift=${CRYPTO_EXEC_PATH}/fift
func=${CRYPTO_EXEC_PATH}/func

inc=${CRYPTO_SRC_PATH}/fift/lib/:${CRYPTO_SRC_PATH}/smartcont/

lite_client=${EXEC_PATH}/lite-client/lite-client
config=${EXEC_PATH}/global.config.json

base_file=vesting-wallet # base-file.pk is used to sign, base-file.addr to add in external message
dest_address=Ef-s8hV4a5OazTPE8IsbHHn1MP5vmmMoZpi4jclPyHsj55Wa
amount=400 # amount to be send

owner_address=$($fift -I ${inc} -s show-addr.fif ${base_file})
seqno=$($lite_client -C ${config} --cmd "runmethod ${owner_address} seqno")
seqno=${seqno#*result}
seqno=${seqno##*[}
seqno=$(echo ${seqno%]*} | xargs)

# multisig addr
$fift -I ${inc} -s wallet.fif ${base_file} ${dest_address} 1234 ${seqno} ${amount}
