FROM node:18-bullseye-slim

# Instala dependências para nodes avançados (como Puppeteer, Playwright, etc.)
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  build-essential \
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
  wget \
  curl \
  unzip \
  && apt-get clean

# Instala o n8n globalmente
RUN npm install -g n8n

# === ATIVA OS NODES DA COMUNIDADE ===
# Cria pasta esperada pelo n8n
RUN mkdir -p /data/community-nodes/n8n-nodes-spreadsheet-file

# Instala o pacote na pasta correta
RUN cd /data/community-nodes/n8n-nodes-spreadsheet-file && \
    npm init -y && \
    npm install n8n-nodes-spreadsheet-file

# Define variáveis de ambiente para ativar nodes da comunidade
ENV N8N_FEATURES_ENABLED=communityNodes
ENV N8N_COMMUNITY_PACKAGES=n8n-nodes-spreadsheet-file

# Expõe a porta padrão do n8n
EXPOSE 5678

# Usa usuário node (já presente na imagem)
USER node

# Comando de execução
CMD ["n8n"]
