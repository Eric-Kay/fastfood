import json
import os
import time
import pika

def callback(ch, method, properties, body):
    order = json.loads(body.decode())
    print(f"Processing notification for order: {order}")
    ch.basic_ack(delivery_tag=method.delivery_tag)

def main():
    rabbitmq_host = os.getenv("RABBITMQ_HOST", "rabbitmq")

    while True:
        try:
            connection = pika.BlockingConnection(
                pika.ConnectionParameters(host=rabbitmq_host)
            )
            channel = connection.channel()
            channel.queue_declare(queue="orders")
            channel.basic_consume(queue="orders", on_message_callback=callback)
            print("Worker started. Waiting for messages...")
            channel.start_consuming()
        except Exception as exc:
            print(f"Worker connection failed: {exc}")
            time.sleep(5)

if __name__ == "__main__":
    main()