import React, { useEffect, useState } from "react";
import { getTodos, createTodo, updateTodo, deleteTodo } from "./api";
import TodoForm from "./components/TodoForm";
import TodoList from "./components/TodoList";

function App() {
  const [todos, setTodos] = useState([]);
  const [error, setError] = useState(null);

  const loadTodos = async () => {
    try {
      const res = await getTodos();
      setTodos(res.data);
      setError(null);
    } catch (err) {
      setError("Could not load todos. Is the API reachable?");
    }
  };

  useEffect(() => {
    loadTodos();
  }, []);

  const handleCreate = async (todo) => {
    await createTodo(todo);
    loadTodos();
  };

  const handleToggle = async (todo) => {
    await updateTodo(todo.id, { is_completed: !todo.is_completed });
    loadTodos();
  };

  const handleDelete = async (id) => {
    await deleteTodo(id);
    loadTodos();
  };

  return (
    <div style={{ maxWidth: 600, margin: "2rem auto", fontFamily: "sans-serif" }}>
      <h1>Todo App</h1>
      {error && <p style={{ color: "red" }}>{error}</p>}
      <TodoForm onCreate={handleCreate} />
      <TodoList todos={todos} onToggle={handleToggle} onDelete={handleDelete} />
    </div>
  );
}

export default App;
