CREATE TABLE delivery_methods (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    base_fee INT NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);