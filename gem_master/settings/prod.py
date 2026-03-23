from .base import *

# Production overrides
DEBUG = False

# Ensure SECRET_KEY is set in the environment for production
if not SECRET_KEY:
    raise RuntimeError('SECRET_KEY must be set in production')
