# start.sh — Fullstack Mobile Project Generator

`start.sh` adalah **script generator utama** untuk membuat **project fullstack mobile** yang terdiri dari:

- **Frontend**: Flutter (mobile – Android)
- **Backend**: FastAPI (Python)
- **Runtime backend**: Docker & Docker Compose

Dengan **satu perintah**, script ini akan **membuat struktur project dari nol** dan **menjalankan backend secara otomatis**.

---

## 🎯 Tujuan Dibuatnya `start.sh`

File `start.sh` dibuat untuk:

- Mempercepat pembuatan project Flutter + FastAPI
- Menghindari setup manual yang berulang
- Menyeragamkan arsitektur project
- Menyediakan fondasi yang **scalable & clean**

Script ini **bukan hanya untuk menjalankan**, tetapi **untuk membuat project baru**.

---

## 🚀 Cara Menggunakan

Jalankan dari direktori tempat `start.sh` berada:

```bash
./start.sh <nama_project>
```

Contoh:
```bash
./start.sh my_project
```

---

## 📌 Apa yang Dilakukan `start.sh`

Ketika dijalankan, `start.sh` akan:

1. Membuat folder project baru:
   ```
   ~/project/mobile/my_project
   ```

2. Membuat **backend FastAPI**:
   - Struktur modular
   - Endpoint `/health`
   - `Dockerfile`
   - `docker-compose.yml`

3. Membuat **frontend Flutter**:
   - Menjalankan `flutter create`
   - Menambahkan file konfigurasi API (`api_config.dart`)

4. Menjalankan backend:
   ```bash
   docker compose up -d --build
   ```

---

## 📂 Struktur Project yang Dihasilkan

```
my_project/
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   └── api/routes.py
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── requirements.txt
├── frontend/
│   ├── lib/
│   │   └── api_config.dart
│   └── pubspec.yaml
└── start.sh
```

---

## ⚙️ Prasyarat

Pastikan sudah ter-install di **host machine**:

- Docker
- Docker Compose
- Flutter SDK
- Android SDK

Cek:
```bash
docker --version
flutter --version
```

---

## 🔌 Komunikasi Frontend ↔ Backend

Backend FastAPI berjalan di Docker dan expose port `8000`.

Konfigurasi Flutter ada di:
```
frontend/lib/api_config.dart
```

### Android Emulator
```
http://10.0.2.2:8000
```

### Device Fisik
```
http://IP_LAPTOP_ANDA:8000
```

⚠️ Jangan gunakan `localhost` di HP.

---

## ❌ Yang Tidak Dilakukan `start.sh`

- Tidak menjalankan Flutter di Docker
- Tidak menggabungkan frontend & backend dalam satu container
- Tidak melakukan deployment production

Semua ini **disengaja** untuk mengikuti best practice.

---

## ✅ Prinsip Arsitektur

- Separation of concerns
- One container = one responsibility
- Flutter berjalan native di Android
- Backend berjalan terisolasi di Docker
- Komunikasi via HTTP

---

## 📝 Ringkasan

| Item | Keterangan |
|----|-----------|
| File | `start.sh` |
| Fungsi | Project generator + backend runner |
| Frontend | Flutter (mobile) |
| Backend | FastAPI (Docker) |
| Target | Development |

---

File ini disiapkan untuk digunakan langsung sebagai **README.md**.
# flutter-fastapi-docker-starter
