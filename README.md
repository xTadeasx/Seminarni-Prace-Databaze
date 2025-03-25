# Seminarni-Prace-Databaze
Odkaz na dbdiagram: https://dbdiagram.io/d/Seminarni-prace-Databaze-67d7d2d475d75cc84453dbe3

Odkaz na figmu: https://www.figma.com/design/c4ZMBzCSiJDCQAB7xZcShg/Untitled?node-id=0-1&t=3kehXoc3RLCtdnTn-1
  
  1 zadání:
    popis problémové domény, stanovení poslání a účelu DB, stanovení dílčích cílů a podporovaných úkolů:
  
      Popis problémové domény
        -Moderní e-commerce prostředí vyžaduje efektivní a dobře strukturované databázové systémy pro správu produktů, objednávek, zákazníků a dalších klíčových prvků online          obchodu. Tato databáze je navržena pro e-shop specializující se na prodej sběratelských Pop figurek. Hlavním cílem je zajistit spolehlivou evidenci produktů,                 objednávek, plateb a dalších funkcionalit nezbytných pro provoz e-shopu.
        
      Stanovení poslání a účelu databáze
        Hlavním účelem databáze je zajistit efektivní správu dat souvisejících s provozem e-shopu a podpořit plynulý nákupní proces. Databáze umožní:
          -Evidenci produktů, jejich kategorií a skladových zásob.
          -Správu zákaznických účtů a jejich historie objednávek.
          -Zpracování objednávek včetně detailů jednotlivých položek.
          -Evidenci plateb a jejich stavů.
          -Podporu uživatelských funkcí, jako jsou recenze, wishlisty a slevové kupóny.
          -Zajištění logistiky a dopravy objednaných produktů.
          
      Stanovení dílčích cílů a podporovaných úkolů
      1. Správa produktů
          -Umožnit přidávání, úpravu a mazání produktů. 
          -Spravovat skladové zásoby a zobrazovat dostupnost.
          -Organizovat produkty do kategorií.        
          -Umožnit nastavování cen a slev.
      2. Správa zákazníků
          -Ukládat informace o zákaznících (jméno, e-mail, adresa, atd.).
          -Zabezpečit přihlašování a správu uživatelských účtů.
          -Evidovat historii objednávek každého zákazníka.
      3. Zpracování objednávek
          -Umožnit zákazníkům vytváření objednávek.
          -Ukládat informace o zakoupených produktech v objednávce.
          -Evidovat aktuální stav objednávky (čeká na vyřízení, odesláno, doručeno, zrušeno).
      4. Správa plateb
          -Zaznamenávat platby a jejich stav (čeká na platbu, zaplaceno, selhalo, vráceno).
          -Podporovat různé platební metody (karta, PayPal, bankovní převod).
      5. Uživatelské interakce
          -Umožnit zákazníkům hodnotit produkty a psát recenze.
          -Podporovat wishlisty pro ukládání oblíbených produktů.
          -Poskytovat slevové kupóny pro zákazníky.
      6. Logistika a doprava
          -Evidovat různé možnosti dopravy a jejich ceny.
          -Uchovávat dodací lhůty jednotlivých způsobů dopravy.
2. analýza:
   
   -ER model (obrázek) se všemi atributy a specifikací integritních omezení, popis jednotlivých entit a jejich atributů (včetně jednotek, kde to dává smysl)
   
   -diagramy užití a popisy případů užití pro jednotlivé uživatelské pohledy
   
   -identifikace hlavních typů dotazů


    ![image](https://github.com/user-attachments/assets/ad0cb374-2d6d-46fd-8599-838f7fb0a707)
3. Transformace ER modelu do tabulek

   ![image](https://github.com/user-attachments/assets/b6b1b094-6d56-496d-9c95-5e9d06439bb8)
  přikrestli k "zakaznik--email" a "slevovy_kupon--kod" Unique.

  1- Integritní omezení na logické úrovni

    Referenční integrita
    
      Tabulka objednavka_polozka obsahuje sloupec produkt_id, který odkazuje na tabulku produkt, což zabraňuje přidání položky objednávky pro neexistující produkt.
      
      Sloupec objednavka_id v tabulce objednavka_polozka slouží jako cizí klíč do tabulky objednavka, což zajišťuje vazbu každé položky k platné objednávce.
      
    Unikátnost a povinná pole
    
      Sloupec email v tabulce zakaznik je unikátní, čímž se eliminuje možnost duplicitních registrací.
      
      Sloupec kod v tabulce slevovy_kupony je rovněž unikátní, což zamezuje chybám při uplatňování slev.
      
    Validace datových vazeb
    
      Sloupec hodnoceni v tabulce recenze obsahuje hodnoty v rozmezí 1-5, čímž se zajišťuje smysluplnost hodnocení.
      
      Sloupec metoda_plateni v tabulce zaplaceni je definován jako ENUM (Kartou, PayPal, Převod), což omezuje možnosti platby na stanovené varianty.
    
  2- Integritní omezení na fyzické úrovni

    Primární a cizí klíče
    
      Každá tabulka obsahuje primární klíč (_id), který zajišťuje jednoznačnou identifikaci každého záznamu.
      
      Cizí klíče zajišťují integritu vztahů mezi tabulkami (např. produkt_id v tabulce sklad).
    
    Indexy pro optimalizaci vyhledávání
    
      Sloupec email v tabulce zakaznik je indexován pro rychlejší vyhledávání uživatelů.
      
      Sloupec produkt_id v tabulce objednavka_polozka je indexován pro optimalizaci dotazů na objednávkové položky.
      
    Triggery
    
      Automatická aktualizace dostupnosti produktu ve skladu po vytvoření objednávky.
  
  3- Speciální konstrukty
  
    ENUM pro statusy a metody platby
    
      Sloupec status v tabulce objednavka obsahuje ENUM hodnoty (Cekani, Poslano, Doruceno, Zruseno), čímž se omezuje množina možných stavů objednávky.
    
    Datumová omezení
    
      Sloupce datum_od a datum_do v tabulce slevovy_kupony určují platnost kuponu a musí splňovat podmínku, že datum_do je větší než datum_od.
