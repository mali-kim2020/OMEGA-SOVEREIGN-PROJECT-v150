# 🛡️ PROJECT OMEGA SOVEREIGN v150 - Ghost Edition
> **Maximale Stealth. Totale Souveränität. KI-gesteuerte Infiltration.**
> 
Project Omega Sovereign ist ein autonomer, KI-gestützter Sicherheits-Agent, der speziell für die Ausführung in mobilen Linux-Umgebungen (UserLAnd / Debian) entwickelt wurde. Er kombiniert die taktische Präzision von Metasploit und Nikto mit der strategischen Intelligenz moderner KI-Modelle (OpenAI GPT-4o / Gemini 2.5).
Durch die Integration des Tor-Netzwerks agiert der Agent auf Wunsch als absoluter "Ghost" – komplett unsichtbar und nicht zurückverfolgbar.
## 🚀 Kern-Features (The Arsenal)
 * 👻 **Ghost Routing (Tor):** Vollautomatische Verschleierung der echten IP-Adresse durch Proxychains und das Tor-Netzwerk. Keine direkten Verbindungen zum Ziel.
 * 🧠 **Neural Memory (mit CVE-Gedächtnis):** Speichert Port-Historien, Block-Events **und extrahierte CVE-Nummern** in einer lokalen SQLite-Datenbank. Der Agent lernt aus KI-Briefings und übergibt die gemerkten Schwachstellen bei zukünftigen Scans desselben Ziels sofort wieder an Metasploit – selbst wenn die KI im Folge-Scan übersprungen wird.
 * 🤖 **AI Strategy & CVE-Bridge:** Analysiert Scan-Daten in Echtzeit, extrahiert vollautomatisch passende CVE-Nummern aus der KI-Antwort und überführt diese direkt als Suchauftrag in die Metasploit-Engine.
 * 🎭 **Ultimate Evasion:** Gauß'scher Jitter, rotierende User-Agents und Tor-Latenz-Anpassungen zur Umgehung von modernen WAFs (Cloudflare, DataDome, Akamai).
 * 🕸️ **Automated Web-Audit:** Integrierter Nikto-Workflow zum Aufspüren offener Admin-Panels, Backups und Config-Dateien.
## 🛠️ Installation & Setup
Die Installation kann bis zu 10 min dauern! Nach der Installation bitte Metasploit updaten!
Der Agent kommt mit einem Heavy-Duty-Installer, der alle Systemabhängigkeiten (inkl. Tor, Proxychains, Metasploit, ExploitDB) automatisch auflöst, das Python-Environment härtet und eine alte Datenbank nahtlos auf die neue CVE-Speicherung updatet.
```bash
# 1. Installer ausführbar machen
chmod +x setup_sovereign.sh

# 2. Infrastruktur hochziehen (Dauert ca. 5-10 Minuten)
./setup_sovereign.sh

```
### 🔑 Den KI-Zündschlüssel einsetzen
Aus Sicherheitsgründen wird dein API-Key **nicht** in Backups gespeichert (automatischer Ausschluss im Zip). Auf einem neuen System musst du ihn einmalig hinterlegen:
```bash
echo "DEIN_OPENAI_ODER_GEMINI_KEY" > .api_key

```
## 🕹️ Einsatz & Profile
Das Programm bleibt bei Metasploit nicht hängen. In der userland Umgebung dauert der Start der console ca 30 - 60 Sekunden!
Starte das System einfach über den Ghost-Launcher. Dieser bootet automatisch das Tor-Netzwerk im Hintergrund und routet den gesamten Traffic durch den verschlüsselten Tunnel:
```bash
./pentest

```
### Die taktischen Profile:
| Profil | Name | Zweck |
|---|---|---|
| **1** | RECON ONLY | Leiser, schneller Port-Scan. Keine Exploits, kein Lärm. |
| **2** | STANDARD AUDIT | Die goldene Mitte. Ports, Nikto-Web-Audit und MSF/EDB-Exploitsuche. |
| **3** | GHOST SOVEREIGN | **Maximum Stealth.** Extreme Timeouts und Tor-Optimierung, um unter dem Radar von Firewalls zu fliegen und Latenzen auszugleichen. |
## 📂 Dateistruktur (Sovereign Core)
 * autonomous_agent.py — Die zentrale KI-, Netzwerk- und Evasion-Logik.
 * setup_sovereign.sh — Der Heavy-Duty Installer (installiert Tor, MSF, EDB).
 * pentest — Der Launcher (startet den Tor-Daemon und Proxychains).
 * pentest_history.db — Das neuronale Gedächtnis (SQLite - speichert nun auch CVEs).
 * reports/ — Automatisch generierte Markdown-Berichte inkl. KI-Briefings und CVE-Mappings.
 * .api_key — Dein unsichtbarer Schlüssel.
## ⚖️ Rechtlicher Hinweis & Rules of Engagement
**AUTHORIZED USE ONLY.** Dieses Toolset wurde ausschließlich für den Einsatz in autorisierten Red-Team-Audits und für Bildungszwecke entwickelt. Der Einsatz gegen fremde Netzwerke ohne ausdrückliche, schriftliche Genehmigung (Get-Out-of-Jail-Free Card) ist illegal. Tor-Routing schützt nicht vor Konsequenzen bei illegalen Handlungen. Der Entwickler übernimmt keinerlei Haftung für Missbrauch.
**Status:** v150 - GHOST ROUTING & FULL NEURAL MEMORY READY 🕵️‍♂️🔥🚀
