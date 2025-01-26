#!/bin/bash
set -euo pipefail
python -m http.server 8000 --bind 0.0.0.0
