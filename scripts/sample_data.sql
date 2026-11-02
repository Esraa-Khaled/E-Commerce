-- =====================================================
-- 1. CATEGORY
-- =====================================================

INSERT INTO category (name)
VALUES
    ('Beauty'),
    ('Fashion'),
    ('Sports');

-- =====================================================
-- 2. PRODUCT
-- =====================================================

INSERT INTO product (
    category_id,
    name,
    description,
    price,
    stock_quantity
)
VALUES
    -- BEAUTY
    (1, 'Vitamin C Serum', 'Brightening facial serum', 450.00, 40),
    (1, 'Sunscreen SPF 50', 'Daily broad-spectrum sun protection', 350.00, 60),
    (1, 'Moisturizer', 'Hydrating face moisturizer', 280.00, 50),
    (1, 'Facial Cleanser', 'Gentle daily facial cleanser', 220.00, 70),
    (1, 'Makeup Foundation', 'Long-lasting liquid foundation', 550.00, 30),
    (1, 'Luxury Perfume', 'Floral eau de parfum', 1200.00, 20),

    -- FASHION
    (2, 'Women T-Shirt', 'Cotton casual T-shirt', 350.00, 45),
    (2, 'Classic Jeans', 'High-waist regular fit jeans', 850.00, 35),
    (2, 'Casual Sneakers', 'Everyday casual sneakers', 1500.00, 25),
    (2, 'Leather Handbag', 'Elegant everyday handbag', 1100.00, 18),
    (2, 'Men Hoodie', 'Comfortable cotton hoodie', 950.00, 30),
    (2, 'Sunglasses', 'UV-protection sunglasses', 650.00, 40),

    -- SPORTS
    (3, 'Yoga Mat', 'Non-slip exercise yoga mat', 400.00, 50),
    (3, 'Dumbbell Set', 'Adjustable home workout dumbbells', 1800.00, 15),
    (3, 'Sports Water Bottle', 'Reusable 1-liter bottle', 180.00, 80),
    (3, 'Running Shoes', 'Lightweight running shoes', 2000.00, 20),
    (3, 'Resistance Bands', 'Resistance bands workout set', 250.00, 55),
    (3, 'Gym Bag', 'Spacious sports gym bag', 750.00, 25);

-- =====================================================
-- 3. CUSTOMER
-- =====================================================

INSERT INTO customer (
    first_name,
    last_name,
    email,
    password
)
VALUES
    ('Mariam', 'Ahmed', 'mariam.ahmed@example.com', 'hash_001'),
    ('Omar', 'Hassan', 'omar.hassan@example.com', 'hash_002'),
    ('Salma', 'Khaled', 'salma.khaled@example.com', 'hash_003'),
    ('Youssef', 'Ali', 'youssef.ali@example.com', 'hash_004'),
    ('Nour', 'Mohamed', 'nour.mohamed@example.com', 'hash_005'),
    ('Adam', 'Mahmoud', 'adam.mahmoud@example.com', 'hash_006'),
    ('Farida', 'Samir', 'farida.samir@example.com', 'hash_007'),
    ('Karim', 'Tarek', 'karim.tarek@example.com', 'hash_008');

-- =====================================================
-- 4. ORDERS
-- =====================================================

INSERT INTO orders (
    customer_id,
    order_date,
    total_amount
)
VALUES
    -- Mariam: 3 orders
    (1, '2026-09-02 10:00:00', 730.00),
    (1, '2026-09-12 14:30:00', 1200.00),
    (1, '2026-10-05 11:15:00', 1500.00),

    -- Omar: 2 orders
    (2, '2026-09-08 12:00:00', 2000.00),
    (2, '2026-10-15 16:00:00', 1800.00),

    -- Salma: 2 orders
    (3, '2026-09-20 09:45:00', 1280.00),
    (3, '2026-10-20 13:20:00', 750.00),

    -- Youssef: 1 order
    (4, '2026-10-01 15:00:00', 3500.00),

    -- Nour: 2 orders
    (5, '2026-10-10 10:30:00', 900.00),
    (5, '2026-10-25 18:00:00', 950.00),

    -- Adam: 1 order
    (6, '2026-10-28 12:30:00', 1550.00),

    -- Farida: 1 order
    (7, '2026-11-01 12:00:00', 830.00);

-- =====================================================
-- 5. ORDER_DETAILS
-- =====================================================

INSERT INTO order_details (
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
    -- Order 1: Mariam (Beauty)
    (1, 1, 1, 450.00),
    (1, 2, 1, 280.00),

    -- Order 2: Mariam (Beauty)
    (2, 6, 1, 1200.00),

    -- Order 3: Mariam (Fashion)
    (3, 9, 1, 1500.00),

    -- Order 4: Omar (Sports)
    (4, 16, 1, 2000.00),

    -- Order 5: Omar (Sports)
    (5, 14, 1, 1800.00),

    -- Order 6: Salma (Beauty + Fashion)
    (6, 5, 1, 550.00),
    (6, 7, 1, 350.00),
    (6, 4, 1, 220.00),
    (6, 3, 1, 160.00),

    -- Order 7: Salma (Sports)
    (7, 18, 1, 750.00),

    -- Order 8: Youssef (Fashion + Sports)
    (8, 10, 1, 1100.00),
    (8, 11, 1, 950.00),
    (8, 12, 1, 650.00),
    (8, 15, 1, 180.00),
    (8, 13, 1, 400.00),
    (8, 17, 1, 220.00),

    -- Order 9: Nour (Beauty)
    (9, 1, 2, 450.00),

    -- Order 10: Nour (Fashion)
    (10, 11, 1, 950.00),

    -- Order 11: Adam (Beauty + Fashion)
    (11, 2, 1, 350.00),
    (11, 6, 1, 1200.00),

    -- Order 12: Farida (Beauty + Sports)
    (12, 3, 1, 280.00),
    (12, 13, 1, 400.00),
    (12, 15, 1, 150.00);
