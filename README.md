# E-Commerce
This repository demonstrates the design and implementation of a relational database for a simple E-Commerce Management System using PostgreSQL.

The project focuses on fundamental database concepts, including relational modeling, entity relationships, primary and foreign keys, integrity constraints, SQL queries, aggregation, reporting, and denormalization.

It provides a practical example of how an e-commerce database can manage customers, products, categories, and orders while maintaining data consistency and supporting business reporting requirements.

## Goal

The goal is to apply database design principles and SQL concepts to a realistic business scenario, demonstrating how a well-structured relational database supports the core operations of an e-commerce application.

## Project Objectives

The main objectives of this project are:

- Design a relational database schema for an e-commerce system.
- Identify entities, attributes, and relationships.
- Draw the Entity Relationship Diagram (ERD).
- Write SQL queries for business reporting.
- Apply normalization and denormalization techniques.

## Technologies

- **Database:** PostgreSQL
- **Language:** SQL

## Database Design

### Entities
- `CUSTOMER`: Stores customer account information.
- `CATEGORY`: Groups products into categories.
- `PRODUCT`: Stores product information and inventory.
- `ORDERS`: Represents orders placed by customers.
- `ORDER_DETAILS`: Stores the products included in each order.
____

### Relationships Between Entities

- CUSTOMER (1) → (M) ORDERS
- CATEGORY (1) → (M) PRODUCT
- ORDERS (1) → (M) ORDER_DETAILS
- PRODUCT (1) → (M) ORDER_DETAILS

> ORDER_DETAILS acts as an associative entity resolving the many-to-many relationship between ORDERS and PRODUCT.

___

### DB Schema Script

#### - Create the database schema


```
CREATE DATABASE ecommerce;
```

#### - Create tables
```

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

```
___

### Design decisions Notes
- NUMERIC(10,2) is appropriate for monetary values because it avoids floating-point rounding errors.
- unit_price stores the product price at the time of purchase. If the product price changes later, historical orders remain correct.
- total_amount is stored in orders as an order-level total. It should be calculated from the order details and maintained consistently.
- password should contain a securely hashed password, never a plaintext password.

___
### Recommended indexes

```
CREATE INDEX idx_product_category
    ON product(category_id);

CREATE INDEX idx_orders_customer
    ON orders(customer_id);

CREATE INDEX idx_orders_order_date
    ON orders(order_date);

CREATE INDEX idx_order_details_order
    ON order_details(order_id);

CREATE INDEX idx_order_details_product
    ON order_details(product_id);
```
____

### ERD Diagram

<img width="1151" height="512" alt="e_commerce_erd" src="https://github.com/user-attachments/assets/5a1c3913-a605-4d33-8886-fe88de1e3ad0" />

___

### Reports

#### 1. Daily Revenue Report
Requirement: Write an SQL query to generate a daily report of the total revenue for a specific date. 
```
SELECT SUM(total_amount) AS total_revenue
FROM ORDERS
WHERE order_date = :date;
```

#### 2. Monthly Top-Selling Products
Requirement: Write an SQL query to generate a monthly report of the top-selling products in a given month. 
```
SELECT p.product_id,
    p.name As product_name,
    SUM(d.quantity) As total_quantity,
    SUM(d.quantity * d.unit_price) As total_price
FROM product p
LEFT JOIN order_details d
    ON d.product_id = p.product_id 
LEFT JOIN orders o
    ON o.order_id = d.order_id
WHERE o.order_date >= :date_before AND o.order_date < :date_after
GROUP BY p.product_id, p.name
ORDER BY total_quantity DESC;
```

#### 3. Customers with More Than $500 in Orders During the Past Month
Requirement: Write a SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month.
Include customer names and their total order amounts.

```
SELECT c.customer_id,
    CONCAT(c.first_name,' ', c.last_name) As customer_name,
    SUM(o.total_amount) As total_orders_amount
FROM customer c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
WHERE o.order_date <= CURRENT_TIMESTAMP 
    AND  o.order_date >= CURRENT_TIMESTAMP - INTERVAL '1 month'
GROUP BY c.customer_id, customer_name
HAVING SUM(o.total_amount) > 500
ORDER BY total_orders_amount DESC;
```

___

### Denormalization

> How we can apply a denormalization mechanism on customer and order entities

For order entity we can combine order_details info in order_table
For customer add the number of orders and the orders
___
