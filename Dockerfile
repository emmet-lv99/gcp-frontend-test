FROM node:24-alpine
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080
ENV HOSTNAME="0.0.0.0"

# 1. 패키지 정의 및 pnpm workspace 설정 파일 복사
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# 2. Corepack 활성화 및 pnpm 순정 설치 (allowBuilds 승인 항목 적용)
RUN corepack enable && pnpm install --frozen-lockfile

# 3. 전체 소스 복사 및 Next.js Standalone 빌드
COPY . .
RUN pnpm build

EXPOSE 8080

# 4. 경량화된 Standalone 서버 가동 (pnpm CLI 의존성 없이 Pure Node.js 구동)
CMD ["node", ".next/standalone/server.js"]