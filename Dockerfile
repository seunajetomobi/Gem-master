FROM python:3.11-bullseye

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN python -m pip install --upgrade pip 'setuptools<82' wheel \
    && python -m pip install --no-cache-dir -r requirements.txt
RUN python - <<'PY'
import site, os, sys, subprocess
print('SITE_PACKAGES:', site.getsitepackages())
p = site.getsitepackages()[0]
try:
    files = sorted([f for f in os.listdir(p) if 'setuptools' in f or 'pkg_resources' in f or 'dist-info' in f])
except Exception as e:
    files = ['LIST_ERROR:'+str(e)]
print('FILES_IN_SITE_PACKAGES:', files)
try:
    print('\nPIP SHOW SETUPTOOLS:')
    res = subprocess.run([sys.executable,'-m','pip','show','setuptools'], capture_output=True, text=True)
    print(res.stdout or res.stderr)
except Exception as e:
    print('PIP SHOW ERROR', e)
PY

COPY . /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
