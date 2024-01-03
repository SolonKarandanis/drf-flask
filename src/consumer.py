import pika, json
from src.config import Config
import logging

params = pika.URLParameters(Config.AMQP_URL)

connection = pika.BlockingConnection(params)

channel = connection.channel()

channel.queue_declare(queue='drf')

logger = logging.getLogger(__name__)


def callback(ch, method, properties, body):
    print('Received in Flask microservice')
    data = json.loads(body)
    logger.info(f'data {data}')
    print(data)
    if properties.content_type == 'orders_created':
        logger.info(f'orders_created message received')

