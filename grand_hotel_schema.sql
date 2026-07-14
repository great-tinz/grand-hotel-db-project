CREATE DATABASE grand_hotel_db;
USE grand_hotel_db;

CREATE TABLE guest(
guest_id INT AUTO_INCREMENT NOT NULL,
full_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone_number VARCHAR(15) NOT NULL,
CONSTRAINT pk_guest PRIMARY KEY (guest_id),
CONSTRAINT uk_guest_email UNIQUE (email)
)
ENGINE=InnoDB AUTO_INCREMENT = 1000;

CREATE TABLE room(
room_id VARCHAR(50) NOT NULL,
assigned_category VARCHAR(50) NOT NULL,
assigned_daily_rate DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_room PRIMARY KEY (room_id),
CONSTRAINT chk_room_category CHECK (assigned_category IN ('Deluxe','Standard','Suite'))
);

CREATE TABLE booking(
booking_id INT AUTO_INCREMENT NOT NULL,
check_in_date DATE NOT NULL,
check_out_date DATE NOT NULL,
guest_id INT NOT NULL,
CONSTRAINT pk_booking PRIMARY KEY (booking_id),
CONSTRAINT fk_guest_booking FOREIGN KEY (guest_id) REFERENCES guest(guest_id)
)
ENGINE=InnoDB AUTO_INCREMENT = 5000;

CREATE TABLE room_booked(
booking_id INT NOT NULL,
room_id  VARCHAR(50) NOT NULL,
CONSTRAINT pk_room_booked PRIMARY KEY (booking_id,room_id),
CONSTRAINT fk_room_booked_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
CONSTRAINT fk_room_booked_room_id FOREIGN KEY (room_id) REFERENCES room(room_id)
);

CREATE TABLE payment(
payment_id INT AUTO_INCREMENT NOT NULL,
payment_date DATE NOT NULL,
amount_paid DECIMAL(10,2) NOT NULL,
booking_id INT NOT NULL,
CONSTRAINT pk_payment_id PRIMARY KEY (payment_id),
CONSTRAINT uk_payment_booking UNIQUE (booking_id),
CONSTRAINT fk_payment_booking_id FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
)
ENGINE=InnoDB AUTO_INCREMENT = 9000;

INSERT INTO guest (full_name,email,phone_number)
VALUES ('Ahiati Emmanuel','ahiatiemma@gmail.com','0531154310'),
	   ('Amonoo Edmond','edmondamonoo@gmail.com','0240537537');
       
INSERT INTO room (room_id,assigned_category,assigned_daily_rate)
	VALUES ('A1001','Standard','100.00'),
		   ('A1002','Deluxe','200.00'),
           ('A1003','Suite', '500.00');
           
INSERT INTO booking(check_in_date,check_out_date,guest_id)
		VALUES ('2026-07-08','2026-07-09',1000),
			   ('2026-07-10','2026-07-12',1001);
               
SELECT * FROM booking;

INSERT INTO room_booked(booking_id,room_id)
VALUES (5000,'A1001'),
	   (5001,'A1001');
           
INSERT INTO payment(payment_date,amount_paid,booking_id)
VALUES ('2026-07-08','100.00',5000);

SELECT * FROM payment;
USE grand_hotel_db;
SELECT * FROM guest;

SELECT full_name, phone_number FROM guest;
SELECT booking_id FROM booking WHERE guest_id='1001' AND check_in_date='2026-07-10';

SELECT SUM(amount_paid) AS total_revenue FROM payment;

SELECT COUNT(guest_id) AS current_total_guest FROM guest;

SELECT AVG(assigned_daily_rate) AS average_guest_room FROM room;
SELECT assigned_category, AVG(assigned_daily_rate) AS average_rate 
FROM room
GROUP BY assigned_category;

SELECT guest.full_name, booking.booking_id FROM guest INNER JOIN booking ON guest.guest_id = booking.guest_id; 

SELECT guest.full_name, booking.booking_id,payment.amount_paid FROM guest INNER JOIN booking ON guest.guest_id = booking.guest_id 
INNER JOIN payment ON payment.booking_id = booking.booking_id;

SELECT guest.full_name, booking.booking_id 
FROM guest 
LEFT JOIN booking
ON guest.guest_id = booking.guest_id;

SELECT guest_id, COUNT(booking_id) AS VIPS
FROM booking
GROUP BY guest_id
HAVING COUNT(booking_id) >= 1;
