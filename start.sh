#!/bin/bash

CONFIG_FILE="/data/config.json"
REMOTE_CONFIG_URL="https://yourdomain.com/alist-config.json"

echo "===== AList Container Startup ====="

# 如果 config.json 不存在，则从远程恢复
if [ ! -f "$CONFIG_FILE" ]; then
    echo "[INFO] config.json 不存在，尝试从远程恢复..."
    mkdir -p /data
    curl -sSL "$REMOTE_CONFIG_URL" -o "$CONFIG_FILE"

    if [ -f "$CONFIG_FILE" ]; then
        echo "[INFO] config.json 恢复成功"
    else
        echo "[WARN] 恢复失败，使用默认空配置"
    fi
else
    echo "[INFO] 检测到已存在 config.json，跳过恢复"
fi

# 启动 AList
echo "[INFO] 启动 AList，数据目录：/data"
./alist server --data /data
