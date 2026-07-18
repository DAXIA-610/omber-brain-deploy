FROM p0luz/ombre-brain:latest

# 在 config.yaml 末尾追加一行，关闭 MCP OAuth 认证
RUN echo "" >> /app/config.yaml && echo "mcp_require_auth: false" >> /app/config.yaml
