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

**Silahkan kunjungi [shscar/Inventory-Barang](https://github.com/shscar/Inventory-Barang) untuk petunjuk konfigurasi dari repositori ini**

## Menjalankan Project

```bash
docker compose up -d
```

### Setting AlertManager ke notifikasi Telegram

Pada file ```/config-monitoring/alertmanager/alertmanager.yml``` masukkan ```bot_token``` dan ```chat_id``` pada telegram.
Anda bisa gunakan [BotFather](https://telegram.me/BotFather) untuk membuat Telegram bot dan [User Info • Get ID • IDbot](https://telegram.me/userinfobot) untuk mengetahui ```chat_id``` Telegram anda.
