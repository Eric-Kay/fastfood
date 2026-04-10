import { useEffect, useState } from "react";

export default function App() {
    const [restaurants, setRestaurants] = useState([]);
    const [menu, setMenu] = useState([]);
    const [orders, setOrders] = useState([]);
    const [error, setError] = useState("");

    const loadRestaurants = async () => {
        try {
            const res = await fetch("/api/restaurants");
            const data = await res.json();
            setRestaurants(data);
        } catch (err) {
            setError("Failed to load restaurants");
        }
    };

    const loadMenu = async () => {
        try {
            const res = await fetch("/api/menu");
            const data = await res.json();
            setMenu(data);
        } catch (err) {
            setError("Failed to load menu");
        }
    };

    const loadOrders = async () => {
        try {
            const res = await fetch("/api/orders");
            const data = await res.json();
            setOrders(data);
        } catch (err) {
            setError("Failed to load orders");
        }
    };

    useEffect(() => {
        loadRestaurants();
        loadMenu();
        loadOrders();
    }, []);

    const placeOrder = async (item) => {
        try {
            const res = await fetch("/api/orders", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    user: "eric@example.com",
                    item_name: item.name,
                    quantity: 1
                })
            });
            const data = await res.json();
            setOrders((prev) => [...prev, data]);
        } catch (err) {
            setError("Failed to place order");
        }
    };

    return (
        <div style={{ padding: 24, fontFamily: "Arial, sans-serif", background: "#f9fafb", minHeight: "100vh" }}>
            <h1>FoodFast</h1>
            <p>Cloud-native food delivery platform</p>

            {error && (
                <div style={{ background: "#fee2e2", color: "#991b1b", padding: 12, borderRadius: 8, marginBottom: 16 }}>
                    {error}
                </div>
            )}

            <h2>Restaurants</h2>
            <div style={{ display: "grid", gap: 12, marginBottom: 24 }}>
                {restaurants.map((r) => (
                    <div key={r.id} style={{ background: "#fff", padding: 16, borderRadius: 10, border: "1px solid #e5e7eb" }}>
                        <strong>{r.name}</strong>
                        <div>{r.cuisine}</div>
                    </div>
                ))}
            </div>

            <h2>Menu</h2>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))", gap: 16, marginBottom: 24 }}>
                {menu.map((m) => (
                    <div key={m.id} style={{ background: "#fff", padding: 16, borderRadius: 10, border: "1px solid #e5e7eb" }}>
                        <h3>{m.name}</h3>
                        <p>£{m.price}</p>
                        <button onClick={() => placeOrder(m)}>Order</button>
                    </div>
                ))}
            </div>

            <h2>Orders</h2>
            <pre style={{ background: "#111827", color: "#fff", padding: 16, borderRadius: 10 }}>
                {JSON.stringify(orders, null, 2)}
            </pre>
        </div>
    );
}