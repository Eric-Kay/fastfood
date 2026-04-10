from fastapi import FastAPI
from pydantic import BaseModel
import json
import os
import pika

app = FastAPI(title="order-service")

ORDERS = []

class Order(BaseModel):
    user: str
    item_name: str
    quantity: int

def publish_order(order: dict):
    rabbitmq_host = os.getenv("RABBITMQ_HOST", "rabbitmq")
    try:
        connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=rabbitmq_host)
        )
        channel = connection.channel()
        channel.queue_declare(queue="orders")
        channel.basic_publish(exchange="", routing_key="orders", body=json.dumps(order))
        connection.close()
    except Exception as exc:
        print(f"RabbitMQ publish failed: {exc}")

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/orders")
def get_orders():
    return ORDERS

@app.post("/orders")
def create_order(order: Order):
    new_order = {"id": len(ORDERS) + 1, **order.dict(), "status": "PLACED"}
    ORDERS.append(new_order)
    publish_order(new_order)
    return new_order