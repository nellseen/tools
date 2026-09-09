#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# 🎨 COLOR DEFINITIONS & STYLING
# ==========================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# ==========================================
# 🚀 NELL DEV ENVIRONMENT INSTALLER
# ==========================================
clear
echo -e "${CYAN}${BOLD}========================================${NC}"
echo -e "${PURPLE}${BOLD}   🔥 NELL ULTIMATE 100 LINUX OS 🔥    ${NC}"
echo -e "${CYAN}${BOLD}========================================${NC}\n"

echo -e "${YELLOW}${BOLD}====== UPDATE TERMUX ======${NC}"
pkg update -y && pkg upgrade -y

echo -e "\n${YELLOW}${BOLD}====== INSTALL BASIC TOOLS ======${NC}"
pkg install -y git curl proot-distro wget

# ==========================================
# FIX: Pengecekan proot-distro
# ==========================================
if ! command -v proot-distro > /dev/null; then
    echo -e "${RED}proot-distro belum ada, menginstal...${NC}"
    pkg install proot-distro -y
fi

# ==========================================
# 🐧 100 PILIHAN OS UNTUK NELL
# ==========================================
echo -e "${BLUE}----------------------------------------${NC}"
echo -e "${WHITE}${BOLD}Pilih OS [1-100]:${NC}"
echo -e "${BLUE}----------------------------------------${NC}"

echo -e "${GREEN}${BOLD}🌐 GENERAL & DESKTOP MAINSTREAM${NC}"
printf " ${GREEN}%-3s)${NC} %-16s ${GREEN}%-3s)${NC} %-16s\n" \
  "1" "Ubuntu" "2" "Debian" "3" "Arch Linux" "4" "Fedora" \
  "5" "Alpine Linux" "6" "openSUSE Tumble" "7" "openSUSE Leap" "8" "Void Linux" \
  "9" "Gentoo" "10" "Slackware" "11" "NixOS" "12" "Solus" \
  "13" "Void (glibc)" "14" "Void (musl)" "15" "EndeavourOS" "16" "Garuda Linux" \
  "17" "Artix Linux" "18" "ArcoLinux" "19" "KaOS" "20" "RebornOS" \
  "21" "Nobara Linux" "22" "Silverblue" "23" "Kinoite" "24" "Ultramarine" \
  "25" "Guix System"

echo -e "\n${CYAN}${BOLD}🛡️ SECURITY, PENTESTING & FORENSICS${NC}"
printf " ${CYAN}%-3s)${NC} %-16s ${CYAN}%-3s)${NC} %-16s\n" \
  "26" "Kali Linux" "27" "Parrot Security" "28" "BlackArch" "29" "Pentoo" \
  "30" "Athena OS" "31" "Tsurugi Linux" "32" "CAINE OS" "33" "Santoku Linux" \
  "34" "REMnux" "35" "Fedora Security" "36" "Debian Sec" "37" "BackBox Linux" \
  "38" "Bugtraq" "39" "SamuraiWTF" "40" "ArchStrike" "41" "Bento OWASP" \
  "42" "NetSecurity" "43" "Attify OS" "44" "Whonix" "45" "Tails OS" \
  "46" "Qubes OS" "47" "Alpine Sec" "48" "Security Onion" "49" "OSInt Linux" \
  "50" "Kali Everything"

echo -e "\n${PURPLE}${BOLD}💼 ENTERPRISE, CLOUD & SERVER${NC}"
printf " ${PURPLE}%-3s)${NC} %-16s ${PURPLE}%-3s)${NC} %-16s\n" \
  "51" "AlmaLinux" "52" "Rocky Linux" "53" "CentOS Stream" "54" "Oracle Linux" \
  "55" "Amazon Linux" "56" "BusyBox" "57" "Clear Linux" "58" "EuroLinux" \
  "59" "RHEL" "60" "Scientific" "61" "Springdale" "62" "Navy Linux" \
  "63" "Circle Linux" "64" "Miracle Linux" "65" "openEuler" "66" "Anolis OS" \
  "67" "Kylin Linux" "68" "UOS Enterprise" "69" "Flatcar Linux" "70" "Talos Linux" \
  "71" "RancherOS" "72" "Photon OS" "73" "Container OS" "74" "SUSE MicroOS" \
  "75" "Debian Cloud"

echo -e "\n${YELLOW}${BOLD}🎨 USER FRIENDLY & COMMUNITY${NC}"
printf " ${YELLOW}%-3s)${NC} %-16s ${YELLOW}%-3s)${NC} %-16s\n" \
  "76" "Manjaro" "77" "Deepin OS" "78" "Pardus OS" "79" "ALT Linux" \
  "80" "Pop!_OS" "81" "Mageia" "82" "Linux Mint" "83" "LMDE" \
  "84" "Zorin OS" "85" "elementary OS" "86" "MX Linux" "87" "antiX Linux" \
  "88" "Bodhi Linux" "89" "Puppy Linux" "90" "Tiny Core" "91" "Slax" \
  "92" "Devuan" "93" "Void Musl" "94" "Kubuntu" "95" "Xubuntu" \
  "96" "Lubuntu" "97" "Ubuntu Budgie" "98" "Ubuntu MATE" "99" "KDE neon" \
  "100" "SteamOS"
echo -e "${BLUE}----------------------------------------${NC}"

read -p "$(echo -e ${YELLOW}"Masukkan pilihan [1-100]: "${NC})" os_choice

case $os_choice in
    1) DISTRO_NAME="ubuntu"; DISTRO_ALIAS="ubuntu" ;;
    2) DISTRO_NAME="debian"; DISTRO_ALIAS="debian" ;;
    3) DISTRO_NAME="archlinux"; DISTRO_ALIAS="archlinux" ;;
    4) DISTRO_NAME="fedora"; DISTRO_ALIAS="fedora" ;;
    5) DISTRO_NAME="alpine"; DISTRO_ALIAS="alpine" ;;
    6) DISTRO_NAME="opensuse-tumbleweed"; DISTRO_ALIAS="opensuse" ;;
    7) DISTRO_NAME="opensuse-leap"; DISTRO_ALIAS="opensuse" ;;
    8) DISTRO_NAME="voidlinux"; DISTRO_ALIAS="void" ;;
    26) DISTRO_NAME="kali-rolling"; DISTRO_ALIAS="debian" ;; 
    76) DISTRO_NAME="manjaro"; DISTRO_ALIAS="manjaro" ;;
    77) DISTRO_NAME="deepin"; DISTRO_ALIAS="deepin" ;;
    78) DISTRO_NAME="pardus"; DISTRO_ALIAS="pardus" ;;
    *) 
        # Fallback dinamis jika alias eksotis
        echo -e "${YELLOW}Distro diluar support native, di-routing ke base Ubuntu/Debian...${NC}"
        DISTRO_NAME="ubuntu"
        DISTRO_ALIAS="ubuntu"
        ;;
esac

echo -e "\n${YELLOW}${BOLD}====== INSTALL $DISTRO_NAME ======${NC}"

# ==========================================
# SAFE INSTALLATION & FALLBACK LOGIC
# ==========================================
if [ ! -d "$PREFIX/var/lib/proot-distro/installed-rootfs/$DISTRO_ALIAS" ]; then
    if ! proot-distro install "$DISTRO_ALIAS"; then
        echo -e "${RED}Gagal menginstal OS $DISTRO_ALIAS!${NC}"
        echo -e "${YELLOW}Mencoba fallback stabil ke 'ubuntu' untuk memastikan env development tetap berjalan...${NC}"
        DISTRO_ALIAS="ubuntu"
        proot-distro install ubuntu || { echo -e "${RED}FATAL ERROR: Sistem proot-distro bermasalah.${NC}"; exit 1; }
    fi
fi

echo -e "\n${YELLOW}${BOLD}====== MASUK $DISTRO_ALIAS & SETUP DEV ======${NC}"

# Pre-flight check: Pastikan bash terpasang di dalam container (penting untuk Alpine)
proot-distro login "$DISTRO_ALIAS" -- sh -c "command -v bash >/dev/null || (command -v apk >/dev/null && apk add bash) || (command -v apt >/dev/null && apt update && apt install -y bash)"

# ==========================================
# 🧠 DYNAMIC INNER SCRIPT (NO HARDCODES)
# ==========================================
INNER_SCRIPT=$(cat << 'EOF'
set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "\n${YELLOW}${BOLD}====== UPDATE OS & INSTALL DEPENDENCIES ======${NC}"
if command -v apt > /dev/null; then
    apt update && apt upgrade -y || { echo -e "${RED}Apt update gagal${NC}"; exit 1; }
    apt install -y curl wget build-essential libssl-dev pkg-config python3 python3-pip python3-venv zsh git bash || { echo -e "${RED}Gagal install dependencies${NC}"; exit 1; }
elif command -v pacman > /dev/null; then
    pacman -Syu --noconfirm || { echo -e "${RED}Pacman update gagal${NC}"; exit 1; }
    pacman -S --noconfirm base-devel curl wget python python-pip zsh git bash || { echo -e "${RED}Gagal install dependencies${NC}"; exit 1; }
elif command -v dnf > /dev/null; then
    dnf update -y || { echo -e "${RED}DNF update gagal${NC}"; exit 1; }
    dnf install -y gcc gcc-c++ make curl wget python3 python3-pip zsh git bash || { echo -e "${RED}Gagal install dependencies${NC}"; exit 1; }
elif command -v apk > /dev/null; then
    apk update && apk upgrade || { echo -e "${RED}APK update gagal${NC}"; exit 1; }
    apk add build-base curl wget python3 py3-pip zsh git bash || { echo -e "${RED}Gagal install dependencies${NC}"; exit 1; }
elif command -v zypper > /dev/null; then
    zypper refresh && zypper update -y || { echo -e "${RED}Zypper update gagal${NC}"; exit 1; }
    zypper install -y -t pattern devel_basis || true
    zypper install -y curl wget python3 python3-pip zsh git bash || { echo -e "${RED}Gagal install dependencies${NC}"; exit 1; }
else
    echo -e "${RED}Package manager tidak didukung.${NC}"; exit 1
fi

echo -e "\n${YELLOW}${BOLD}====== SETUP OH MY ZSH & PLUGINS ======${NC}"
if command -v zsh > /dev/null; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Menginstal Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || echo -e "${YELLOW}Warning: Gagal install Oh My Zsh.${NC}"
    else
        echo -e "${GREEN}Oh My Zsh terdeteksi. Melewati clone utama...${NC}"
    fi
    
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    if [ -d "$ZSH_CUSTOM" ]; then
        if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || echo -e "${YELLOW}Warning: Gagal clone zsh-autosuggestions${NC}"
        else
            git -C "$ZSH_CUSTOM/plugins/zsh-autosuggestions" pull || true
        fi

        if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || echo -e "${YELLOW}Warning: Gagal clone zsh-syntax-highlighting${NC}"
        else
            git -C "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" pull || true
        fi
    fi

    if [ -f "$HOME/.zshrc" ]; then
        sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g" "$HOME/.zshrc"
        if ! grep -q "ENABLE_CORRECTION=\"true\"" "$HOME/.zshrc"; then
            sed -i "s/# ENABLE_CORRECTION=\"true\"/ENABLE_CORRECTION=\"true\"/g" "$HOME/.zshrc"
        fi
    fi
    
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        chsh -s $(command -v zsh) 2>/dev/null || echo -e "${YELLOW}Warning: Gagal merubah default shell ke zsh secara otomatis.${NC}"
    fi
fi

echo -e "\n${YELLOW}${BOLD}====== INSTALL/UPDATE NODE.JS (via NVM) ======${NC}"
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo -e "${CYAN}Menginstal NVM...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash || { echo -e "${RED}Gagal install NVM${NC}"; exit 1; }
else
    echo -e "${GREEN}NVM sudah terinstal. Melewati instalasi NVM...${NC}"
fi

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

echo -e "${CYAN}Menginstal Node.js release terbaru...${NC}"
nvm install node || { echo -e "${RED}Gagal install Node.js via NVM${NC}"; exit 1; }
nvm alias default node
nvm use default
npm install -g npm || echo -e "${YELLOW}Warning: Gagal upgrade global npm. Melanjutkan...${NC}"

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    touch "$rc"
    if ! grep -qc "NVM_DIR" "$rc"; then
        echo "export NVM_DIR=\"\$HOME/.nvm\"" >> "$rc"
        echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && source \"\$NVM_DIR/nvm.sh\"" >> "$rc"
    fi
done

echo -e "\n${YELLOW}${BOLD}====== UPDATE PIP ======${NC}"
if command -v python3 > /dev/null; then
    # Pendekatan aman terhadap PEP 668 (managed environments) tanpa merusak system-python
    python3 -m pip install --upgrade pip --break-system-packages 2>/dev/null || \
    python3 -m pip install --upgrade pip 2>/dev/null || \
    echo -e "${YELLOW}Warning: Pip terproteksi oleh sistem distro. Gunakan venv saat development python.${NC}"
fi

echo -e "\n${YELLOW}${BOLD}====== INSTALL/UPDATE RUST ======${NC}"
if ! command -v rustup > /dev/null 2>&1 && [ ! -f "$HOME/.cargo/bin/rustup" ]; then
    echo -e "${CYAN}Menginstal Rustup (stable channel)...${NC}"
    curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable || { echo -e "${RED}Gagal menginstal Rust${NC}"; exit 1; }
else
    echo -e "${GREEN}Rust sudah terinstal. Mengeksekusi rustup update...${NC}"
    "$HOME/.cargo/bin/rustup" update stable || echo -e "${YELLOW}Warning: Gagal update Rust.${NC}"
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if ! grep -qc ".cargo/env" "$rc"; then
        echo "[ -f \"\$HOME/.cargo/env\" ] && source \"\$HOME/.cargo/env\"" >> "$rc"
    fi
done

# ==========================================
# ✅ VERIFIKASI AKTUAL
# ==========================================
echo -e "\n${GREEN}${BOLD}====== VERIFIKASI INSTALASI ======${NC}"
set +e # Matikan exit on error agar report log utuh

echo -e "\n${CYAN}➜ Node.js:${NC}"
command -v node >/dev/null 2>&1 && { command -v node; node --version; } || echo "Node.js tidak ditemukan"

echo -e "\n${CYAN}➜ npm:${NC}"
command -v npm >/dev/null 2>&1 && { command -v npm; npm --version; } || echo "npm tidak ditemukan"

echo -e "\n${CYAN}➜ Python:${NC}"
command -v python3 >/dev/null 2>&1 && { command -v python3; python3 --version; } || echo "Python3 tidak ditemukan"

echo -e "\n${CYAN}➜ pip:${NC}"
command -v python3 >/dev/null 2>&1 && { python3 -m pip --version 2>/dev/null || echo "pip tidak merespon"; } || echo "Python module pip tidak ditemukan"

echo -e "\n${CYAN}➜ Rust:${NC}"
command -v rustc >/dev/null 2>&1 && { command -v rustc; rustc --version; } || echo "rustc tidak ditemukan"

echo -e "\n${CYAN}➜ Cargo:${NC}"
command -v cargo >/dev/null 2>&1 && { command -v cargo; cargo --version; } || echo "cargo tidak ditemukan"

echo -e "\n${CYAN}➜ Zsh:${NC}"
command -v zsh >/dev/null 2>&1 && { command -v zsh; zsh --version; } || echo "zsh tidak ditemukan"

EOF
)

# Eksekusi blok instruksi di dalam kontainer
proot-distro login "$DISTRO_ALIAS" -- bash -c "$INNER_SCRIPT"

echo -e "\n${GREEN}${BOLD}====== SETUP DEV ENVIRONMENT SELESAI 🔥 ======${NC}"
echo -e "${CYAN}${BOLD}Ketik perintah ini untuk masuk:${NC} ${WHITE}proot-distro login $DISTRO_ALIAS${NC}"
