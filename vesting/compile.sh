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

base_file=vesting-wallet # read private key from base_file.pk, save address in base_file.addr
start_time=1744095000 # unix time start time of the vesting
duration_time=134079000 # duration of the vesting in seconds
unlock_period=7887000 # period to unlock a portion of the vesting amount in seconds
cliff_period=0 # delay first unlock period by specific time in seconds
vesting_amount=2356278478 # vesting amount in Grams

rm vesting-lockup-wallet-code.fif
$func -o vesting-lockup-wallet-code.fif -SPA ../stdlib.fc vesting-lockup-wallet.fc
$fift -I ${inc} -s new-wallet.fif 0 1234 ${start_time} ${duration_time} ${unlock_period} ${cliff_period} ${vesting_amount} 0 ${base_file}
