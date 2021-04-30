#!/bin/bash
nghttp2_folder="/root/evaluation/unencrypted_stack/nghttp2"

taskset -c 1 ip netns exec mr_client "${nghttp2_folder}/src/h2load" -P --npn-list h3 https://10.2.2.101:7777/1000000