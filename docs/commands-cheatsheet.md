# Commands Cheatsheet — Week 3

Every command referenced across the three modules, in one place.

## PM1 — JTR + Johnny

```bash
# Extract a hash locally instead of uploading to a website (John's run folder)
perl pdf2john.pl "My Locked PDF1.pdf" > hash.txt

# Crack with a wordlist from the CLI (what Johnny does under the hood)
john --wordlist=rockyou.txt hash.txt

# Show the cracked password
john --show hash.txt
```

## PM2 — Networkwalks (browser-only, no CLI)

1. https://networkwalks.com/hash-calculator/ → upload PDF → copy `$pdf$...` hash
2. https://networkwalks.com/password-cracker/ → paste hash → run dictionary attack

## PM-Optional — Hexstrike MCP setup (Kali Linux)

```bash
# Claude Desktop (community package)
curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop-unofficial.gpg
echo "deb [signed-by=/usr/share/keyrings/claude-desktop-unofficial.gpg arch=amd64,arm64] https://pkg.claude-desktop-debian.dev stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop-unofficial.list
sudo apt update
sudo apt install claude-desktop-unofficial
claude-desktop-unofficial

# Hexstrike MCP
git clone https://github.com/0x4m4/hexstrike-ai.git
cd hexstrike-ai
python3 -m venv hexstrike-env
source hexstrike-env/bin/activate
pip3 install -r requirements.txt
python3 hexstrike_server.py
```

MCP config added in Claude Desktop → Developer settings → Edit Config:

```json
{
  "mcpServers": {
    "hexstrike-ai": {
      "command": "/home/kali/hexstrike-ai/hexstrike-env/bin/python",
      "args": [
        "/home/kali/hexstrike-ai/hexstrike_mcp.py",
        "--server",
        "http://localhost:8888"
      ]
    }
  }
}
```
