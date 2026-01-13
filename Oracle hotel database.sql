CONN manager/manager123;

CREATE TABLE clients (
id NUMBER PRIMARY KEY,
nom VARCHAR2(50),
email VARCHAR2(100)
) TABLESPACE hotel_data;

CREATE TABLE hotels (
id NUMBER PRIMARY KEY,
nom VARCHAR2(50),
ville VARCHAR2(50)
) TABLESPACE hotel_data;

CREATE TABLE chambres (
id NUMBER PRIMARY KEY,
hotel_id NUMBER,
numero VARCHAR2(10),
prix NUMBER,
FOREIGN KEY (hotel_id) REFERENCES hotels(id)
) TABLESPACE hotel_data;

CREATE TABLE reservations (
id NUMBER PRIMARY KEY,
client_id NUMBER,
chambre_id NUMBER,
date_debut DATE,
date_fin DATE,
FOREIGN KEY (client_id) REFERENCES clients(id),
FOREIGN KEY (chambre_id) REFERENCES chambres(id)
) TABLESPACE hotel_data;

CREATE TABLE paiements (
id NUMBER PRIMARY KEY,
reservation_id NUMBER,
montant NUMBER,
date_paiement DATE,
FOREIGN KEY (reservation_id) REFERENCES reservations(id)
) TABLESPACE hotel_data;

-- CRUD
INSERT INTO clients VALUES (1,'Ali','ali@mail.com');
SELECT * FROM clients;
UPDATE clients SET nom='Ali Ben' WHERE id=1;
DELETE FROM clients WHERE id=1;

-- Hôtels les plus visités
SELECT h.nom, COUNT(*) 
FROM hotels h JOIN chambres c ON h.id=c.hotel_id
JOIN reservations r ON c.id=r.chambre_id
GROUP BY h.nom;

-- Chambres disponibles
SELECT c.id FROM chambres c
WHERE c.id NOT IN (
SELECT chambre_id FROM reservations
WHERE SYSDATE BETWEEN date_debut AND date_fin
);
