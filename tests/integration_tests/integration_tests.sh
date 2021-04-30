#!/bin/bash

TIMEOUT=10

## PREREQUISITES:
# ${NGTCP2_FOLDER}/examples/server.key 
# ${NGTCP2_FOLDER}/examples/server.cert


# Taken from: https://stackoverflow.com/questions/9713104/loop-over-tuples-in-bash
for i in "full_encryption_via_A ./integration_tests_full_crypto_server.sh       ./integration_tests_full_crypto_client.sh"  "null_encryption_via_A ./integration_tests_null_crypto_server.sh       ./integration_tests_null_crypto_client.sh"  "full_encryption_via_B ./integration_test_over-B_full_crypto_server.sh ./integration_test_over-B_full_crypto_client.sh"  "full_encryption_via_B ./integration_test_over-B_null_crypto_server.sh ./integration_test_over-B_null_crypto_client.sh"



# for i in  "full_encryption_via_B ./integration_test_over-B_full_crypto_server.sh ./integration_test_over-B_full_crypto_client.sh" 
do
  set -- $i

  echo "-----------------------"
  echo "Test:   ${1}"
  echo "  Server:   ${2}"
  echo "  Client:   ${3}"
  echo "-----------------------"


  # ACT:
  echo " > running server..."
  timeout "${TIMEOUT}s" ${2} &

  echo " > running client..."
  # 1. Run client in parallel
  client_output=$( ${3} )
  wait

  echo "client_output:"
  echo "$client_output"



  # # ASSERT:
  # If statement written according to: https://unix.stackexchange.com/questions/48535/can-grep-return-true-false-or-are-there-alternative-methods
  if  echo "$client_output" | grep -q "1 started, 1 done, 1 succeeded, 0 failed, 0 errored, 0 timeout" ; then
    echo "TEST ${1}: [PASSED]"
  else
    echo "TEST ${1}: [FAILED]"
  fi


  echo "Finished test"
done