# 🚀 NELL Ultimate 100 Linux OS - Dev Environment Installer

[![Termux](https://img.shields.io/badge/Termux-Supported-brightgreen?logo=android)](https://termux.dev)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/PRoot--Distro-Linux%20Environments-orange?logo=linux)](https://github.com/termux/proot-distro)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)

**NELL (`nell.sh`)** adalah skrip otomatisasi (*installer script*) tingkat lanjut berbasis **Termux** & **PRoot-Distro** yang didesain untuk menyiapkan lingkungan pengembangan (*development environment*) Linux yang tangguh, lengkap, dan siap pakai langsung dari perangkat Android Anda.

Skrip ini menyediakan antarmuka interaktif untuk memilih **100 distribusi Linux**, lalu secara otomatis mengonfigurasi toolchain penting seperti **Node.js (NVM)**, **Python 3**, **Rust & Cargo**, serta kustomisasi shell modern **Zsh (Oh My Zsh)**.

---

## 📋 Daftar Isi

- [✨ Fitur Utama](#-fitur-utama)
- [⚙️ Persyaratan Sistem](#️-persyaratan-sistem)
- [📥 Cara Penggunaan & Instalasi](#-cara-penggunaan--instalasi)
- [🐧 Daftar Kategori OS (100 Distribusi)](#-daftar-kategori-os-100-distribusi)
- [🧱 Arsitektur & Cara Kerja Skrip](#-arsitektur--cara-kerja-skrip)
  - [1. Inisialisasi & Dependency Check](#1-inisialisasi--dependency-check)
  - [2. Menu Interaktif & Fallback Routing](#2-menu-interaktif--fallback-routing)
  - [3. Pre-flight Check Container](#3-pre-flight-check-container)
  - [4. Dynamic Inner Script](#4-dynamic-inner-script)
  - [5. Verifikasi Instalasi](#5-verifikasi-instalasi)
- [📊 Kompatibilitas Package Manager](#-kompatibilitas-package-manager)
- [🔧 Troubleshooting & Penanganan Masalah](#-troubleshooting--penanganan-masalah)
- [📄 Lisensi](#-lisensi)

---

## ✨ Fitur Utama

- **🗺️ Menu Interaktif 100 OS:** Menyediakan visualisasi menu rapi dengan klasifikasi kategori distro Linux lengkap.
- **🛡️ Mekanisme Safe Fallback:** Mengantisipasi kegagalan instalasi distro tak didukung (*unsupported alias*) dengan memindahkan secara aman ke base **Ubuntu/Debian**.
- **📦 Multi-Package Manager Support:** Deteksi otomatis dan dukungan penuh terhadap `apt`, `pacman`, `dnf`, `apk`, dan `zypper`.
- **💻 Full Stack Toolchain Setup:**
  - **Node.js & npm:** Terisolasi dan dikelola menggunakan **NVM (Node Version Manager)**.
  - **Python 3 & pip:** Penanganan adaptif terhadap batasan **PEP 668** (*externally managed environments*).
  - **Rust Compiler & Cargo:** Instalasi otomatis toolchain `stable` melalui `rustup`.
- **🎨 Modern Shell Environment:** Konfigurasi otomatis **Zsh** dengan framework **Oh My Zsh** serta plugin produktivitas:
  - `zsh-autosuggestions` (saran auto-complete cerdas)
  - `zsh-syntax-highlighting` (pewarnaan sintaks CLI)
- **🔍 Auto-Verification Report:** Laporan akhir otomatis yang memeriksa status instalasi dan versi setiap biner yang terpasang.

---

## ⚙️ Persyaratan Sistem

- **Aplikasi:** Termux (versi terbaru dari [F-Droid](https://f-droid.org/packages/com.termux/) sangat direkomendasikan).
- **Arsitektur CPU:** `aarch64` (ARM64) atau `armv7l` (ARM32), `x86_64`.
- **Penyimpanan Bebas:** Minimal **2 GB - 5 GB** (tergantung distro Linux yang dipilih).
- **Koneksi Internet:** Stabil untuk mengunduh rootfs distro dan *package updates*.

---

## 📥 Cara Penggunaan & Instalasi

### 1. Kloning Repositori & Persiapan
Buka Termux, jalankan pembaruan paket dasar, kloning repositori ini, lalu masuk ke direktorinya:

```bash
# Update package Termux dan install git
pkg update -y && pkg install git -y

# Kloning repositori
git clone [https://github.com/nellseen/tools.git](https://github.com/nellseen/tools.git)

# Masuk ke direktori proyek
cd tools

# Jalankan Skrip
chmod +x nell.sh
./nell.sh

Atau
bash nell.sh
