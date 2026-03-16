# Inventory Barang - PHP Native

Aplikasi manajemen inventaris menggunakan **PHP Native** dengan sistem **routing manual** dan **Phinx** untuk mengatur **database migration**.

> **Catatan**: 
> Repositori ini adalah hasil *fork/clone* dari project utama [shscar/Inventory-Barang](https://github.com/shscar/Inventory-Barang). Fokus utama pada repositori ini adalah implementasi fitur **Observabilitas** (pengumpulan Metrik, Log, dan Alerting terpusat) secara langsung ke dalam aplikasi menggunakan ekosistem Prometheus, Grafana, dan Loki via Docker Compose.

## Fitur

- CRUD Barang
- CRUD Bahan Baku
- Routing dinamis tanpa query string
- Tampilan sederhana menggunakan TailwindCSS (CDN)
- Database migration menggunakan [Phinx](https://phinx.org/)
- **Observability Stack**: Terintegrasi penuh dengan Prometheus, Grafana, Loki, Alertmanager, dan cAdvisor.

---

## Observability (Monitoring & Logging)

Repository ini dilengkapi dengan stack *observability* dan *monitoring* yang dipasangkan menggunakan Docker Compose. Saat Anda menjalankan aplikasi, container observability tersebut akan langsung aktif:

### 📈 Monitoring Stack
- **Prometheus** (`http://localhost:9090`): Mengumpulkan dan menyimpan *metrics* secara *time-series*. Konfigurasi di folder `config-monitoring/prometheus`.
- **Grafana** (`http://localhost:3000`): Tool visualisasi data interaktif untuk membuat *dashboard* berdasarkan metrik Prometheus dan *logs* dari Loki.
- **cAdvisor** (`http://localhost:8082`): Monitoring analitik kinerja, *resource usage*, dan *network* spesifik untuk setiap *container docker*.
- **Alertmanager** (`http://localhost:9093`): Manajemen notifikasi dan *routes alerts* berdasarkan *rules* pada `alert-rule/alert_rules.yml`.

### 📝 Logging Stack
- **Loki** (`http://localhost:3100`): *Log aggregation system* yang ringan dan efisien.
- **Promtail**: Agen yang membaca dan mengirimkan *container log files* dsb ke endpoint Loki.
- Service `app` dan `db` dikonfigurasi secara langsung (*native*) menggunakan Docker [logging driver `loki`](https://grafana.com/docs/loki/latest/clients/docker-driver/) pada file `docker-compose.yml`.

---

## Persiapan Sebelum Menjalankan

### 1. Clone Repository

```bash
git clone https://github.com/shscar/Inventory-Barang
cd inventory-app
```

### 2. Install Dependency Composer

Pastikan [Composer](https://getcomposer.org/) sudah terinstall, lalu jalankan:

```bash
composer install
```

### 3. Setup Phinx Migration

#### a. Konfigurasi `phinx.php`

```bash
vendor/bin/phinx init .
```

Contoh konfigurasi:

```php
return [
    'paths' => [
        'migrations' => 'migrations',
        'seeds' => 'seeds',
    ],
    'environments' => [
        'default_migration_table' => 'phinxlog',
        'default_environment' => 'development',
        'development' => [
            'adapter' => 'mysql',
            'host' => 'localhost',
            'name' => 'nama_database',
            'user' => 'root',
            'pass' => '',
            'charset' => 'utf8mb4',
        ],
    ],
];
```

#### b. Jalankan Migration

```bash
vendor/bin/phinx migrate -e development
```

#### c. Jalankan Seed

```bash
vendor/bin/phinx seed:run -v
```

---

### 4. Konfigurasi Database

```bash
cp config/test.connection.php config/connection.php
```

Sesuaikan dengan database:

```php
return [
    'host'     => 'localhost',
    'name'     => 'nama_database',
    'user'     => 'root',
    'pass'     => '',
    'charset'  => 'utf8mb4',
];
```

### 5. Menjalankan Aplikasi

#### Dengan PHP built-in server

```bash
php -S localhost:800
```

Lalu akses di browser: [http://localhost:8000](http://localhost:8000)

---

## Struktur Folder

```
inventory-app/
├── action/
├── config/
│   └── connection.php
├── db/
│   ├── migrations/
│   └── Seeds/
├── layouts/
│   ├── barang.php
│   └── bahan_baku.php
├── composer.json
├── phinx.php      ← konfigurasi untuk Phinx
```

---

## Routing

Routing didefinisikan secara manual pada file:

```
config/route.php
```

---

## Styling

Menggunakan **TailwindCSS** CDN di dalam layout:

```html
<script src="https://cdn.tailwindcss.com"></script>
```

---

## Kontak

Jika memiliki pertanyaan, masukan, atau dukungan, silakan hubungi saya di [ahmadghozali87621@gmail.com](https://github.com/shscar/Terms-of-Reference-TOR.git)
