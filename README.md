# 🍽️ Food Recipe App (Flutter)

Project ini adalah **aplikasi Food Recipe berbasis Flutter** sebagai frontend, yang terhubung ke backend API terpisah.

Dokumen ini berisi **panduan instalasi dari nol setelah clone repository** hingga aplikasi berhasil dijalankan.

---

## 📁 Struktur Project

```
FOOD_RECIPE/
├── food_recipe_api/     # Backend API (terpisah)
└── food_recipe_app/     # Flutter App (Frontend)
```

Panduan ini **fokus pada Flutter App** (`food_recipe_app`).

---

## ✅ Prasyarat

Pastikan sudah terinstall:

* Flutter SDK (stable)
* Git
* Android Studio / VS Code
* Android Emulator atau Google Chrome (untuk Web)

Cek Flutter:

```bash
flutter --version
flutter doctor
```

Pastikan tidak ada error ❌ penting.

---

## 1️⃣ Clone Repository

```bash
git clone https://github.com/USERNAME/FOOD_RECIPE.git
cd FOOD_RECIPE/food_recipe_app
```

---

## 2️⃣ Install Dependency Flutter

Karena beberapa folder **di-ignore oleh git**, dependency **WAJIB di-generate ulang**.

```bash
flutter pub get
```

Folder berikut akan otomatis dibuat:

```
.dart_tool/
build/
.flutter-plugins-dependencies
```

---

## 3️⃣ Konfigurasi Asset Images

Struktur asset:

```
assets/
└── images/
```

Pastikan di `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

📌 Semua upload / update / delete gambar **HARUS di folder ini**.

---

## 4️⃣ Konfigurasi API Endpoint

Edit file:

```
lib/services/api.dart
```

Contoh:

```dart
const String baseUrl = "http://10.0.2.2:8000"; // Android Emulator
// atau
const String baseUrl = "http://127.0.0.1:8000"; // Flutter Web / Desktop
```

Pastikan backend API sudah berjalan.

---

## 5️⃣ Menjalankan Aplikasi

### ▶️ Android Emulator

```bash
flutter run
```

### ▶️ Flutter Web

```bash
flutter run -d chrome
```

---

## 6️⃣ Jika Terjadi Error

Gunakan perintah berikut:

```bash
flutter clean
flutter pub get
flutter run
```

---

## 7️⃣ Catatan `.gitignore`

File & folder berikut **tidak ikut ke repository**:

* `.dart_tool/`
* `build/`
* `.idea/`
* `.vscode/` (opsional)

📌 Oleh karena itu, setiap clone project **WAJIB menjalankan `flutter pub get`**.

---

## 8️⃣ Checklist Cepat (Setelah Clone)

```bash
cd food_recipe_app
flutter pub get
flutter run
```

✅ Selesai

---

## 👨‍💻 Teknologi

* Flutter
* Dart
* REST API
* MySQL (Backend)

---

## 📌 Catatan Tambahan

* Struktur folder sudah mengikuti best practice Flutter
* Image tidak boleh di luar `assets/images`
* Backend dan frontend dipisah

---

## 🖥️ Setup Backend `food_recipe_api`

Backend pada project ini berada di folder:

```
food_recipe_api/
```

Backend ini menggunakan **PHP + MySQL** dan dijalankan menggunakan **XAMPP**.

---

### 1️⃣ Pindahkan Backend ke `htdocs`

1. Pastikan **XAMPP sudah terinstall**
2. Jalankan **Apache** dan **MySQL** dari XAMPP Control Panel
3. Salin folder backend:

```
food_recipe_api
```

ke dalam:

```
C:/xampp/htdocs/
```

Sehingga menjadi:

```
C:/xampp/htdocs/food_recipe_api
```

---

### 2️⃣ Import Database di phpMyAdmin

1. Buka browser dan akses:

```
http://localhost/phpmyadmin
```

2. Masuk ke menu **Import**
3. Pilih file SQL yang tersedia di backend:

```
food_recipe_api/MySQL.sql
```

4. Klik **Go / Import**

📌 File SQL ini akan otomatis:

* Membuat database
* Membuat tabel
* Mengisi struktur awal data

---

### 3️⃣ Konfigurasi Koneksi Database

Pastikan konfigurasi database di backend sudah sesuai dengan XAMPP:

Contoh konfigurasi:

```
Host     : localhost
User     : root
Password : (kosong)
Database : food_recipe
```

Jika perlu, edit file konfigurasi database di folder `food_recipe_api`.

---

### 4️⃣ Cek Backend API

Setelah semua selesai, coba akses backend melalui browser:

```
http://localhost/food_recipe_api
```

Jika halaman tampil tanpa error, maka backend sudah siap digunakan.

---

✨ Selamat ngoding & semoga lancar!
