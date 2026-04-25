USE vehicle_rental_db;

-- Default admin account (password: Admin@123)
INSERT INTO users (full_name, email, password_hash, phone, license_number, role)
VALUES ('System Admin', 'admin@urbandrive.com', '$2a$10$MmiJTbYKmeFFs2zmOIduUeHsVze8ODtJ09P0CUUNuYoqg6g5i55tS', '9800000000', 'LIC-ADMIN-001', 'ADMIN');
