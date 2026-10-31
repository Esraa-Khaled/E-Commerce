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

### 1- Entities
- Customer : Represents registered users who can browse products and place orders.
- Category : Organizes products into categories and subcategories.
- Product : Represents items available for sale in the e-commerce store.
- Order : Represents a customer's purchase transaction, including ordered products, quantities, and total cost.
- Order Details : To store detailed information about customer orders
