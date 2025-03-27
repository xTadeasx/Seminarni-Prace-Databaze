-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS "e-shop";
CREATE DATABASE "e-shop";
\c "e-shop";

-- Drop all tables if they exist
DROP TABLE IF EXISTS "sklad" CASCADE;
DROP TABLE IF EXISTS "seznam_prani" CASCADE;
DROP TABLE IF EXISTS "recenze" CASCADE;
DROP TABLE IF EXISTS "zaplaceni" CASCADE;
DROP TABLE IF EXISTS "objednavka_polozka" CASCADE;
DROP TABLE IF EXISTS "objednavka" CASCADE;
DROP TABLE IF EXISTS "doprava" CASCADE;
DROP TABLE IF EXISTS "slevovy_kupony" CASCADE;
DROP TABLE IF EXISTS "zakaznik" CASCADE;
DROP TABLE IF EXISTS "produkt" CASCADE;
DROP TABLE IF EXISTS "kategorie" CASCADE;

-- Drop ENUM types if they exist
DROP TYPE IF EXISTS status_enum CASCADE;
DROP TYPE IF EXISTS payment_enum CASCADE;
DROP TYPE IF EXISTS payment_status_enum CASCADE;

-- Create ENUM types for PostgreSQL
CREATE TYPE status_enum AS ENUM ('Cekani', 'Poslano', 'Doruceno', 'Zruseno');
CREATE TYPE payment_enum AS ENUM ('Kartou', 'PayPal', 'Prevod');
CREATE TYPE payment_status_enum AS ENUM ('Cekani', 'Zaplaceno', 'Selhani');

CREATE TABLE "kategorie" (
  "kategorie_id" SERIAL PRIMARY KEY,
  "jmeno" VARCHAR(255) NOT NULL,
  "popis" TEXT
);

CREATE TABLE "produkt" (
  "produkt_id" SERIAL PRIMARY KEY,
  "jmeno" VARCHAR(255) NOT NULL,
  "popis" TEXT,
  "cena" NUMERIC(10,2) NOT NULL,
  "kategorie_id" INT,
  "na_prodej_od" TIMESTAMP NOT NULL,
  "na_prodej_do" TIMESTAMP,
  FOREIGN KEY ("kategorie_id") REFERENCES "kategorie" ("kategorie_id") ON DELETE SET NULL
);

CREATE TABLE "zakaznik" (
  "zakaznik_id" SERIAL PRIMARY KEY,
  "jmeno" VARCHAR(255) NOT NULL,
  "prijmeni" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) UNIQUE NOT NULL,
  "heslo_hash" VARCHAR(255) NOT NULL,
  "adresa" VARCHAR(255),
  "mesto" VARCHAR(255),
  "zeme" VARCHAR(255),
  "ucet_zalozen" TIMESTAMP NOT NULL
);

CREATE TABLE "slevovy_kupony" (
  "sleva_id" SERIAL PRIMARY KEY,
  "kod" VARCHAR(255) UNIQUE,
  "sleva_procento" NUMERIC(5,2) NOT NULL,
  "datum_od" TIMESTAMP NOT NULL,
  "datum_do" TIMESTAMP NOT NULL,
  "aktivni" BOOLEAN
);

CREATE TABLE "doprava" (
  "doprava_id" SERIAL PRIMARY KEY,
  "jmeno" VARCHAR(255) NOT NULL,
  "cena" NUMERIC(10,2),
  "dodaci_lhuta" INT NOT NULL
);

CREATE TABLE "objednavka" (
  "objednavka_id" SERIAL PRIMARY KEY,
  "zakaznik_id" INT,
  "objednavka_vznik" TIMESTAMP NOT NULL,
  "status" status_enum NOT NULL,
  "sleva_id" INT,
  "doprava_id" INT,
  "celkovy_cena" NUMERIC(10,2) NOT NULL,
  FOREIGN KEY ("zakaznik_id") REFERENCES "zakaznik" ("zakaznik_id") ON DELETE CASCADE,
  FOREIGN KEY ("sleva_id") REFERENCES "slevovy_kupony" ("sleva_id") ON DELETE SET NULL,
  FOREIGN KEY ("doprava_id") REFERENCES "doprava" ("doprava_id") ON DELETE SET NULL
);

CREATE TABLE "objednavka_polozka" (
  "objednavka_polozka_id" SERIAL PRIMARY KEY,
  "objednavka_id" INT,
  "produkt_id" INT,
  "zakoupeny_pocet" INT NOT NULL,
  "cena" NUMERIC(10,2) NOT NULL,
  FOREIGN KEY ("objednavka_id") REFERENCES "objednavka" ("objednavka_id") ON DELETE CASCADE,
  FOREIGN KEY ("produkt_id") REFERENCES "produkt" ("produkt_id") ON DELETE CASCADE
);

CREATE TABLE "zaplaceni" (
  "zaplaceni_id" SERIAL PRIMARY KEY,
  "objednavka_id" INT,
  "cas" TIMESTAMP NOT NULL,
  "cena" NUMERIC(10,2) NOT NULL,
  "metoda_placeni" payment_enum NOT NULL,
  "status" payment_status_enum NOT NULL,
  FOREIGN KEY ("objednavka_id") REFERENCES "objednavka" ("objednavka_id") ON DELETE CASCADE
);

CREATE TABLE "recenze" (
  "recenze_id" SERIAL PRIMARY KEY,
  "zakaznik_id" INT,
  "produkt_id" INT,
  "hodnoceni" NUMERIC(3,2) NOT NULL CHECK ("hodnoceni" BETWEEN 0 AND 5),
  "komentar" TEXT,
  "cas" TIMESTAMP NOT NULL,
  FOREIGN KEY ("zakaznik_id") REFERENCES "zakaznik" ("zakaznik_id") ON DELETE CASCADE,
  FOREIGN KEY ("produkt_id") REFERENCES "produkt" ("produkt_id") ON DELETE CASCADE
);

CREATE TABLE "seznam_prani" (
  "seznam_id" SERIAL PRIMARY KEY,
  "zakaznik_id" INT,
  "produkt_id" INT,
  "datum_pridani" TIMESTAMP,
  FOREIGN KEY ("zakaznik_id") REFERENCES "zakaznik" ("zakaznik_id") ON DELETE CASCADE,
  FOREIGN KEY ("produkt_id") REFERENCES "produkt" ("produkt_id") ON DELETE CASCADE
);

CREATE TABLE "sklad" (
  "sklad_id" SERIAL PRIMARY KEY,
  "lokace" VARCHAR(255) NOT NULL,
  "produkt_id" INT,
  "mnozstvi" INT,
  FOREIGN KEY ("produkt_id") REFERENCES "produkt" ("produkt_id") ON DELETE CASCADE
);
