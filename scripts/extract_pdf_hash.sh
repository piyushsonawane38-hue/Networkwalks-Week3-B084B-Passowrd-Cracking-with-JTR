#!/usr/bin/env bash
#
# extract_pdf_hash.sh
#
# A thin, local-only wrapper around John the Ripper's own pdf2john.pl,
# so Module 1's "upload to a hash-extractor website" step can be done
# offline instead -- useful when you don't want to upload a file to a
# third-party site, or when working without internet access.
#
# Requirements: John the Ripper installed with its "run" folder on PATH
# (or pass its location via JOHN_RUN_DIR). This only wraps tools you
# already installed in Module 1 -- it performs no cracking of its own.
#
# Usage:
#   ./extract_pdf_hash.sh path/to/locked.pdf [wordlist.txt]
#
# If a wordlist is given, it also launches `john` with that wordlist
# against the extracted hash. Omit it to just extract the hash and stop.

set -euo pipefail

PDF_FILE="${1:?Usage: $0 <pdf-file> [wordlist]}"
WORDLIST="${2:-}"
JOHN_RUN_DIR="${JOHN_RUN_DIR:-}"

find_tool() {
  local name="$1"
  if [[ -n "$JOHN_RUN_DIR" && -x "$JOHN_RUN_DIR/$name" ]]; then
    echo "$JOHN_RUN_DIR/$name"
  elif command -v "$name" >/dev/null 2>&1; then
    command -v "$name"
  else
    echo ""
  fi
}

PDF2JOHN="$(find_tool pdf2john.pl)"
JOHN_BIN="$(find_tool john)"

if [[ -z "$PDF2JOHN" ]]; then
  echo "pdf2john.pl not found. Set JOHN_RUN_DIR to John's 'run' folder, or add it to PATH." >&2
  exit 1
fi

if [[ ! -f "$PDF_FILE" ]]; then
  echo "File not found: $PDF_FILE" >&2
  exit 1
fi

HASH_FILE="$(basename "${PDF_FILE%.*}")_hash.txt"

echo "[*] Extracting hash from: $PDF_FILE"
perl "$PDF2JOHN" "$PDF_FILE" > "$HASH_FILE"
echo "[+] Hash written to: $HASH_FILE"
cat "$HASH_FILE"

if [[ -n "$WORDLIST" ]]; then
  if [[ -z "$JOHN_BIN" ]]; then
    echo "john binary not found; skipping crack step. Hash file is ready for Johnny GUI instead." >&2
    exit 0
  fi
  if [[ ! -f "$WORDLIST" ]]; then
    echo "Wordlist not found: $WORDLIST" >&2
    exit 1
  fi
  echo "[*] Running john with wordlist: $WORDLIST"
  "$JOHN_BIN" --wordlist="$WORDLIST" "$HASH_FILE"
  echo "[*] Showing cracked result (if any):"
  "$JOHN_BIN" --show "$HASH_FILE"
else
  echo "[i] No wordlist given -- hash extracted only. Load '$HASH_FILE' into Johnny GUI to crack it,"
  echo "    or re-run this script with a wordlist: $0 \"$PDF_FILE\" /path/to/wordlist.txt"
fi
