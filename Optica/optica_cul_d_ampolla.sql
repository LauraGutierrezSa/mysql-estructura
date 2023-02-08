CREATE DATABASE IF NOT EXISTS cul_d_ampolla;

USE cul_d_ampolla;

CREATE TABLE IF NOT EXISTS providers (
  provider_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  number VARCHAR(10) NOT NULL,
  floor VARCHAR(10),
  city VARCHAR(50) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  country VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  fax_number VARCHAR(20),
  nif VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS eyeglasses (
  eyeglasses_id INT AUTO_INCREMENT PRIMARY KEY,
  brand VARCHAR(100) NOT NULL,
  graduation_left FLOAT NOT NULL,
  graduation_right FLOAT NOT NULL,
  frame_type ENUM('floating', 'paste', 'metallic') NOT NULL,
  frame_color VARCHAR(20) NOT NULL,
  glass_color_left VARCHAR(20) NOT NULL,
  glass_color_right VARCHAR(20) NOT NULL,
  price FLOAT NOT NULL,
  provider_id INT NOT NULL,
  FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

CREATE TABLE IF NOT EXISTS clients (
  client_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  number VARCHAR(10) NOT NULL,
  floor VARCHAR(10),
  city VARCHAR(50) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  country VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  registry_date DATE NOT NULL,
  recommender_id INT,
  FOREIGN KEY (recommender_id) REFERENCES clients(client_id)
);

CREATE TABLE IF NOT EXISTS sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  eyeglasses_id INT NOT NULL,
  employee_id INT NOT NULL,
  sale_date DATE NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (eyeglasses_id) REFERENCES eyeglasses(eyeglasses_id),
  FOREIGN KEY (employee_id) references EMPLOYEES(employee_id)
);

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  last_name VARCHAR(15) NOT NULL
);

INSERT INTO clients (name, street, number, floor, city, zip_code, country, phone_number, email, registry_date) VALUES ('Nuria', 'Nou de la Rambla','123','14','Barcelona','08027','Spain', '700065487', 'email@email.com', '05-10-21');
INSERT INTO clients (name, street, number, floor, city, zip_code, country, phone_number, email, registry_date ) VALUES ('Laura', 'Av del parque','3','1','Cornella','08940','Spain', '700065487', 'email@email.com', '12-12-22');


INSERT INTO providers (name, street, number, floor, city, phone_number, zip_code, country, fax_number) VALUES ('Derp', 'ficticious street', '23', 'Barcelona', '987654321', '934527173', '08970', '82628134', '12345678B');

INSERT INTO employees (name, last_name) VALUES ('Omar', 'Olmedo');

INSERT INTO brand (name, provider) VALUES ('Nike', '2');

INSERT INTO product (brand, graduation_left, graduation_right, frame_type, frame_color, glass_color_right, glass_color_right, price, brand_id) VALUES ('nike','3.5','2.5', 'flotant', 'Red', 'Colorless', 'Colorless', '1039.25', '1' );

INSERT INTO sale (employee_id, product_id, client_id) VALUES ('1','1','1');
