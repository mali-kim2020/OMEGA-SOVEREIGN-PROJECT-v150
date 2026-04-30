#!/bin/bash

# ======================================================================
# PROJECT OMEGA SOVEREIGN v1.50 - FULL INFRASTRUCTURE INSTALLER 
# ======================================================================

BLUE='\033[94m'
GREEN='\033[92m'
RED='\033[91m'
RESET='\033[0m'

echo -e "${BLUE}[*] Starte PROJECT OMEGA SOVEREIGN Full-Installation mit Ghost-Routing...${RESET}"

# FIX: 'netcat-openbsd' hinzugefügt, um den Tor-Port professionell zu überwachen
echo -e "${BLUE}[1/6] Installiere System-Tools, Nikto, Tor & Proxychains...${RESET}"
sudo apt update -y

sudo apt install -y python3 python3-pip python3-requests python3-urllib3 \
                     git unzip curl wget sqlite3 nikto build-essential tor procps netcat-openbsd

sudo apt install -y proxychains4 || sudo apt install -y proxychains

sudo sed -i 's/socks4 \+127.0.0.1 \+9050/socks5 127.0.0.1 9050/g' /etc/proxychains4.conf 2>/dev/null
sudo sed -i 's/socks4 \+127.0.0.1 \+9050/socks5 127.0.0.1 9050/g' /etc/proxychains.conf 2>/dev/null

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

echo -e "${BLUE}[3/6] Installiere ExploitDB & Searchsploit...${RESET}"
if [ ! -d "$HOME/exploitdb" ]; then
    git clone --depth 1 https://github.com/offensive-security/exploitdb.git $HOME/exploitdb
    sudo ln -sf $HOME/exploitdb/searchsploit /usr/local/bin/searchsploit
else
    echo -e "${GREEN}[+] ExploitDB bereits vorhanden.${RESET}"
    cd $HOME/exploitdb && git pull && cd -
fi

echo -e "${BLUE}[4/6] Verifiziere Python-Module (PIP Fallback)...${RESET}"
python3 -m pip install requests urllib3 --break-system-packages 2>/dev/null

echo -e "${BLUE}[5/6] Entpacke und bereinige Agent-Dateien...${RESET}"
ZIP_FILE=$(ls autonomous_agent_v150.zip 2>/dev/null | head -n 1)

if [ -f "$ZIP_FILE" ]; then
    unzip -o "$ZIP_FILE"
    sed -i 's/\xe2\x80\x8b//g' autonomous_agent.py 2>/dev/null
    echo -e "${GREEN}[+] Agent-Code wurde gereinigt.${RESET}"
else
    echo -e "${RED}[!] autonomous_agent_v150.zip fehlt!${RESET}"
fi

echo -e "${BLUE}[6/6] Finalisiere GHOST-Launcher...${RESET}"
cat << 'EOF' > pentest
#!/bin/bash
echo -e "\033[94m[*] Initialisiere Ghost-Routing (Tor-Netzwerk)...\033[0m"

# FIX: Intelligente Schleife. Startet Tor und wartet exakt, bis Port 9050 OFFEN ist.
if ! nc -z 127.0.0.1 9050 2>/dev/null; then
    echo -e "\033[90m[*] Starte Tor-Daemon im Hintergrund...\033[0m"
    tor > /dev/null 2>&1 &
    
    echo -n -e "\033[90m[*] Warte auf Tor-Tunnel (Ping Port 9050)"
    for i in {1..30}; do
        if nc -z 127.0.0.1 9050 2>/dev/null; then
            echo -e "\n\033[92m[+] Tor-Tunnel erfolgreich etabliert! Dein Standort ist verborgen.\033[0m"
            break
        fi
        echo -n "."
        sleep 1
    done
    
    if ! nc -z 127.0.0.1 9050 2>/dev/null; then
        echo -e "\n\033[91m[!] FEHLER: Tor konnte nicht starten. Port 9050 blockiert. Abbruch!\033[0m"
        exit 1
    fi
else
    echo -e "\033[92m[+] Tor-Tunnel läuft bereits!\033[0m"
fi

export TOR_ROUTING=1

if command -v proxychains4 &> /dev/null; then
    proxychains4 -q python3 autonomous_agent.py
elif command -v proxychains &> /dev/null; then
    proxychains -q python3 autonomous_agent.py
else
    echo -e "\033[91m[!] FEHLER: Proxychains nicht gefunden.\033[0m"
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
