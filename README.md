# Travel Planner UTS - Mobile Application

Aplikasi **Travel Planner** adalah sebuah platform pintar untuk membantu pengguna merencanakan perjalanan wisata domestik di Indonesia. Proyek ini dibangun sebagai bentuk pemenuhan tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile. Aplikasi ini mengintegrasikan fungsionalitas REST API publik, *cloud database* (Supabase), arsitektur profesional, dan desain UI/UX yang modern.

## Identitas Pengembang

* **Nama:** I Made Duta Aryawan
* **NIM:** 2415051044
* **Kelas:** PTI-5-IKI

## Fitur Utama (Features)

1. **Modern UI \& Responsive Layout:** Tampilan aplikasi yang estetis, mendukung animasi *Hero*, *Shimmer Loading*, serta otomatis beradaptasi (`LayoutBuilder`) dari mode *compact* (HP) menjadi mode *wide* (Tablet/Landscape) dengan membelah susunan *grid*.
2. **Real-time Search \& Filter:** Pengguna dapat mencari nama destinasi/provinsi secara instan tanpa perlu memuat ulang layar.
3. **Database CRUD (Destinasi Favorit):** Pengguna dapat menyimpan (Create), menampilkan (Read), menghapus (Delete), dan menambahkan catatan pribadi (Update) pada destinasi impian mereka.
4. **Smart Packing List:** Utilitas *checklist* bawaan (State Management lokal) untuk mencatat dan mencentang barang persiapan liburan.
5. **Smart Actions:** Integrasi langsung dengan Google Maps (Navigasi Rute) dan fitur berbagi (Share) ke media sosial/pesan instan.
6. **Real-time User Profile:** Halaman profil dinamis yang terintegrasi dengan form validasi (`Form Validation`).

## Tech Stack

* **Framework:** Flutter \& Dart
* **State Management:** Provider (`ChangeNotifier`)
* **Cloud Backend:** Supabase (PostgreSQL)
* **Networking:** `http` package
* **Utilities:** `shimmer` (Loading UI), `url\_launcher` (Maps), `share\_plus` (Social Share), `flutter\_native\_splash` \& `flutter\_launcher\_icons` (App Branding).

## REST API yang Digunakan

* **Emsifa API Wilayah Indonesia:** `https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json` (Method: GET). Digunakan untuk menarik data daftar provinsi di Indonesia.
* **Picsum Photos (Dummy Image):** `https://picsum.photos` (Digunakan untuk meng- *generate* gambar pemandangan dinamis berdasarkan ID wilayah).

## Backend / Database

Aplikasi ini menggunakan **Supabase** sebagai *database cloud* utama.

* **Tabel:** `favorites`
* **Skema Field:**

  * `id` (bigint, primary key, auto-increment)
  * `destination\_id` (text, not null)
  * `name` (text, not null)
  * `location` (text, not null)
  * `image\_url` (text, not null)
  * `personal\_note` (text, default: 'Belum ada catatan')

## Struktur Arsitektur (Separation of Concerns)

Proyek ini mematuhi standar industri dengan pemisahan logika (UI, logika bisnis, dan data):

```text
lib/
 ├── models/         # Cetak biru struktur data (Destination, PackingItem)
 ├── providers/      # State Management (TravelProvider)
 ├── repositories/   # Lapisan penghubung data (Opsional/Terintegrasi di service)
 ├── services/       # Pemrosesan API (api\_service.dart) \& Supabase (supabase\_service.dart)
 ├── screens/        # Halaman UI Utama (Home, Detail, Favorites, Packing, Profile)
 ├── widgets/        # Komponen UI yang dapat digunakan ulang (TravelCard, dll)
 └── main.dart       # Titik masuk utama \& inisialisasi aplikasi
```

