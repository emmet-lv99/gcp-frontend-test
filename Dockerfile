FROM node:24-alpine
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080
ENV HOSTNAME="0.0.0.0"

# 1. 패키지 정의서 및 pnpm 워크스페이스 복사
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# 2. pnpm 설치 및 의존성 고정 설치
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# 3. 소스 코드 전체 복사 및 Standalone 빌드 실행
COPY . .
RUN pnpm build

# 4. [핵심 수정] 호스트 참조(COPY) 대신 컨테이너 내부 파일 복사(RUN cp -r)로 안정성 확보
RUN cp -r ./public ./.next/standalone/public
RUN cp -r ./.next/static ./.next/standalone/.next/static

EXPOSE 8080

# 5. Pure Node.js 기반 Standalone 서버 가동
CMD ["node", ".next/standalone/server.js"]