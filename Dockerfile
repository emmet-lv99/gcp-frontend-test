FROM node:24-alpine
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080
ENV HOSTNAME="0.0.0.0"

# 1. 패키지 정의서 복사
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# 2. pnpm 및 의존성 설치
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# 3. 전체 소스 복사 및 Standalone 빌드
COPY . .
RUN pnpm build

# ★ [핵심 해결책] 정적 자원(Static Assets & Public)을 Standalone 실행 경로로 복사!
COPY --chown=node:node ./public ./.next/standalone/public
COPY --chown=node:node ./.next/static ./.next/standalone/.next/static

EXPOSE 8080

# Standalone 서버 가동
CMD ["node", ".next/standalone/server.js"]