
CREATE OR REPLACE FUNCTION COUTVENTE (prixvente IN NUMBER, quantite IN NUMBER,numero IN CHAR,datevente IN DATE) 
   RETURN NUMBER AS 
  
  
BEGIN

       return quantite*prixvente;
END;
/
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
