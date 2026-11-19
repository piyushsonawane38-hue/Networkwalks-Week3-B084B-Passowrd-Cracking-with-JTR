# 🔐 Week 3 Report: Password Cracking with JTR, Networkwalks & AI-Assisted Tooling

**Cybersecurity Internship | Networkwalks | Week 3 (Project Module 1 & 2 + Optional AI Module)**

![Kali Linux](https://img.shields.io/badge/Kali-Linux-557C94?logo=kalilinux&logoColor=white)
![Skill](https://img.shields.io/badge/Skill-Cybersecurity-C00000?style=flat-square)
![Scope](https://img.shields.io/badge/Scope-Authorized%20Only-red)
![Purpose](https://img.shields.io/badge/Purpose-Education%20Only-blue)
![Modules](https://img.shields.io/badge/Modules-3%2F3-brightgreen)

| Field | Detail |
| --- | --- |
| **Intern** | Piyush Sonawane |
| **Program / Batch** | B084B - Networkwalks Cybersecurity Internship |
| **Week** | Week 3 |
| **Modules** | PM1 JTR + Johnny GUI · PM2 Networkwalks Hash/Cracker Tools · PM-Optional AI-Assisted (Claude Desktop + Hexstrike MCP) |
| **Targets** | Self-created lab files only — `My Locked PDF1.pdf`, File 2, File 3 (same `My Locked PDF1.pdf` reused for the Networkwalks and Hexstrike MCP modules) |
| **Permission secured?** | Yes — all files were created for this lab; no third-party files or systems were touched |

---

## 📑 Table of Contents
1. [Liability Disclaimer](#1-liability-disclaimer)
2. [Introduction](#2-introduction)
3. [Tools Used](#3-tools-used)
4. [Activities Performed](#4-activities-performed)
5. [Results Summary](#5-results-summary)
6. [Recommendations](#6-recommendations)
7. [Key Learnings](#7-key-learnings)
8. [Repository Structure](#8-repository-structure)
9. [Conclusion](#9-conclusion)

---

## 1. Liability Disclaimer

> ⚠️ All password-cracking activity in this lab was performed on **PDF files created specifically for this exercise** — no third-party, production, or publicly hosted files were targeted. This is for **education only**: these techniques recover passwords on files/systems you own or have explicit written permission to test. Unauthorised use against someone else's files or systems is illegal in most jurisdictions.
>
> 🔒 No real third-party credentials, personal documents, or production systems were involved at any stage.

---

## 2. Introduction

Week 3 covers **password auditing/recovery** — a core part of understanding how weak passwords and legacy document encryption can be broken. The lab was run three ways on encrypted PDFs: locally with **John the Ripper (JTR)** and its **Johnny** GUI, via browser-based tools from **Networkwalks**, and (optionally) through an **AI agent** (Claude Desktop) driving the same JTR attack via the **Hexstrike MCP** server. Each module below shows the steps, the tool, and the result.

```mermaid
flowchart LR
    A[Encrypted PDF] --> B[Hash extraction<br>pdf2john / online extractor]
    B --> C[Dictionary / brute-force attack<br>john / Johnny / Networkwalks cracker]
    C --> D[Recovered password]
    D --> E[PDF opened]
```

---

## 3. Tools Used

| Tool | Type | Purpose |
| --- | --- | --- |
| **John the Ripper (john)** | Local / CLI | Password recovery engine (dictionary, incremental attacks) |
| **Johnny** | Local / GUI | Graphical front-end for John |
| **pdf2john.pl** (bundled with JTR) | Local | Extracts a crackable hash from an encrypted PDF |
| **Networkwalks Hash Calculator** | Browser | Extracts a PDF's hash with no install |
| **Networkwalks Password Cracker** | Browser | Runs a dictionary attack on the extracted hash |
| **Claude Desktop** | AI agent | Natural-language interface for driving security tools |
| **Hexstrike MCP** | MCP server | Exposes CLI security tools (incl. JTR) to the AI agent |

A full command reference is in [`docs/commands-cheatsheet.md`](docs/commands-cheatsheet.md).

---

## 4. Activities Performed

### 4.1 PM1: Password Cracking with JTR + Johnny GUI

**Task:** crack `My Locked PDF1.pdf` (+ two more files) using `john`/Johnny on Windows.

**1. Install John the Ripper** from the official site: https://www.openwall.com/john/

![Downloading John the Ripper](screenshots/img1.png)

**2. Install Johnny** (GUI for John), latest version 2.2: https://openwall.info/wiki/john/johnny

![Johnny download page](screenshots/img2.png)

After installing, open Johnny:

![Johnny opened](screenshots/img3.png)

Click **Settings** and browse to `john.exe`, found in John's `run` folder:

![Johnny settings — browse to john.exe](screenshots/img4.png)
![Selecting john.exe in the run folder](screenshots/img5.png)

**3. Extract the hash from the locked PDF.** Download the encrypted PDF, then use the [online PDF hash extractor](https://www.onlinehashcrack.com/tools-pdf-hash-extractor.php) to upload it and get its hash (starts with `$pdf$...`). Save the hash into a `.txt` file — this is the "password file" Johnny expects.

![PDF hash extractor site](screenshots/img6.png)
![Hash extracted from My Locked PDF1.pdf](screenshots/img7.png)

> 💡 Equivalent CLI step: John ships with a `pdf2john.pl` script that does exactly this locally, with no upload to a third-party site — see [`scripts/extract_pdf_hash.sh`](scripts/extract_pdf_hash.sh) for a wrapper around it.

**4. Crack it with Johnny.** Open Johnny → **Open password file** → select the `.txt` hash file, then click **Start new attack**:

![Open password file in Johnny](screenshots/img8.png)
![Starting the attack in Johnny](screenshots/img9.png)

Wait for Johnny to report the cracked password:

![Password cracked](screenshots/img10.png)

**Result:** `My Locked PDF1.pdf` → password **`good-luck`**

![good-luck password confirmed, file opened](screenshots/img11.png)

The same workflow was repeated for two additional files:

| File | Password |
|---|---|
| File 2 | **`Password1`** |
| File 3 | **`1qaz2wsx`** |

![File 2 cracked](screenshots/img12.png)
![File 3 cracked](screenshots/img13.png)

**Note:** attack mode matters — for short/common passwords a straight dictionary attack (e.g. `rockyou.txt`) is usually enough; for anything longer, incremental/brute-force mode is needed but takes much longer.

---

### 4.2 PM2: Password Cracking with Networkwalks Tools

**Task:** crack `My Locked PDF1.pdf` using the [Networkwalks Hash Calculator](https://networkwalks.com/hash-calculator/) and [Password Cracker](https://networkwalks.com/password-cracker/) — fully browser-based, no install.

**1.** Download the encrypted PDF to your machine, from the lab page:

![Lab page with the encrypted PDF](screenshots/img14.png)
![Download link detail](screenshots/img15.png)

**2–3.** Open the Hash Calculator and upload the locked PDF — it returns a hash starting with `$pdf$...`:

![Hash Calculator output](screenshots/img16.png)

**4–6.** Copy the hash, open the Password Cracker, paste it in and run the dictionary attack:

![Password Cracker — dictionary attack running](screenshots/img17.png)

**7.** Use the recovered password (`Password1`) to open the PDF:

![PDF opened with the recovered password](screenshots/img18.png)

**Why this is useful to know alongside Module 1:**

| | Module 1 (JTR + Johnny) | Module 2 (Networkwalks) |
|---|---|---|
| Install required | Yes (John + Johnny) | No — fully browser-based |
| Works offline | Yes | No — needs internet |
| Wordlist control | Full control (any wordlist, rules, brute-force) | Limited to the site's built-in dictionary |
| Good for | Repeatable, scriptable workflows | Quick one-off checks, no-install environments |

**Result:** `My Locked PDF1.pdf` → opened successfully with the recovered password **`Password1`**.

---

### 4.3 PM-Optional: AI-Assisted Cracking (Claude Desktop + Hexstrike MCP)

**Task:** set up Hexstrike MCP on Kali Linux and crack `My Locked PDF1.pdf` through natural-language prompts to Claude Desktop instead of manual commands.

**Part A — Install Claude Desktop on Kali Linux.** Repo & instructions: https://github.com/aaddrick/claude-desktop-debian

> ⚠️ This is a **community/unofficial** packaging of Claude Desktop for Linux, not an Anthropic-published package. Review the repo before trusting the install script on a machine you care about.

![claude-desktop-debian repo](screenshots/img19.png)

```bash
curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop-unofficial.gpg
echo "deb [signed-by=/usr/share/keyrings/claude-desktop-unofficial.gpg arch=amd64,arm64] https://pkg.claude-desktop-debian.dev stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop-unofficial.list
sudo apt update
sudo apt install claude-desktop-unofficial
```

Launch with `claude-desktop-unofficial` and sign in:

![Claude Desktop launching](screenshots/img20.png)
![Claude Desktop sign-in](screenshots/img21.png)

**Part B — Install Hexstrike MCP.** Repo: https://github.com/0x4m4/hexstrike-ai

```bash
git clone https://github.com/0x4m4/hexstrike-ai.git
cd hexstrike-ai
python3 -m venv hexstrike-env
source hexstrike-env/bin/activate
pip3 install -r requirements.txt   # can take a while
python3 hexstrike_server.py
```

![Installing Python dependencies](screenshots/img22.png)
![Hexstrike server running](screenshots/img23.png)

Register the MCP server in Claude Desktop (Developer settings → **Edit Config**):

![Editing the MCP server config](screenshots/img24.png)

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

Restart Claude Desktop — the server should now show as running/connected:

![Server running after restart, instance 1](screenshots/img25.png)
![Server running after restart, instance 2](screenshots/img26.png)

**Part C — Run the lab via natural language.** Copy `My Locked PDF1.pdf` to the Kali Desktop, open Claude Desktop (now MCP-connected to Hexstrike), and prompt it to extract the hash and run a John the Ripper dictionary attack:

![Prompting Claude to extract the hash and crack the PDF](screenshots/img27.png)
![Claude working through the attack via Hexstrike](screenshots/img28.png)

Claude, via the Hexstrike MCP tools, calls the underlying CLI tools (effectively the same `pdf2john` + `john` flow as Module 1) and reports back the cracked password:

![Password cracked by Claude via Hexstrike](screenshots/img29.png)

**Result:** `My Locked PDF1.pdf` → password **`good-luck`**, cracked in ~3.8 seconds against `rockyou.txt`.

**Takeaway:** this module doesn't introduce a new cracking technique — it's the **same JTR dictionary attack** as Module 1, just orchestrated by an AI agent that has tool access through MCP instead of you typing each command yourself. It's a good illustration of how agentic AI tooling composes existing, well-known CLI utilities rather than replacing them.

---

## 5. Results Summary

| File | Method | Password found |
| --- | --- | --- |
| `My Locked PDF1.pdf` | JTR + Johnny | `good-luck` |
| File 2 | JTR + Johnny | `Password1` |
| File 3 | JTR + Johnny | `1qaz2wsx` |
| `My Locked PDF1.pdf` (repeat) | Networkwalks tools | `Password1` |
| `My Locked PDF1.pdf` (repeat) | Hexstrike MCP + Claude | `good-luck` |

> These are recovered test passwords, not vulnerabilities in a live system — each was deliberately set on a lab file for this exercise.

---

## 6. Recommendations

1. **Use long, random passphrases** — short/common passwords (like `good-luck`) fall to a dictionary attack in seconds.
2. **Prefer modern encryption** — PDF's legacy RC4-based encryption (older Acrobat versions) is far weaker than AES-256 with a strong password.
3. **Don't upload sensitive files to third-party hash-extractor sites** — the local `pdf2john.pl` route (see `scripts/extract_pdf_hash.sh`) avoids sending a file off-machine.
4. **Rotate and never reuse** passwords used for encrypting shared documents.
5. **Treat AI-agent tool access (MCP) like any other privileged tool** — an agent with shell/tool access should only run inside an authorized, scoped lab environment.

---

## 7. Key Learnings

- Hash extraction is the common first step across all three methods — local (`pdf2john`), browser-based (Networkwalks), or AI-orchestrated (Hexstrike) all produce/consume the same `$pdf$...` hash format.
- A GUI (Johnny) is easier to screenshot for a report; the CLI (`john`) is what actually scales to many files — see `scripts/extract_pdf_hash.sh`.
- The "AI-assisted" module isn't a new attack technique — it's the same JTR dictionary attack, just invoked through an agent with MCP tool access instead of typing commands by hand.
- Weak, short, dictionary-guessable passwords are cracked in seconds; this is the practical argument for passphrase-based password policies.

---

## 8. Repository Structure

```
├── README.md                 # this report (all 3 modules + results)
├── screenshots/               # evidence (img1 - img29)
├── docs/
│   └── commands-cheatsheet.md # every command used, in one place
├── scripts/
│   └── extract_pdf_hash.sh    # local pdf2john + john wrapper (no third-party upload)
└── .gitignore
```

---

## 9. Conclusion

Week 3 walked through password recovery on encrypted PDFs from three angles: a local CLI/GUI tool (JTR + Johnny), a no-install browser workflow (Networkwalks), and an AI-orchestrated version of the same attack (Claude Desktop + Hexstrike MCP). All three converge on the same underlying technique — extract a crackable hash, then run a dictionary/brute-force attack against it — which is the real lesson: the tooling changes, the weak-password problem doesn't.

---

**Prepared by:** Piyush Sonawane | Cybersecurity Intern | Networkwalks
<p align="center"><em>- End -</em></p>
