#!/bin/bash

# ======================================================================
# OMEGA SOVEREIGN v1.50 - ULTIMATIVE INSTALLATION (FIXED)
# ======================================================================

# Farben für bessere Lesbarkeit
BLUE='\033[94m'
GREEN='\033[92m'
RED='\033[91m'
RESET='\033[0m'

echo -e "${BLUE}[*] Starte Omega Sovereign Deep-Setup...${RESET}"

# 1. System-Check & Python-Basis
echo -e "${BLUE}[1/5] Aktualisiere System-Pakete...${RESET}"
sudo apt update -y
sudo apt install -y python3 python3-pip python3-setuptools git unzip curl wget sqlite3

# 2. Erzwungene Modul-Installation (Der Fix für 'requests' Fehler)
echo -e "${BLUE}[2/5] Installiere Python-Module (requests & urllib3)...${RESET}"
# Wir nutzen --break-system-packages, da UserLAnd/Debian das erfordert
python3 -m pip install --upgrade pip --break-system-packages
python3 -m pip install requests urllib3 --break-system-packages

# 3. Infrastruktur-Prüfung
echo -e "${BLUE}[3/5] Überprüfe Pentest-Werkzeuge...${RESET}"
if [ ! -d "$HOME/exploitdb" ]; then
    echo -e "${BLUE}[+] Lade Exploit-Datenbank...${RESET}"
    git clone --depth 1 https://github.com/offensive-security/exploitdb.git $HOME/exploitdb
    sudo ln -sf $HOME/exploitdb/searchsploit /usr/local/bin/searchsploit
fi

# 4. Agent-Entpackung & Syntax-Bereinigung
echo -e "${BLUE}[4/5] Entpacke Agent-Dateien...${RESET}"
ZIP_FILE=$(ls autonomous_agent_v150.zip 2>/dev/null | head -n 1)

if [ -f "$ZIP_FILE" ]; then
    unzip -o "$ZIP_FILE"
    # Entfernt unsichtbare Formatierungszeichen, die Syntax-Fehler verursachen
    sed -i 's/\xe2\x80\x8b//g' autonomous_agent.py 2>/dev/null
    echo -e "${GREEN}[+] Agent entpackt und bereinigt.${RESET}"
else
    echo -e "${RED}[!] ZIP-Datei nicht gefunden! Erstelle Grundgerüst...${RESET}"
fi

# 5. Finalisierung
echo -e "${BLUE}[5/5] Erstelle Start-Routine...${RESET}"
chmod +x *.py 2>/dev/null
echo -e '#!/bin/bash\npython3 autonomous_agent.py' > pentest
chmod +x pentest

echo -e "${GREEN}"
echo "===================================================="
echo "   INSTALLATION ABGESCHLOSSEN (REPAIR MODE)         "
echo "===================================================="
echo " Du kannst das Programm jetzt starten mit:          "
echo " ./pentest                                          "
echo "===================================================="
echo -e "${RESET}"
