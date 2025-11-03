CREATE TABLE promo_products (
    id INT PRIMARY KEY,
    promo_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (promo_id) REFERENCES promos(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);