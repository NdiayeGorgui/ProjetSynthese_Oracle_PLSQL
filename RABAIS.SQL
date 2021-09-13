
CREATE OR REPLACE PROCEDURE RABAIS (lenum IN CHAR,ladate IN DATE) IS

	--1. Declaration
	
CURSOR Cur_livre IS 
SELECT * FROM VENTECLIENTS WHERE numClient=lenum AND dateVente =ladate
FOR UPDATE OF prixVente ;
 	Le_curseur_livre Cur_livre%ROWTYPE;
	taux number (4,2):=0;
	
CURSOR Cur_rab1 IS 
	SELECT numClient, SUM( prixVente*quantiteVendue) as SOUS_TOTAL,SUM( prixVente*quantiteVendue*0.15) as TAXE,SUM( prixVente*quantiteVendue*1.15) as TOTAL FROM VENTECLIENTS GROUP BY numClient ;
	Le_curseur_rab1 Cur_rab1%ROWTYPE;
	
BEGIN
 DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
		DBMS_OUTPUT.PUT_LINE('Liste des ventes pour le client avant rabais de prix');
		DBMS_OUTPUT.PUT_LINE('================================================================================================================');
		DBMS_OUTPUT.PUT_LINE(RPAD('CODE VENTE',20)||RPAD('NUMERO CLIENT',20)||RPAD('NUMERO PRODUIT',20)||RPAD('DATE VENTE',20)||RPAD('QUANTITE VENDUE',20)||RPAD('PRIX DE VENTE',20));
    FOR Liste1 IN (SELECT  codeVente,numClient,numProd,dateVente,quantiteVendue,prixVente FROM VENTECLIENTS WHERE numClient=lenum) LOOP
		DBMS_OUTPUT.PUT_LINE(rpad(Liste1.codeVente,20)||rpad(Liste1.numClient,20)||rpad(Liste1.numProd,20)||rpad(Liste1.dateVente,20)||rpad(Liste1.quantiteVendue,20)||rpad(Liste1.prixVente,20));
    END LOOP;
		DBMS_OUTPUT.PUT_LINE('====================================================================================================================');
	--2. Ouverture du curseur
	OPEN Cur_livre;
	--3. Traitement du curseur
	FETCH Cur_livre INTO Le_curseur_livre;
	WHILE Cur_livre%FOUND LOOP
		IF((Le_curseur_livre.prixVente*Le_curseur_livre.quantiteVendue>=1000) AND (Le_curseur_livre.prixVente*Le_curseur_livre.quantiteVendue<=5000)) THEN
			taux :=0.90;
		ELSIF  (Le_curseur_livre.prixvente*Le_curseur_livre.quantitevendue>5000) THEN 
			taux :=0.85;
		ELSE 
			taux :=0.95;
		END IF;
	UPDATE VENTECLIENTS
		SET prixVente = Le_curseur_livre.prixVente * taux
		WHERE CURRENT OF Cur_livre ;
		FETCH Cur_livre INTO Le_curseur_livre;
	END LOOP;
	COMMIT;
	--4. Fermeture du curseur
	CLOSE Cur_livre;
	
  
	DBMS_OUTPUT.PUT_LINE('Liste des ventes pour le client apres rabais de prix');
	DBMS_OUTPUT.PUT_LINE('==================================================================================================');
	DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT',20)||RPAD('PRIX',20)||RPAD('QUANTITE',20)||RPAD('SOUS_TOTAL',20)||RPAD('TAXE (15%)',20));
	FOR Liste1 IN (SELECT numClient,prixVente,quantiteVendue,  prixVente*quantiteVendue as SOUS_TOTAL,prixVente*quantiteVendue*0.15 as TAXE FROM VENTECLIENTS WHERE numClient=lenum) LOOP
		DBMS_OUTPUT.PUT_LINE(rpad(Liste1.numClient,20)||rpad(Liste1.prixVente,20)||rpad(Liste1.quantiteVendue,20)||rpad(Liste1.SOUS_TOTAL,20)||rpad(Liste1.TAXE,20));

  END LOOP;
  --Le total  des ventes regroupes par noclient
    DBMS_OUTPUT.PUT_LINE('====================================================================================================================');
   DBMS_OUTPUT.PUT_LINE('Le total  des ventes regroupes par noclient ');
   DBMS_OUTPUT.PUT_LINE('==================================================================================================');
   DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT',20)||RPAD('SOUS_TOTAL ',20)||RPAD('TAXE (15%)',20)||RPAD('TOTAL ',20));
	--2. Ouverture du curseur pour parcouririr les enregistrement
	OPEN Cur_rab1;
	LOOP
	FETCH Cur_rab1 INTO Le_curseur_rab1;
	EXIT WHEN Cur_rab1%NOTFOUND;
		 
		DBMS_OUTPUT.PUT_LINE(rpad(Le_curseur_rab1.numClient,20)||rpad(Le_curseur_rab1.SOUS_TOTAL,20)||rpad(Le_curseur_rab1.TAXE,20)||rpad(Le_curseur_rab1.TOTAL,20));
		
	END LOOP;
--3. Fermeture du curseur
	CLOSE Cur_rab1;
  
   
END;
/
	  
PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql

