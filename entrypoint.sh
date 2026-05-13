#!/bin/sh

if [ -z "$SECRET_KEY" ]; then
  export SECRET_KEY=$(python -c "import secrets; print(secrets.token_hex(32))")
fi

exec gunicorn -b 0.0.0.0:8000 --workers 3 --worker-class gthread --threads 4  app:app