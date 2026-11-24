#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [[ ! -f .env ]]; then
  echo 'Copie .env.example para .env e preencha as configurações públicas do Supabase.' >&2
  exit 1
fi
exec flutter run --dart-define-from-file=.env "$@"
