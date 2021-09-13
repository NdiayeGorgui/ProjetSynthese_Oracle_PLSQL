--Insertion de donnees dans la table produits
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT lenom PROMPT "Entrer le nom: "
ACCEPT laquantite PROMPT "Entrer la quantite Stock: "
ACCEPT leprix PROMPT "Entrer le prix: "


BEGIN
	INSERT INTO produits(numProd,nom,quantiteStock,prix) 
	VALUES('P'||seq_prod_gr408.NEXTVAL,'&lenom','&laquantite','&leprix');
	
	
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Insertion de Produits reussi!');
	DBMS_OUTPUT.PUT_LINE('Liste des produits');
			DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO PRODUIT',20)||RPAD('NOM PRODUIT',20)||RPAD('QUANTITE',20)||RPAD('PRIX',20));
			FOR Liste IN (SELECT  * FROM PRODUITS ) LOOP
			DBMS_OUTPUT.PUT_LINE(rpad(Liste.numProd,20)||rpad(Liste.nom,20)||rpad(Liste.quantiteStock,20)||rpad(Liste.prix,20));
			END LOOP;
EXCEPTION
--Utilisation de l'exception dup_val_on_index predefinie
	WHEN dup_val_on_index THEN
		DBMS_OUTPUT.PUT_LINE('Le numero Produit existe deja!');
	
END;
/
SET VERIFY ON
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\INSERTION.sql
