FROM node:18-bullseye-slim

# Instala dependências de sistema
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  build-essential \
  git \
  wget \
  curl \
  unzip \
  libxss1 \
  libappindicator1 \
  libnss3 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  fonts-liberation \
  libasound2 \
  libcups2 \
  libdbus-1-3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  libgbm-dev \
  && apt-get clean

# Instala o n8n globalmente
RUN npm install -g n8n

# Ativa os nodes da comunidade
ENV N8N_FEATURES_ENABLED=communityNodes
ENV N8N_COMMUNITY_PACKAGES=n8n-nodes-spreadsheet-file

# Cria o diretório e instala o pacote da comunidade
RUN mkdir -p /data/community-nodes/n8n-nodes-spreadsheet-file && \
    cd /data/community-nodes/n8n-nodes-spreadsheet-file && \
    npm init -y && \
    npm install --legacy-peer-deps n8n-nodes-spreadsheet-file

# Define a porta padrão
EXPOSE 5678

# Usa o usuário padrão não-root
USER node

CMD ["n8n"]
