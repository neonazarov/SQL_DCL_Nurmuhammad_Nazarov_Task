-- 1. Create a new user "rentaluser"
CREATE USER rentaluser WITH PASSWORD 'rentalpassword';

-- 2. Grant permissions to connect to the "dvd_rental" database and SELECT on "customer" table
GRANT CONNECT ON DATABASE dvd_rental TO rentaluser;
GRANT USAGE ON SCHEMA public TO rentaluser;
GRANT SELECT ON customer TO rentaluser;

-- 3. Create a new user group "rental" and add "rentaluser" to this group
CREATE ROLE rental;
GRANT rental TO rentaluser;

-- 4. Grant the "rental" group INSERT and UPDATE permissions for the "rental" table
GRANT INSERT, UPDATE ON rental TO rental;

-- 5. Revoke the "rental" group's INSERT permission for the "rental" table
REVOKE INSERT ON rental FROM rental;

-- Assuming you have selected a customer, e.g., customer_id 123 for John Doe
-- 6. Create a personalized role for the customer (replace with actual first and last names)
CREATE ROLE client_john_doe NOLOGIN;

-- Grant the necessary privileges for connecting to the database and schema usage
GRANT CONNECT ON DATABASE dvd_rental TO client_john_doe;
GRANT USAGE ON SCHEMA public TO client_john_doe;

-- Enable row-level security on the "rental" and "payment" tables
ALTER TABLE rental ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment ENABLE ROW LEVEL SECURITY;

-- Create policies for accessing only specific customer data
-- Adjust the USING clause with the correct customer_id
CREATE POLICY select_rental ON rental FOR SELECT USING (customer_id = 123);
CREATE POLICY select_payment ON payment FOR SELECT USING (customer_id = 123);

-- Grant select permissions on "rental" and "payment" to the new role
GRANT SELECT ON rental, payment TO client_john_doe;
