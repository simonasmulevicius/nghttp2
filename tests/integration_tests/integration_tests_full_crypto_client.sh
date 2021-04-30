#!/bin/bash
nghttp2_folder="/root/evaluation/unencrypted_stack/nghttp2"

"${nghttp2_folder}/src/h2load" --npn-list h3 https://127.0.0.1:7777/1000000