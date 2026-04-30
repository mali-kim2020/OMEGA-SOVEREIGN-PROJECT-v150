#!/bin/bash

# ======================================================================
# PROJECT OMEGA SOVEREIGN v1.50 - FULL INFRASTRUCTURE INSTALLER 
# ======================================================================

BLUE='\033[94m'
GREEN='\033[92m'
RED='\033[91m'
RESET='\033[0m'

echo -e "${BLUE}[*] Starte PROJECT OMEGA SOVEREIGN Full-Installation mit Ghost-Routing...${RESET}"

# 1. System-Basis, Nikto, Python & TOR GHOST-NETZWERK
echo -e "${BLUE}[1/6] Installiere System-Tools, Nikto, Tor & Proxychains...${RESET}"
sudo apt update -y

sudo apt install -y python3 python3-pip python3-requests python3-urllib3 \
                     git unzip curl wget sqlite3 nikto build-essential tor procps

# Installiere proxychains4, falls nicht vorhanden, als Fallback das alte proxychains
sudo apt install -y proxychains4 || sudo apt install -y proxychains

# Konfiguriere Proxychains für das Tor-Netzwerk (SOCKS5 auf Port 9050 erzwingen)
sudo sed -i 's/socks4 \+127.0.0.1 \+9050/socks5 127.0.0.1 9050/g' /etc/proxychains4.conf 2>/dev/null
sudo sed -i 's/socks4 \+127.0.0.1 \+9050/socks5 127.0.0.1 9050/g' /etc/proxychains.conf 2>/dev/null

# 2. Metasploit-Framework (UserLAnd Spezial-Weg via Rapid7)
echo -e "${BLUE}[2/6] Installiere Metasploit-Framework (Rapid7)...${RESET}"
if ! command -v msfconsole &> /dev/null; then
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    chmod 755 msfinstall
    sudo ./msfinstall
    rm msfinstall
    msfdb init --Xmx512M
else
    echo -e "${GREEN}[+] Metasploit bereits installiert.${RESET}"
fi

# 3. ExploitDB (Searchsploit)
echo -e "${BLUE}[3/6] Installiere ExploitDB & Searchsploit...${RESET}"
if [ ! -d "$HOME/exploitdb" ]; then
    git clone --depth 1 https://github.com/offensive-security/exploitdb.git $HOME/exploitdb
    sudo ln -sf $HOME/exploitdb/searchsploit /usr/local/bin/searchsploit
else
    echo -e "${GREEN}[+] ExploitDB bereits vorhanden.${RESET}"
    cd $HOME/exploitdb && git pull && cd -
fi

# 4. Python-Failsafe
echo -e "${BLUE}[4/6] Verifiziere Python-Module (PIP Fallback)...${RESET}"
python3 -m pip install requests urllib3 --break-system-packages 2>/dev/null

# 5. Agent-Entpackung & Syntax-Fix
echo -e "${BLUE}[5/6] Entpacke und bereinige Agent-Dateien...${RESET}"
ZIP_FILE=$(ls autonomous_agent_v150.zip 2>/dev/null | head -n 1)

if [ -f "$ZIP_FILE" ]; then
    unzip -o "$ZIP_FILE"
    sed -i 's/\xe2\x80\x8b//g' autonomous_agent.py 2>/dev/null
    echo -e "${GREEN}[+] Agent-Code wurde gereinigt.${RESET}"
else
    echo -e "${RED}[!] autonomous_agent_v150.zip fehlt!${RESET}"
fi

# 6. Der neue GHOST-Launcher (Routet alles durch Tor)
echo -e "${BLUE}[6/6] Finalisiere GHOST-Launcher...${RESET}"
cat << 'EOF' > pentest
#!/bin/bash
echo -e "\033[94m[*] Initialisiere Ghost-Routing (Tor-Netzwerk)...\033[0m"

if ! pgrep -x "tor" > /dev/null 2>&1; then
    tor > /dev/null 2>&1 &
    echo -e "\033[90m[*] Verbinde mit Tor-Knoten (bitte ca. 5 Sekunden warten)...\033[0m"
    sleep 5
fi

echo -e "\033[92m[+] Tor-Tunnel etabliert! Dein echter Standort ist nun verborgen.\033[0m"
export TOR_ROUTING=1

if command -v proxychains4 &> /dev/null; then
    proxychains4 -q python3 autonomous_agent.py
elif command -v proxychains &> /dev/null; then
    proxychains -q python3 autonomous_agent.py
else
    echo -e "\033[91m[!] FEHLER: Proxychains nicht gefunden.\033[0m"
    echo -e "\033[93mBitte führe './setup_sovereign.sh' noch einmal aus!\033[0m"
    exit 1
fi
EOF

chmod +x pentest
chmod +x *.py 2>/dev/null

echo -e "${GREEN}"
echo "===================================================="
echo "   FULL INSTALLATION ABGESCHLOSSEN (GHOST STATUS)   "
echo "===================================================="
echo " Ghost-Layer: Proxychains + Tor aktiviert           "
echo " Deine echte IP-Adresse wird bei jedem Scan maskiert."
echo "----------------------------------------------------"
echo " Starte das System mit: ./pentest                   "
echo "===================================================="
echo -e "${RESET}"
