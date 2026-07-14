# Grand Hotel Management System - Database Project

## 📖 Overview
This is a foundational relational database project designed to streamline the daily operations and room management of a hotel. Built as a core practical assessment for **DCIT 322 (Database Management & Administration)**, this project demonstrates the complete lifecycle of database design—from understanding business requirements to creating a normalized schema, enforcing data integrity, and writing complex analytical queries.

---

## 📋 Business Scenario
The following narrative was used to drive the database design:

*"The Grand Hotel requires a comprehensive database system to streamline its daily operations and room management. The hotel features a wide variety of rooms, and for every individual room, the management tracks a unique room number, the specific category—such as a single room, double room, or luxury suite—and the assigned daily rate. Guests register at the hotel by providing a unique guest identifier, their full name, a valid email address, and a contact phone number.*

*When a guest decides to stay at the hotel, they place a booking. Each booking is assigned a unique booking identifier and must record both the scheduled check-in date and the check-out date. According to hotel policy, a single booking is always made by exactly one guest, though any registered guest can make many different bookings over time. Furthermore, a single booking can include one or multiple rooms, such as a family booking a suite and an adjacent double room together, while a specific room can be linked to many different bookings over its lifetime on different dates. Finally, every booking requires a payment for accounting purposes. The system records a unique payment identifier, the specific monetary amount paid, and the exact payment date, ensuring that each individual booking is covered by exactly one payment record."*

---

## 🧱 Database Design & Modeling

### Entity-Relationship (ER) Diagram
*(An image file named `er_diagram.png` is included in this repository to visually represent the schema below).*

### Entities, Attributes, and Relationships
- **`guest`**: Stores guest details (GuestID, Full Name, Email, Phone). 
  - *PK: `guest_id`*
- **`room`**: Stores room inventory (RoomID, Category, Daily Rate).
  - *PK: `room_id`* | *Constraint: `CHECK` on room category ('Deluxe', 'Standard', 'Suite')*
- **`booking`**: Manages reservations (BookingID, Check-in, Check-out, GuestID).
  - *PK: `booking_id`* | *FK: `guest_id` references `guest` (1 Guest : M Bookings)*
- **`room_booked`**: Junction table for the M:N relationship between bookings and rooms.
  - *PK: Composite (`booking_id`, `room_id`)* | *FKs to `booking` and `room`*
- **`payment`**: Tracks financials (PaymentID, Amount, Date, BookingID).
  - *PK: `payment_id`* | *FK: `booking_id` references `booking` (1 Booking : 1 Payment)*

---

## 💻 SQL Implementation Highlights

This project utilizes **MySQL** and demonstrates the following core SQL concepts:

1. **Data Definition Language (DDL)**:
   - Creating tables with `AUTO_INCREMENT`, `PRIMARY KEY`, and `FOREIGN KEY` constraints.
   - Implementing domain integrity using `CHECK` constraints (e.g., room categories).
   - Enforcing uniqueness using the `UNIQUE` constraint (e.g., one payment per booking).

2. **Data Manipulation Language (DML)**:
   - Inserting multiple rows of test data into related tables using `INSERT INTO`.

3. **Data Query Language (DQL)**:
   - Using `SELECT`, `WHERE`, `AND`, `IN`, `ORDER BY`, and `LIMIT` for filtering and sorting.
   - Utilizing **Aggregate Functions** (`SUM`, `COUNT`, `AVG`) to generate business insights (Total Revenue, Guest Count, Average Room Rate).
   - Implementing **Multi-Table Joins** (`INNER JOIN` across 3 tables to link Guests to Payments) and `LEFT JOIN` to capture all registered guests, even those without bookings.
   - Summarizing data with **`GROUP BY`** and filtering the results with **`HAVING`**.

---

## 🛠️ Technology Stack
- **Database Engine**: MySQL (InnoDB Engine)
- **Development Tool**: MySQL Workbench
- **Modeling Tool**: ERDPlus / Lucidchart

---

## 🚀 How to Run the Project
1. Open your MySQL Workbench or CLI.
2. Execute the `schema_and_queries.sql` script to create the `grand_hotel_db` database and all tables.
3. Run the `INSERT` statements to populate the tables with initial guest, room, and booking data.
4. Run the `SELECT` queries at the bottom of the script to observe the analytical outputs (revenue totals, group averages, and multi-table relationships).

---

## 🔮 Future Enhancements (Under Development)
- Convert the normalized schema into a **Star Schema (Fact & Dimension tables)** for Business Intelligence (DCIT 320) integration.
- Create a **Stored Procedure** to automate the booking creation and payment recording process.
- Implement **Database Triggers** to automatically update a room's "occupied" status when a booking is confirmed.

---

## 📌 Author
**Ahiati Emmanuel**  
*BSc. Information Technology Student, Ghanaian University*  
*Focus: Database Administration & Business Intelligence*
