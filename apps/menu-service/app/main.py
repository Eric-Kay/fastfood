from fastapi import FastAPI

app = FastAPI(title="menu-service")

MENU = [
    {"id": 1, "name": "Jollof Rice", "price": 12.99},
    {"id": 2, "name": "Pepperoni Pizza", "price": 10.99},
    {"id": 3, "name": "Chicken Curry", "price": 11.50}
]

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/menu")
def get_menu():
    return MENU