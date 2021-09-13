--Entete de TAXEPACKAGE 
	CREATE OR REPLACE PACKAGE  TAXEPACKAGE  AS 
--Entete de COUTVENTE
		FUNCTION COUTVENTE (prixvente IN NUMBER, quantite IN NUMBER,numero IN CHAR,datevente IN DATE) 
		RETURN NUMBER ; 
	
--Entete de TAXE
		FUNCTION TAXE (numero IN CHAR, prix IN NUMBER,quantite IN NUMBER) 
		RETURN NUMBER;
		END TAXEPACKAGE;
		/
 --Corps du TAXEPACKAGE
		CREATE OR REPLACE PACKAGE BODY TAXEPACKAGE AS 
 
--Corps de COUTVENTE
		FUNCTION
		COUTVENTE (prixvente IN NUMBER, quantite IN NUMBER,numero IN CHAR,datevente IN DATE) 
	RETURN NUMBER IS 
	
--declaration de vaiable locale a la fonction
  BEGIN

	
       return quantite*prixvente;
END COUTVENTE;


--Corps de  TAXE
	FUNCTION

	TAXE (numero IN CHAR, prix IN NUMBER,quantite IN NUMBER) 
	RETURN NUMBER IS 

	BEGIN
	
	RETURN prix*quantite*0.15;


END TAXE;


END TAXEPACKAGE;

/

	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
