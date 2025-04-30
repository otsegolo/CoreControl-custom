# Builder Stage
FROM --platform=$BUILDPLATFORM node:20-alpine AS builder

ARG TARGETARCH  # Wird automatisch von Buildx gesetzt

WORKDIR /app

RUN case ${TARGETARCH} in \
    "amd64") export PRISMA_CLI_BINARY_TARGETS="linux-musl-x64-openssl-3.0.x" ;; \
    "arm64") export PRISMA_CLI_BINARY_TARGETS="linux-musl-arm64-openssl-3.0.x" ;; \
    "arm")   export PRISMA_CLI_BINARY_TARGETS="linux-musl-arm-openssl-3.0.x" ;; \
    *) echo "Unsupported ARCH: ${TARGETARCH}" && exit 1 ;; \
    esac

COPY package.json package-lock.json* ./
COPY ./prisma ./prisma

RUN npm install
RUN npx prisma generate

COPY . .
RUN npm run build

# Production Stage
FROM --platform=$TARGETPLATFORM node:20-alpine AS production

WORKDIR /app

ENV NODE_ENV production
ENV PRISMA_CLI_BINARY_TARGETS="linux-musl-arm64-openssl-3.0.x"

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.js* ./

RUN npm prune --production

EXPOSE 3000
CMD ["sh", "-c", "npx prisma migrate deploy && npm start"]


# - - BUILD COMMAND - - 
    # docker buildx build \
    # --platform linux/amd64,linux/arm64,linux/arm/v7 \
    # -t haedlessdev/corecontrol:1.0.0 \
    # -t haedlessdev/corecontrol:latest \
    # --push \
    # .