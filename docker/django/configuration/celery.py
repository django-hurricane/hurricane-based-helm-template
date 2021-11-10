import os

from celery import Celery


# Set the default Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'configuration.settings')

BROKER_CONNECTION = f"amqp://{os.getenv('AMQP_USERNAME')}:{os.getenv('AMQP_PASSWORD')}" \
                    f"@{os.getenv('AMQP_HOST')}:{os.getenv('AMQP_PORT')}/{os.getenv('AMQP_VHOST')}"
app = Celery('dj-hurricane-base', broker=BROKER_CONNECTION)

# Load task modules from all registered Django apps.
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')
