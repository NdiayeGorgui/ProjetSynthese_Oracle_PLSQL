CREATE OR REPLACE FUNCTION COUTVENTE2 (numero IN CHAR,datevente IN DATE) 
   RETURN NUMBER AS 
  
 prixvente  NUMBER;
 quantite  NUMBER;
CURSOR Cur_fact IS 
SELECT * FROM CLIENTS WHERE numClient=numero;

 	Le_curseur_fact Cur_fact%ROWTYPE;
	
BEGIN
DBMS_OUTPUT.PUT_LINE('Le tableau du client concerne');
	DBMS_OUTPUT.PUT_LINE('==================================================================================================');
	DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT:',20)||RPAD(Le_curseur_fact.numClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('NOM:',20)||RPAD(Le_curseur_fact.nomClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('PRENOM:',20)||RPAD(Le_curseur_fact.prenomClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('......',20));
	
	CLOSE Cur_fact;
	
	OPEN Cur_fact;
FETCH Cur_fact INTO Le_curseur_fact;



	
	DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO PRODUIT',20)||RPAD('PRIX',20)||RPAD('QUANTITE',20)||RPAD('SOUS_TOTAL',20));
	FOR Liste1 IN (
	SELECT numClient,numProd,prixVente,quantiteVendue,dateVente ,  prixVente*quantiteVendue as SOUS_TOTAL, prixVente*quantiteVendue*0.15 as TAXE 
	FROM VENTECLIENTS WHERE numClient=numero AND dateVente=datevente) LOOP
	
		DBMS_OUTPUT.PUT_LINE(rpad(Liste1.numProd,20)||rpad(Liste1.prixVente,20)||rpad(Liste1.quantiteVendue,20)||rpad(Liste1.SOUS_TOTAL,20));

  END LOOP;
  FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue*0.15) as TAXE FROM VENTECLIENTS WHERE numClient=numero AND dateVente=datevente) LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('TAXES (15%)',20)||rpad(Liste1.TAXE,20));
		

  END LOOP;
  FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue) as TOTAL FROM VENTECLIENTS WHERE numClient=numero AND dateVente=datevente) LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('TOTAL',20)||rpad(Liste1.TOTAL,20));
		

  END LOOP;
  
   FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue*1.15) as GRAND_TOTAL FROM VENTECLIENTS WHERE numClient=numero AND dateVente=datevente) LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('GRAND TOTAL',20)||rpad(Liste1.GRAND_TOTAL,20));
		

  END LOOP;
  EXCEPTION
  WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE('Le code n''existe pas');

       return quantite*prixvente;
END;
/





	  

