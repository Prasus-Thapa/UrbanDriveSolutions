USE vehicle_rental_db;

-- Default admin account (password: Admin@123)
INSERT INTO users (full_name, email, password_hash, phone, license_number, role)
VALUES ('System Admin', 'admin@urbandrive.com', '$2a$10$MmiJTbYKmeFFs2zmOIduUeHsVze8ODtJ09P0CUUNuYoqg6g5i55tS', '9800000000', 'LIC-ADMIN-001', 'ADMIN');

INSERT INTO vehicles 
(brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status)
VALUES
('Toyota', 'Corolla', 'Sedan', 'BA-12-PA-1234', 'White', 4, 4500.00, 'AVAILABLE'),
('Honda', 'CR-V', 'SUV', 'BA-14-PA-5678', 'Black', 4, 7500.00, 'AVAILABLE'),
('Suzuki', 'Swift', 'Hatchback', 'BA-16-PA-2468', 'Red', 4, 3500.00, 'AVAILABLE'),
('Hyundai', 'Tucson', 'SUV', 'BA-18-PA-1357', 'Silver', 4, 8500.00, 'AVAILABLE'),
('Toyota', 'Fortuner', 'SUV', 'BA-20-CHA-7777', 'Black', 8, 10000.00, 'AVAILABLE'),
('Toyota', 'Camry', 'Sedan', 'BA-21-PA-0000', 'Red', 4, 3000.00, 'AVAILABLE'),
('Hyundai', 'Creta', 'SUV', 'BA-4-CHA-7788', 'Red', 4, 7000.00, 'AVAILABLE'),
('Mahindra', 'Thar', 'SUV', 'BA-7-CH-9900', 'Black', 4, 8000.00, 'AVAILABLE'),
('Ford', 'Ranger', 'Pickup', 'BA-8-PA-5566', 'Orange', 6, 8500.00, 'AVAILABLE'),
('Kia', 'Seltos', 'SUV', 'BA-6-PA-6677', 'Grey', 4, 8000.00, 'AVAILABLE');
('Tesla', 'Model 3', 'Sedan', 'BA-10-EV-1111', 'White', 4, 12000.00, 'AVAILABLE'),
('BMW', 'X5', 'SUV', 'BA-11-LU-2222', 'Black', 6, 15000.00, 'AVAILABLE'),
('Mercedes', 'C-Class', 'Sedan', 'BA-13-LU-3333', 'Silver', 4, 14000.00, 'AVAILABLE'),
('Suzuki', 'Alto', 'Hatchback', 'BA-15-PA-4444', 'Blue', 4, 2500.00, 'AVAILABLE'),
('Tata', 'Nano', 'Compact', 'BA-17-PA-5555', 'Yellow', 2, 1800.00, 'AVAILABLE'),
('Nissan', 'Urvan', 'Van', 'BA-19-VA-6666', 'White', 8, 9500.00, 'AVAILABLE'),
('Jeep', 'Wrangler', 'SUV', 'BA-22-OF-7777', 'Green', 4, 13000.00, 'AVAILABLE'),
('Isuzu', 'D-Max', 'Pickup', 'BA-23-PU-8888', 'Grey', 6, 9000.00, 'AVAILABLE'),
('Audi', 'Q7', 'SUV', 'BA-24-LU-9999', 'White', 8, 17000.00, 'AVAILABLE'),
('Renault', 'Kwid', 'Hatchback', 'BA-25-PA-1010', 'Red', 4, 2800.00, 'AVAILABLE');