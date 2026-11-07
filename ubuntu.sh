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
# 🐧 UBUNTU ONLY
# ==========================================
DISTRO_NAME="ubuntu"
DISTRO_ALIAS="ubuntu"

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
    apt install nala -y || { echo -e "${RED}Gagal install Nala${NC}"; exit 1; }
    nala install gh -y || { echo -e "${RED}Gagal install GitHub CLI${NC}"; exit 1; }
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
npm install -g @openai/codex || { echo -e "${RED}Gagal install OpenAI Codex CLI${NC}"; exit 1; }

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


echo -e "\n${CYAN}➜ Zsh:${NC}"
command -v zsh >/dev/null 2>&1 && { command -v zsh; zsh --version; } || echo "zsh tidak ditemukan"

EOF
)

# Eksekusi blok instruksi di dalam kontainer
proot-distro login "$DISTRO_ALIAS" -- bash -c "$INNER_SCRIPT"

echo -e "\n${GREEN}${BOLD}====== SETUP DEV ENVIRONMENT SELESAI 🔥 ======${NC}"
echo -e "${CYAN}${BOLD}Ketik perintah ini untuk masuk:${NC} ${WHITE}proot-distro login $DISTRO_ALIAS${NC}"

