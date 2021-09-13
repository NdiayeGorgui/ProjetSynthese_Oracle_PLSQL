
CREATE OR REPLACE FUNCTION TAXE (numero IN CHAR, prix IN NUMBER,quantite IN NUMBER) 
   RETURN NUMBER AS 
BEGIN
	
	RETURN prix*quantite*0.15;


END;
/
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
