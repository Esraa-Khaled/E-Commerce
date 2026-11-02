
-- =====================================================
-- 1. CUSTOMER
-- =====================================================

CREATE TABLE IF NOT EXISTS CUSTOMER (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY,

    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,

    CONSTRAINT customer_pk PRIMARY KEY (customer_id)
);


-- =====================================================
-- 2. CATEGORY
-- =====================================================

CREATE TABLE IF NOT EXISTS CATEGORY (
    category_id BIGINT GENERATED ALWAYS AS IDENTITY,

    name VARCHAR(100) NOT NULL UNIQUE,

    CONSTRAINT category_pk PRIMARY KEY (category_id)
);


-- =====================================================
-- 3. PRODUCT
-- =====================================================

CREATE TABLE IF NOT EXISTS PRODUCT (
    product_id BIGINT GENERATED ALWAYS AS IDENTITY,

    category_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,

    price NUMERIC(10, 2) NOT NULL
        CHECK (price > 0),

    stock_quantity INTEGER NOT NULL DEFAULT 0
        CHECK (stock_quantity >= 0),

    CONSTRAINT product_pk PRIMARY KEY (product_id),

    CONSTRAINT product_category_fk
        FOREIGN KEY (category_id)
        REFERENCES CATEGORY(category_id)
        ON DELETE RESTRICT
);


-- =====================================================
-- 4. ORDERS
-- =====================================================

CREATE TABLE IF NOT EXISTS ORDERS (
    order_id BIGINT GENERATED ALWAYS AS IDENTITY,

    customer_id BIGINT NOT NULL,
    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    total_amount NUMERIC(10, 2) NOT NULL DEFAULT 0
        CHECK (total_amount >= 0),

    CONSTRAINT orders_pk PRIMARY KEY (order_id),

    CONSTRAINT orders_customer_fk
        FOREIGN KEY (customer_id)
        REFERENCES CUSTOMER(customer_id)
        ON DELETE RESTRICT
);


-- =====================================================
-- 5. ORDER_DETAILS
-- =====================================================

CREATE TABLE IF NOT EXISTS ORDER_DETAILS (
    order_detail_id BIGINT GENERATED ALWAYS AS IDENTITY,

    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,

    quantity INTEGER NOT NULL
        CHECK (quantity > 0),

    unit_price NUMERIC(10, 2) NOT NULL
        CHECK (unit_price > 0),

    CONSTRAINT order_detail_pk PRIMARY KEY (order_detail_id),

    CONSTRAINT order_details_order_fk
        FOREIGN KEY (order_id)
        REFERENCES ORDERS(order_id),

    CONSTRAINT order_details_product_fk
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT order_product_uq UNIQUE (order_id, product_id)
);
