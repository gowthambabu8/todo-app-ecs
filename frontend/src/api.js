import axios from "axios";

// Injected at build/runtime via env var — points to the ALB DNS/API path.
// e.g. https://api.yourdomain.com or http://<alb-dns-name>/api
const API_BASE_URL = process.env.REACT_APP_API_URL || "http://localhost:8000";

const client = axios.create({
  baseURL: API_BASE_URL,
  headers: { "Content-Type": "application/json" },
});

export const getTodos = () => client.get("/api/todos");
export const getTodo = (id) => client.get(`/api/todos/${id}`);
export const createTodo = (todo) => client.post("/api/todos", todo);
export const updateTodo = (id, todo) => client.put(`/api/todos/${id}`, todo);
export const deleteTodo = (id) => client.delete(`/api/todos/${id}`);
