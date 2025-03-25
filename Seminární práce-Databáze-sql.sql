CREATE TABLE `produkt` (
  `produkt_id` integer PRIMARY KEY AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `popis` text,
  `cena` float NOT NULL,
  `kategorie_id` int,
  `na_prodej_od` datetime NOT NULL,
  `na_prodej_do` datetime
);

CREATE TABLE `kategorie` (
  `kategorie_id` integer PRIMARY KEY AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `popis` text
);

CREATE TABLE `zakaznik` (
  `zakaznik_id` integer PRIMARY KEY AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `prijmeni` varchar(255) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `heslo_hash` varchar(255) NOT NULL,
  `adresa` varchar(255),
  `mesto` varchar(255),
  `zeme` varchar(255),
  `ucet_zalozen` datetime NOT NULL
);

CREATE TABLE `objednavka` (
  `objednavka_id` integer PRIMARY KEY AUTO_INCREMENT,
  `zakaznik_id` int,
  `objednavka_vznik` datetime NOT NULL,
  `status` enum(Cekani,Poslano,Doruceno,Zruseno) NOT NULL,
  `sleva_id` int,
  `doprava_id` int,
  `celkovy_cena` float NOT NULL
);

CREATE TABLE `objednavka_polozka` (
  `objednavka_polozka_id` int PRIMARY KEY AUTO_INCREMENT,
  `objednavka_id` int,
  `produkt_id` int,
  `zakoupeny_pocet` int NOT NULL,
  `cena` float NOT NULL
);

CREATE TABLE `zaplaceni` (
  `zaplaceni_id` int PRIMARY KEY AUTO_INCREMENT,
  `objednavka_id` int,
  `cas` datetime NOT NULL,
  `cena` float NOT NULL,
  `metoda_placeni` enum(Kartou,PayPal,Prevod) NOT NULL,
  `status` enum(Cekani,Zaplaceno,Selhani)
);

CREATE TABLE `recenze` (
  `recenze_id` int PRIMARY KEY AUTO_INCREMENT,
  `zakaznik_id` int,
  `produkt_id` int,
  `hodnoceni` float NOT NULL,
  `komentar` text,
  `cas` datetime NOT NULL
);

CREATE TABLE `slevovy_kupony` (
  `sleva_id` int PRIMARY KEY AUTO_INCREMENT,
  `kod` varchar(255) UNIQUE,
  `sleva_procento` float NOT NULL,
  `datum_od` datetime NOT NULL,
  `datum_do` datetime NOT NULL,
  `aktivni` boolean
);

CREATE TABLE `seznam_prani` (
  `seznam_id` int PRIMARY KEY AUTO_INCREMENT,
  `zakaznik_id` int,
  `produkt_id` int,
  `datum_pridani` datetime
);

CREATE TABLE `doprava` (
  `doprava_id` int PRIMARY KEY AUTO_INCREMENT,
  `jmeno` varchar(255) NOT NULL,
  `cena` float,
  `dodaci_lhuta` int NOT NULL
);

CREATE TABLE `sklad` (
  `sklad_id` int PRIMARY KEY AUTO_INCREMENT,
  `lokace` varchar(255) NOT NULL,
  `produkt_id` int,
  `mnozstvi` int
);

ALTER TABLE `produkt` ADD FOREIGN KEY (`kategorie_id`) REFERENCES `kategorie` (`kategorie_id`);

ALTER TABLE `objednavka` ADD FOREIGN KEY (`zakaznik_id`) REFERENCES `zakaznik` (`zakaznik_id`);

ALTER TABLE `objednavka_polozka` ADD FOREIGN KEY (`objednavka_id`) REFERENCES `objednavka` (`objednavka_id`);

ALTER TABLE `objednavka_polozka` ADD FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`);

ALTER TABLE `zaplaceni` ADD FOREIGN KEY (`objednavka_id`) REFERENCES `objednavka` (`objednavka_id`);

ALTER TABLE `recenze` ADD FOREIGN KEY (`zakaznik_id`) REFERENCES `zakaznik` (`zakaznik_id`);

ALTER TABLE `recenze` ADD FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`);

ALTER TABLE `seznam_prani` ADD FOREIGN KEY (`zakaznik_id`) REFERENCES `zakaznik` (`zakaznik_id`);

ALTER TABLE `seznam_prani` ADD FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`);

ALTER TABLE `sklad` ADD FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`);

ALTER TABLE `objednavka` ADD FOREIGN KEY (`sleva_id`) REFERENCES `slevovy_kupony` (`sleva_id`);

ALTER TABLE `objednavka` ADD FOREIGN KEY (`doprava_id`) REFERENCES `doprava` (`doprava_id`);
