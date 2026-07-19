# SQL Midweek Assignment - Sunrise Supermarket Practice Project

**Name:** Lydia
**Date:** 19/07/2026
**Database:** PostgreSQL

## Project Scenario

Sunrise Supermarket needed their records moved into a proper relational database. This project builds the database from scratch: designing and creating the tables, loading in starter data, and writing queries to answer real questions about customers, orders, and products.

## What this covers

- **Part 1 - Creating & Altering Tables:** built the `customers`, `products`, `orders`, and `order_items` tables from scratch with appropriate primary keys, foreign keys, and constraints (`UNIQUE`, `NOT NULL`, `DEFAULT`, `CHECK`), then applied structural changes (renaming a column, adding a new column, widening a column type).
- **Part 2 - Inserting & Changing Data:** inserted all starter data into the four tables, then applied an `UPDATE` and a `DELETE` (including handling the foreign key relationship before deleting a parent row).
- **Part 3 - Filtering & Operators:** queries using comparison operators, `BETWEEN`, `IN`, and `LIKE`, plus `ORDER BY` with `LIMIT`.
- **Part 4 - Grouping & Aggregates:** `GROUP BY` with `COUNT`, and `HAVING` to filter grouped results.
- **Part 5 - JOINS:** `INNER JOIN` and `LEFT JOIN` across two, then all four, tables, including a `GROUP BY` on the full four-table join.

## Files

- `lydia_sunrise_supermarket.sql` - all table creation, data loading, and queries (Tasks 1-27), in order, each with a short comment above it.

## Key takeaway

A `LEFT JOIN` keeps rows with no match on the other side (e.g. an order with no items still shows up, with `NULL` for quantity), while an `INNER JOIN` would silently hide it.
