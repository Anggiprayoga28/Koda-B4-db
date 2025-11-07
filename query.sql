CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(30) UNIQUE,
    password VARCHAR(255),
    role VARCHAR(25),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP 
);

CREATE TABLE user_profiles (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category_id INT NOT NULL,
    price INT NOT NULL,
    is_flash_sale BOOLEAN,
    is_favorite BOOLEAN,
    is_buy1get1 BOOLEAN,
    is_active BOOLEAN DEFAULT TRUE,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE product_images (
    id INT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_reviews (
    id INT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE promos (
    id INT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    discount_percentage INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE promo_products (
    id INT PRIMARY KEY,
    promo_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (promo_id) REFERENCES promos(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE delivery_methods (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    base_fee INT NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tax_rates (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    rate_percentage DECIMAL(5,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    delivery_address TEXT NOT NULL,
    delivery_method_id INT NOT NULL,
    subtotal INT NOT NULL,
    delivery_fee INT NOT NULL,
    tax_amount INT NOT NULL,
    tax_rate_id INT,
    total INT NOT NULL,
    promo_id INT,
    payment_method_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (delivery_method_id) REFERENCES delivery_methods(id),
    FOREIGN KEY (tax_rate_id) REFERENCES tax_rates(id),
    FOREIGN KEY (promo_id) REFERENCES promos(id) ON DELETE SET NULL,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    size_id INT REFERENCES product_sizes(id),
    temperature_id INT REFERENCES product_temperatures(id),
    unit_price INT NOT NULL,
    is_flash_sale BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE cart_items (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    size_id INT REFERENCES product_sizes(id),
    temperature_id INT REFERENCES product_temperatures(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

SELECT * FROM users;
SELECT * FROM user_profiles;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM product_images;
SELECT * FROM product_reviews;
SELECT * FROM promos;
SELECT * FROM promo_products;
SELECT * FROM delivery_methods;
SELECT * FROM payment_methods;
SELECT * FROM tax_rates;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM cart_items;



INSERT INTO users (id, email, password, role, created_at, updated_at) VALUES
(1, 'admin@harlanholden.com', '$2b$10$abcdefghijklmnopqrstuv', 'admin', '2025-10-15 08:00:00', '2025-10-15 08:00:00'),
(2, 'anggi@email.com', '$2b$10$abcdefghijklmnopqrstuv', 'customer', '2025-10-01 10:30:00', '2025-10-01 10:30:00'),
(3, 'prayoga@email.com', '$2b$10$abcdefghijklmnopqrstuv', 'customer', '2025-10-15 14:20:00', '2025-10-15 14:20:00'),
(4, 'raka@email.com', '$2b$10$abcdefghijklmnopqrstuv', 'customer', '2025-10-01 09:15:00', '2025-10-01 09:15:00'),
(5, 'rangga@email.com', '$2b$10$abcdefghijklmnopqrstuv', 'customer', '2025-10-10 16:45:00', '2025-10-10 16:45:00');

INSERT INTO user_profiles (id, user_id, full_name, phone, address, photo_url, created_at, updated_at) VALUES
(1, 1, 'Admin Harlan Holden', '081234567890', 'Jl. Sudirman, Jakarta Pusat', 'https://id.pinterest.com/pin/625226360811543537/', '2025-10-15 08:00:00', '2025-10-15 08:00:00'),
(2, 2, 'Anggi', '082345678901', 'Jl. Thamrin No. 123, Jakarta Pusat', 'https://id.pinterest.com/pin/295408056838997225/', '2025-10-01 10:30:00', '2025-10-01 10:30:00'),
(3, 3, 'Prayoga', '083456789012', 'Jl. Gatot Subroto No. 45, Jakarta Selatan', 'https://id.pinterest.com/pin/539235755400242280/', '2025-10-15 14:20:00', '2025-10-15 14:20:00'),
(4, 4, 'Raka', '084567890123', 'Jl. HR Rasuna Said No. 78, Jakarta Selatan', 'https://id.pinterest.com/pin/187251297001767651/', '2025-10-01 09:15:00', '2025-10-01 09:15:00'),
(5, 5, 'Rangga', '085678901234', 'Jl. Kuningan No. 90, Jakarta Selatan', 'https://id.pinterest.com/pin/238479742765437125/', '2025-10-10 16:45:00', '2025-10-10 16:45:00');

INSERT INTO categories (id, name, is_active, created_at) VALUES
(1, 'Coffee', TRUE, '2025-10-10 08:00:00'),
(2, 'Non-Coffee', TRUE, '2025-10-10 08:00:00'),
(3, 'Food', TRUE, '2025-10-10 08:00:00'),
(4, 'Addon', TRUE, '2025-10-10 08:00:00');

CREATE TABLE product_sizes (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price_adjustment INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_temperatures (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
