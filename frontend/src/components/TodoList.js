import React from "react";

export default function TodoList({ todos, onToggle, onDelete }) {
  if (todos.length === 0) {
    return <p>No todos yet. Add one above.</p>;
  }

  return (
    <ul style={{ listStyle: "none", padding: 0 }}>
      {todos.map((todo) => (
        <li
          key={todo.id}
          style={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            padding: "0.5rem",
            borderBottom: "1px solid #ddd",
          }}
        >
          <div>
            <input
              type="checkbox"
              checked={todo.is_completed}
              onChange={() => onToggle(todo)}
            />
            <span
              style={{
                marginLeft: "0.5rem",
                textDecoration: todo.is_completed ? "line-through" : "none",
              }}
            >
              <strong>{todo.title}</strong>
              {todo.description ? ` — ${todo.description}` : ""}
            </span>
          </div>
          <button onClick={() => onDelete(todo.id)}>Delete</button>
        </li>
      ))}
    </ul>
  );
}
