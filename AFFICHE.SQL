SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT  lenumero PROMPT  "Saisir le numero du client : "
--ACCEPT  ladate PROMPT  "Saisir la date  : "

	--1. Declaration du curseur

DECLARE
	CURSOR Cur_rab IS 
	SELECT numClient, SUM( prixVente*quantiteVendue) as SOUS_TOTAL,SUM( prixVente*quantiteVendue*0.15) as TAXE,SUM( prixVente*quantiteVendue*1.15) as TOTAL FROM VENTECLIENTS GROUP BY numClient HAVING numClient='&lenumero';
	Le_curseur_rab Cur_rab%ROWTYPE;
BEGIN

	--2. Ouverture du curseur pour parcouririr les enregistrement
	OPEN Cur_rab;
	LOOP
	FETCH Cur_rab INTO Le_curseur_rab;
	EXIT WHEN Cur_rab%NOTFOUND;
		 DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT',20)||RPAD('SOUS_TOTAL ',20)||RPAD('TAXE',20)||RPAD('TOTAL ',20));
		DBMS_OUTPUT.PUT_LINE(rpad(Le_curseur_rab.numClient,20)||rpad(Le_curseur_rab.SOUS_TOTAL,20)||rpad(Le_curseur_rab.TAXE,20)||rpad(Le_curseur_rab.TOTAL,20));
		
	END LOOP;
--3. Fermeture du curseur
CLOSE Cur_rab;
   
END;
/
	
SET VERIFY ON
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
