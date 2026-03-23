import os

# Default to development settings. Set DJANGO_ENV=production to use production settings.
env = os.environ.get('DJANGO_ENV', 'development').lower()
if env == 'production':
    from .prod import *  # noqa: F401,F403
else:
    from .dev import *  # noqa: F401,F403
