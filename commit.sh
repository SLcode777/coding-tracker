#!/usr/bin/env bash
set -euo pipefail

# Usage: ./commit.sh [nombre_de_commits]
# Par défaut: 1 commit

N=${1:-1}

if ! [[ "$N" =~ ^[1-9][0-9]*$ ]]; then
  echo "Erreur: le nombre de commits doit être un entier positif." >&2
  exit 1
fi

LOGFILE="activity.log"

echo "Enregistrement de $N commit(s) pour aujourd'hui..."

for i in $(seq 1 "$N"); do
  echo "[$(date -Iseconds)] session du $(date '+%Y-%m-%d') — commit $i/$N" >> "$LOGFILE"
  git add "$LOGFILE"
  git commit -m "chore: activité du $(date '+%Y-%m-%d') ($i/$N)"
done

git push

echo "Done. $N commit(s) poussé(s) sur GitHub."
