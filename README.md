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
    password VARCHAR(255),

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
        REFERENCES ORDERS(order_id)
        ON DELETE CASCADE,

    CONSTRAINT order_details_product_fk
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id)
        ON DELETE RESTRICT,

    CONSTRAINT order_product_uq UNIQUE (order_id, product_id)
);

```
___

### Design decisions Notes:
- NUMERIC(10,2) is appropriate for monetary values because it avoids floating-point rounding errors.
- unit_price stores the product price at the time of purchase. If the product price changes later, historical orders remain correct.
- total_amount is stored in orders as an order-level total. It should be calculated from the order details and maintained consistently.
- password should contain a securely hashed password, never a plaintext password.

___
### 
