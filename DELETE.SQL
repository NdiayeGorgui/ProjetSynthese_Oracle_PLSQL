SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER triggerdelete_produits
AFTER DELETE ON produits
FOR EACH ROW



BEGIN
   DBMS_OUTPUT.PUT_LINE('Suppression en cascade de : ' ||:OLD.numProd);
	--stockage du produit avant suppression definitiVe
 INSERT INTO PRODCHIP SELECT * FROM VENTECLIENTS WHERE numProd=:OLD.numProd;
	delete from VENTECLIENTS where numProd=:OLD.numProd;
	
END;
/

	  
PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
