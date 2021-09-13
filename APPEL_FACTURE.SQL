SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT  lenumero PROMPT  "Saisir le numero du client : "
ACCEPT  ladate PROMPT  "Saisir la date  : "

DECLARE

CURSOR Cur_fact IS 
SELECT * FROM CLIENTS WHERE numClient='&lenumero';

 	Le_curseur_fact Cur_fact%ROWTYPE;

BEGIN
OPEN Cur_fact;
FETCH Cur_fact INTO Le_curseur_fact;


DBMS_OUTPUT.PUT_LINE('Le tableau du client concerne');
	DBMS_OUTPUT.PUT_LINE('==================================================================================================');
	DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT:',20)||RPAD(Le_curseur_fact.numClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('NOM:',20)||RPAD(Le_curseur_fact.nomClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('PRENOM:',20)||RPAD(Le_curseur_fact.prenomClient,20));
	DBMS_OUTPUT.PUT_LINE(RPAD('......',20));
	
	CLOSE Cur_fact;
	
	DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO PRODUIT',20)||RPAD('PRIX',20)||RPAD('QUANTITE',20)||RPAD('SOUS_TOTAL',20));
	FOR Liste1 IN (
	SELECT numClient,numProd,prixVente,quantiteVendue,dateVente ,  prixVente*quantiteVendue as SOUS_TOTAL, prixVente*quantiteVendue*0.15 as TAXE 
	FROM VENTECLIENTS WHERE numClient='&lenumero' AND dateVente='&ladate') LOOP
	
		DBMS_OUTPUT.PUT_LINE(rpad(Liste1.numProd,20)||rpad(Liste1.prixVente,20)||rpad(Liste1.quantiteVendue,20)||rpad(Liste1.SOUS_TOTAL,20));

  END LOOP;
  FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue*0.15) as TAXE FROM VENTECLIENTS WHERE numClient='&lenumero' AND dateVente='&ladate') LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('TAXES (15%)',20)||rpad(Liste1.TAXE,20));
		

  END LOOP;
  FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue) as TOTAL FROM VENTECLIENTS WHERE numClient='&lenumero' AND dateVente='&ladate') LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('TOTAL',20)||rpad(Liste1.TOTAL,20));
		

  END LOOP;
  
   FOR Liste1 IN (
	SELECT  SUM( prixVente*quantiteVendue*1.15) as GRAND_TOTAL FROM VENTECLIENTS WHERE numClient='&lenumero' AND dateVente='&ladate') LOOP
	
	    DBMS_OUTPUT.PUT_LINE(RPAD('=====',20)||RPAD('=====',20)||RPAD('GRAND TOTAL',20)||rpad(Liste1.GRAND_TOTAL,20));
		

  END LOOP;
  EXCEPTION
  WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE('Le code n''existe pas');
END;
/

SET VERIFY ON 

	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
