-- Create a new user
CREATE USER rentaluser WITH PASSWORD 'rentalpassword';

-- Grant the user the ability to connect to the database
GRANT CONNECT ON DATABASE neo_database TO rentaluser;

-- Grant SELECT permission on 'customer' table to 'rentaluser'
GRANT SELECT ON TABLE customer TO rentaluser;

-- Create a user group 'rental' and add 'rentaluser' to the group
CREATE ROLE rental;
GRANT rental TO rentaluser;

-- Grant INSERT and UPDATE permissions on 'rental' table to 'rental' group
GRANT INSERT, UPDATE ON TABLE rental TO rental;

-- Revoke the INSERT permission from the 'rental' group for the 'rental' table
REVOKE INSERT ON TABLE rental FROM rental;


CREATE ROLE client_John_Doe WITH LOGIN PASSWORD 'unique_password';
GRANT SELECT ON TABLE rental TO client_John_Doe;
GRANT SELECT ON TABLE payment TO client_John_Doe;
ALTER TABLE rental ROW LEVEL SECURITY;
ALTER TABLE payment ROW LEVEL SECURITY;
CREATE POLICY rental_access ON rental FOR SELECT TO client_John_Doe USING (customer_id = [customer_id]);
CREATE POLICY payment_access ON payment FOR SELECT TO client_John_Doe USING (customer_id = [customer_id]);

SELECT * FROM rental WHERE customer_id = [customer_id];
SELECT * FROM payment WHERE customer_id = [customer_id];
