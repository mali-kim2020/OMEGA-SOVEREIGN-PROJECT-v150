# 🛡️ OMEGA SOVEREIGN v150 - Autonomous Pentest Agent
**Maximale Stealth. Totale Souveränität. KI-gesteuerte Infiltration.**
Omega Sovereign ist ein autonomer Sicherheits-Agent, der speziell für die Ausführung in mobilen Linux-Umgebungen (UserLAnd/Termux) entwickelt wurde. Er kombiniert die taktische Präzision von Metasploit mit der strategischen Intelligenz moderner KI-Modelle (Gemini 2.5 / GPT-4o).
## 🚀 Kern-Features
 * 🧠 **Neural Memory:** Speichert Port-Historien und Block-Events in einer lokalen SQLite-Datenbank, um aus vergangenen Scans zu lernen.
 * 🎭 **Ultimate Evasion:** Gauß'scher Jitter, User-Agent-Rotation und simulierte menschliche Browser-Fingerprints zur Umgehung von KI-WAFs (DataDome, Cloudflare).
 * 🤖 **AI Strategy Bridge:** Erstellt vor jedem Angriff ein taktisches Briefing basierend auf CVE-Daten und Echtzeit-Recon.
 * 🕸️ **Web-Phase:** Automatisierter Scan nach Admin-Panels, Config-Files und Backups (Nikto-Integration).
 * ⚡ **MSF-Batch-Engine:** Hochgeschwindigkeits-Suche nach "Excellent" Exploits direkt im Metasploit-Framework.
## 🛠️ Installation (UserLAnd / Debian)
Um das System auf einem frischen Gerät zu installieren, lade den Installer und die ZIP-
Die Installation kann bis zu 10 min dauern. Bitte nach der Installation Metasploit Updaten! Datei in einen Ordner und führe aus:
```bash
chmod +x setup_sovereign.sh
./setup_sovereign.sh

```
### 🚨 Der "Requests" & Python-Fix (Integrierbar)
Das Skript nutzt apt, um Debian-Sperren zu umgehen. Falls trotzdem mal ein Python-Modul fehlt:
```bash
sudo apt update && sudo apt install -y python3-requests python3-urllib3

```
## 📑 Benutzung
Nach der Installation startest du den Agenten mit dem integrierten Launcher:
```bash
./pentest

```
### Die Scan-Profile:
 1. **RECON ONLY:** Schnelle Port-Analyse ohne tiefes Audit.
 2. **STANDARD AUDIT:** Die goldene Mitte mit Nikto-Checks und Exploit-Suche.
 3. **GHOST SOVEREIGN:** Maximale Tarnung mit langen Verzögerungen (ideal bei aktiver KI-Abwehr).
## 🔑 API-Schlüssel hinterlegen
Das Backup sichert deinen Schlüssel aus guten Gründen **nicht** mit. Füge ihn auf einem neuen System so ein:
```bash
echo "DEIN_SCHLÜSSEL" > .api_key

```
## ⚖️ Rechtlicher Hinweis
Dieses Tool wurde ausschließlich für autorisierte Sicherheitsaudits und Bildungszwecke entwickelt. Der Einsatz gegen Ziele ohne vorherige schriftliche Genehmigung ist illegal. Der Entwickler übernimmt keine Haftung für Missbrauch.
**Status:** v150 - FULL OMEGA SOVEREIGN READY 🕵️‍♂️🚀✨
