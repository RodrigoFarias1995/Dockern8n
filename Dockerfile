
FROM node:18-bullseye-slim

# Instala dependências para nodes avançados
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

# Instala o n8n
RUN npm install -g n8n

# Volume persistente
#VOLUME ["/home/node/.n8n"]

EXPOSE 5678

USER node

CMD ["n8n"]
