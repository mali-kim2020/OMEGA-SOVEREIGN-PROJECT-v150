# 🛡️ OMEGA SOVEREIGN v150 - Autonomous Pentest Agent
**Maximale Stealth. Totale Souveränität. KI-gesteuerte Infiltration.**
Omega Sovereign ist ein autonomer Sicherheits-Agent, der speziell für die Ausführung in mobilen Linux-Umgebungen (UserLAnd/Termux) entwickelt wurde. Er kombiniert die taktische Präzision von Metasploit mit der strategischen Intelligenz moderner KI-Modelle (Gemini 2.5 / GPT-4o).
## 🚀 Kern-Features
 * 🧠 **Neural Memory:** Speichert Port-Historien und Block-Events in einer lokalen SQLite-Datenbank, um aus vergangenen Scans zu lernen.
 * 🎭 **Ultimate Evasion:** Gauß'scher Jitter, User-Agent-Rotation und simulierte menschliche Browser-Fingerprints zur Umgehung von KI-WAFs (DataDome, Cloudflare).
 * 🤖 **AI Strategy Bridge:** Erstellt vor jedem Angriff ein taktisches Briefing basierend auf CVE-Daten und Echtzeit-Recon.
 * ⚡ **MSF-Batch-Engine:** Hochgeschwindigkeits-Suche nach "Excellent" Exploits direkt im Metasploit-Framework.
## 🛠️ Installation (UserLAnd / Debian)
Um das System auf einem frischen Gerät zu installieren, lade den Installer und die ZIP-Datei in einen Ordner und führe aus:
```bash
chmod +x setup_sovereign.sh
./setup_sovereign.sh

```
### 🚨 Der "Requests" & Python-Fix (WICHTIG)
Auf modernen Debian-Systemen (UserLAnd) schützt Python die Systemumgebung. Falls der Fehler ModuleNotFoundError: No module named 'requests' auftritt, löst dieser Befehl das Problem sofort:
```bash
# Der sicherste Weg über den System-Manager:
sudo apt update && sudo apt install -y python3-requests python3-urllib3

# Alternativ (falls apt nicht geht):
pip3 install requests urllib3 --break-system-packages

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
## 📂 Dateistruktur
 * autonomous_agent.py: Das Herzstück (Die Logik).
 * setup_sovereign.sh: Der automatisierte Installer.
 * pentest: Der Schnellstart-Launcher.
 * pentest_history.db: Das "Gehirn" (Neural Memory).
 * reports/: Hier werden die taktischen Markdown-Berichte gespeichert.
 * .api_key: Dein versteckter Schlüssel zur KI.
## ⚖️ Rechtlicher Hinweis
Dieses Tool wurde ausschließlich für autorisierte Sicherheitsaudits und Bildungszwecke entwickelt. Der Einsatz gegen Ziele ohne vorherige schriftliche Genehmigung ist illegal. Der Entwickler übernimmt keine Haftung für Missbrauch.
**Status:** v150 - OMEGA SOVEREIGN READY 🕵️‍♂️🚀✨
