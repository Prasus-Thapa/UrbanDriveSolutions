USE vehicle_rental_db;

CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       phone VARCHAR(20) NOT NULL UNIQUE,
                       license_number VARCHAR(50) NOT NULL UNIQUE,
                       role ENUM('ADMIN', 'CUSTOMER') NOT NULL DEFAULT 'CUSTOMER',
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vehicles (
                          vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
                          brand VARCHAR(50) NOT NULL,
                          model VARCHAR(50) NOT NULL,
                          vehicle_type VARCHAR(30) NOT NULL,
                          registration_number VARCHAR(30) NOT NULL UNIQUE,
                          color VARCHAR(30) NOT NULL,
                          seats INT NOT NULL,
                          price_per_day DECIMAL(10, 2) NOT NULL,
                          availability_status ENUM('AVAILABLE', 'BOOKED', 'MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bookings (
                          booking_id INT PRIMARY KEY AUTO_INCREMENT,
                          user_id INT NOT NULL,
                          vehicle_id INT NOT NULL,
                          pickup_date DATE NOT NULL,
                          return_date DATE NOT NULL,
                          total_amount DECIMAL(10, 2) NOT NULL,
                          booking_status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') NOT NULL DEFAULT 'PENDING',
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(user_id),
                          CONSTRAINT fk_bookings_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE payments (
                          payment_id INT PRIMARY KEY AUTO_INCREMENT,
                          booking_id INT NOT NULL,
                          amount DECIMAL(10, 2) NOT NULL,
                          payment_method ENUM('CASH', 'CARD', 'ESEWA', 'BANK_TRANSFER') NOT NULL,
                          payment_status ENUM('PENDING', 'PAID', 'FAILED') NOT NULL DEFAULT 'PENDING',
                          transaction_code VARCHAR(100),
                          payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          CONSTRAINT fk_payments_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
