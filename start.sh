#!/bin/bash
set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./start.sh <project_name>"
  exit 1
fi

ROOT="$HOME/project/mobile/$PROJECT_NAME"
BACKEND="$ROOT/backend"
FRONTEND="$ROOT/frontend"

echo "========================================="
echo " Creating Fullstack Mobile Project"
echo " Project : $PROJECT_NAME"
echo " Root    : $ROOT"
echo "========================================="

# =========================
# CREATE DIRECTORIES
# =========================
mkdir -p "$BACKEND/app/api"
mkdir -p "$FRONTEND"

# =========================
# BACKEND (FASTAPI)
# =========================
echo "[1/3] Generating FastAPI backend..."

cat > "$BACKEND/app/main.py" <<EOF
from fastapi import FastAPI
from app.api.routes import router

app = FastAPI(title="$PROJECT_NAME API")
app.include_router(router)
EOF

cat > "$BACKEND/app/api/routes.py" <<EOF
from fastapi import APIRouter

router = APIRouter()

@router.get("/health")
def health():
    return {"status": "ok"}
EOF

cat > "$BACKEND/requirements.txt" <<EOF
fastapi
uvicorn[standard]
EOF

cat > "$BACKEND/Dockerfile" <<EOF
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

cat > "$BACKEND/docker-compose.yml" <<EOF
services:
  api:
    build: .
    ports:
      - "8000:8000"
EOF

# =========================
# FRONTEND (FLUTTER)
# =========================
echo "[2/3] Creating Flutter project..."

cd "$ROOT"
flutter create frontend

cat > "$FRONTEND/lib/api_config.dart" <<EOF
class ApiConfig {
  static const String baseUrl =
      "http://10.0.2.2:8000"; // emulator
}
EOF

# =========================
# START BACKEND
# =========================
echo "[3/3] Starting backend container..."

cd "$BACKEND"
docker compose up -d --build

echo "========================================="
echo " PROJECT READY"
echo " Backend : http://localhost:8000/health"
echo " Flutter : cd $FRONTEND && flutter run"
echo "========================================="
