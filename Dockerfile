FROM debian:latest

# 安装必要工具
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    tar \
    ca-certificates

# 创建目录
WORKDIR /app

# 下载最新版本的 AList（如需固定版本，可改 URL）
RUN wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz \
    && tar -zxvf alist-linux-amd64.tar.gz \
    && rm alist-linux-amd64.tar.gz

# 赋权
RUN chmod +x ./alist

# 添加启动脚本和可选配置（你可以后续 COPY aria2.conf 等）
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 将默认数据目录指向 Hugging Face 的持久目录（重要）
ENV ALIST_DATA=/data

# 持久化路径
VOLUME ["/data"]

EXPOSE 5244

CMD ["/app/start.sh"]
