FROM python:3.12-slim

WORKDIR /app

# 安装依赖
RUN pip install --no-cache-dish mcp-server fastapi uvicorn

# 下载 Yichen-dust 的源码
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/Yichen-dust/Ombre-Brain.git /tmp/ombre && \
    cp /tmp/ombre/*.py /app/ && \
    cp /tmp/ombre/requirements.txt /app/ && \
    cp /tmp/ombre/dashboard.html /app/ && \
    cp /tmp/ombre/config.example.yaml /app/config.yaml && \
    echo "" >> /app/config.yaml && \
    echo "mcp_require_auth: false" >> /app/config.yaml && \
    rm -rf /tmp/ombre && \
    apt-get remove -y git && apt-get autoremove -y

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

VOLUME ["/app/buckets"]

ENV OMBRE_TRANSPORT=streamable-http
ENV OMBRE_BUCKETS_DIR=/app/buckets

EXPOSE 8000

CMD ["python", "server.py"]
