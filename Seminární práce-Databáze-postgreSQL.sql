-- Insert into kategorie
INSERT INTO "kategorie" ("jmeno", "popis") VALUES 
('Elektronika', 'Všechny druhy elektronických zařízení'),
('Kuchyně', 'Vybavení pro vaši kuchyni'),
('Obuv', 'Pohodlné a stylové boty');

-- Insert into produkt
INSERT INTO "produkt" ("jmeno", "popis", "cena", "kategorie_id", "na_prodej_od", "na_prodej_do") VALUES
('Notebook', 'Výkonný notebook pro práci a zábavu', 15000.00, 1, '2025-03-25 00:00:00', '2025-06-25 00:00:00'),
('Mikrovlnná trouba', 'Moderní mikrovlnná trouba s grilem', 3000.00, 2, '2025-03-25 00:00:00', '2025-06-25 00:00:00'),
('Kožené boty', 'Stylové kožené boty pro každodenní nošení', 2000.00, 3, '2025-03-25 00:00:00', '2025-06-25 00:00:00');

-- Insert into zakaznik
INSERT INTO "zakaznik" ("jmeno", "prijmeni", "email", "heslo_hash", "adresa", "mesto", "zeme", "ucet_zalozen") VALUES
('Jan', 'Novák', 'jan.novak@example.com', 'hashed_password_1', 'Hlavní 123', 'Praha', 'Česká republika', '2025-03-25 00:00:00'),
('Petr', 'Svoboda', 'petr.svoboda@example.com', 'hashed_password_2', 'Ulice 456', 'Brno', 'Česká republika', '2025-03-25 00:00:00');

-- Insert into slevovy_kupony
INSERT INTO "slevovy_kupony" ("kod", "sleva_procento", "datum_od", "datum_do", "aktivni") VALUES
('SLEVA10', 10.00, '2025-03-25 00:00:00', '2025-04-25 00:00:00', TRUE),
('SLEVA20', 20.00, '2025-03-25 00:00:00', '2025-04-25 00:00:00', TRUE);

-- Insert into doprava
INSERT INTO "doprava" ("jmeno", "cena", "dodaci_lhuta") VALUES
('Doprava standardní', 100.00, 5),
('Doprava expres', 200.00, 2);

-- Insert into objednavka
INSERT INTO "objednavka" ("zakaznik_id", "objednavka_vznik", "status", "sleva_id", "doprava_id", "celkovy_cena") VALUES
(1, '2025-03-25 10:00:00', 'Cekani', 1, 1, 14500.00),
(2, '2025-03-25 11:00:00', 'Poslano', 2, 2, 3600.00);

-- Insert into objednavka_polozka
INSERT INTO "objednavka_polozka" ("objednavka_id", "produkt_id", "zakoupeny_pocet", "cena") VALUES
(1, 1, 1, 15000.00),
(2, 2, 1, 3000.00);

-- Insert into zaplaceni
INSERT INTO "zaplaceni" ("objednavka_id", "cas", "cena", "metoda_placeni", "status") VALUES
(1, '2025-03-25 10:30:00', 14500.00, 'Kartou', 'Zaplaceno'),
(2, '2025-03-25 11:30:00', 3000.00, 'PayPal', 'Zaplaceno');

-- Insert into recenze
INSERT INTO "recenze" ("zakaznik_id", "produkt_id", "hodnoceni", "komentar", "cas") VALUES
(1, 1, 4.5, 'Skvělý notebook, velmi spokojený.', '2025-03-25 12:00:00'),
(2, 2, 4.0, 'Dobrá mikrovlnná trouba, trochu hlučná.', '2025-03-25 12:30:00');

-- Insert into seznam_prani
INSERT INTO "seznam_prani" ("zakaznik_id", "produkt_id", "datum_pridani") VALUES
(1, 2, '2025-03-25 12:00:00'),
(2, 3, '2025-03-25 12:30:00');

-- Insert into sklad
INSERT INTO "sklad" ("lokace", "produkt_id", "mnozstvi") VALUES
('Sklad A', 1, 50),
('Sklad B', 2, 30),
('Sklad C', 3, 100);
