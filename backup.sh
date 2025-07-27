#!/bin/bash

CONFIG_FILE="/data/config.json"
UPLOAD_URL="https://yourdomain.com/upload?filename=alist-config.json"

while true; do
    if [ -f "$CONFIG_FILE" ]; then
        curl -X POST -F "file=@$CONFIG_FILE" "$UPLOAD_URL"
        echo "[INFO] 自动备份 config.json"
    fi
    sleep 1800
done
