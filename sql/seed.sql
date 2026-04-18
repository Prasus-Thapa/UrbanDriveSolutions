USE vehicle_rental_db;

INSERT INTO users (full_name, email, password_hash, phone, license_number, role)
VALUES
    ('System Admin', 'admin@urbandrive.com', '$2a$10$MmiJTbYKmeFFs2zmOIduUeHsVze8ODtJ09P0CUUNuYoqg6g5i55tS', '9800000000', 'LIC-ADMIN-001', 'ADMIN'),
    ('Sabin Shrestha', 'sabin@urbandrive.com', '$2a$10$vNynbWBzhUkka.o.xQ7tZ.Y7CMZ3XUcIe0R919hLVpuUqOtYBGhOa', '9811111111', 'LIC-CUST-001', 'CUSTOMER');

INSERT INTO vehicles (brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status)
VALUES
    ('Toyota', 'Corolla', 'Sedan', 'BA-12-PA-1234', 'White', 5, 45.00, 'BOOKED'),
    ('Honda', 'CR-V', 'SUV', 'BA-14-PA-5678', 'Black', 5, 75.00, 'AVAILABLE'),
    ('Suzuki', 'Swift', 'Hatchback', 'BA-16-PA-2468', 'Red', 5, 35.00, 'AVAILABLE'),
    ('Hyundai', 'Tucson', 'SUV', 'BA-18-PA-1357', 'Silver', 5, 85.00, 'MAINTENANCE');

INSERT INTO bookings (user_id, vehicle_id, pickup_date, return_date, total_amount, booking_status)
VALUES
    (2, 1, '2026-04-20', '2026-04-23', 135.00, 'CONFIRMED');

INSERT INTO payments (booking_id, amount, payment_method, payment_status, transaction_code)
VALUES
    (1, 135.00, 'CARD', 'PAID', 'TXN-UDS-1001');
