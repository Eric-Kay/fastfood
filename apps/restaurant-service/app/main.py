from fastapi import FastAPI

app = FastAPI(title="restaurant-service")

RESTAURANTS = [
    {"id": 1, "name": "Naija Kitchen", "cuisine": "African"},
    {"id": 2, "name": "Pizza Corner", "cuisine": "Italian"},
    {"id": 3, "name": "Spice House", "cuisine": "Indian"}
]

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/restaurants")
def get_restaurants():
    return RESTAURANTS