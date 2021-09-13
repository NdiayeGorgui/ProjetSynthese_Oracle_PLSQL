--Insertion de donnees dans la table vente
SET SERVEROUTPUT ON
SET VERIFY OFF

-- Demander a l'utilisateur d'entrer le numero du client, le numero du produit,la date de vente, le prix de vente et la quantitevendue 
ACCEPT lenumclient PROMPT "Entrer le numero du client: "
ACCEPT lenumproduit PROMPT "Entrer le numero du produit: "
ACCEPT ladate PROMPT "Entrer la date de vente: "
ACCEPT laquantite PROMPT "Entrer la quantite vendue: "
ACCEPT leprix PROMPT "Entrer le prix de vente: "

DECLARE


--1. Declaration du curseur
    CURSOR Cur_prix IS SELECT numProd,nom,quantiteStock,prix FROM PRODUITS WHERE numProd='&lenumproduit';
    Le_curseur_prix Cur_prix%ROWTYPE;
	
--declaration des codes d'erreur
	cle_reference EXCEPTION;
	date_invalide EXCEPTION;
	
	PRAGMA EXCEPTION_INIT(cle_reference,-2291);
	PRAGMA EXCEPTION_INIT(date_invalide,-1830);

BEGIN

--2. Ouverture du curseur
	OPEN Cur_prix;
	
	
	FETCH Cur_prix INTO Le_curseur_prix;
		-- Insertion de donnees dans la table VENTECLIENTS en recuperant le prix dans la table PRODUITS
    
	IF '&leprix'='' THEN
		IF Le_curseur_prix.quantiteStock>'&laquantite'  THEN
			INSERT INTO VENTECLIENTS(codeVente,numClient,numProd,dateVente,quantiteVendue,prixVente) 
			VALUES(seq_vente_gr408.NEXTVAL,'&lenumclient','&lenumproduit','&ladate','&laquantite',Le_curseur_prix.prix);
			FETCH Cur_prix INTO Le_curseur_prix;
	
			UPDATE PRODUITS  SET quantiteStock=quantiteStock-'&laquantite' WHERE numProd='&lenumproduit'; 
	
			COMMIT;
	
--affichage du message d'insertion si la vente  se fait correctement puis affichage de la liste
			DBMS_OUTPUT.PUT_LINE('Insertion de venteClient reussi!');
			DBMS_OUTPUT.PUT_LINE('Liste des ventes');
			DBMS_OUTPUT.PUT_LINE(RPAD('CODE VENTE',20)||RPAD('NUMERO CLIENT',20)||RPAD('NUMERO PRODUIT',20)||RPAD('DATE VENTE',20)||RPAD('QUANTITE VENDUE',20)||RPAD('PRIX DE VENTE',20));
			FOR Liste1 IN (SELECT  codeVente,numClient,numProd,dateVente,quantiteVendue,prixVente FROM VENTECLIENTS ) LOOP
				DBMS_OUTPUT.PUT_LINE(rpad(Liste1.codeVente,20)||rpad(Liste1.numClient,20)||rpad(Liste1.numProd,20)||rpad(Liste1.dateVente,20)||rpad(Liste1.quantiteVendue,20)||rpad(Liste1.prixVente,20));
			
			END LOOP;
		ELSIF   Le_curseur_prix.quantiteStock=0  THEN
				DBMS_OUTPUT.PUT_LINE('Impossible la quantiteStock est Null !');
		ELSE
			DBMS_OUTPUT.PUT_LINE('Impossible la quantiteStock est inferieur a la quantite de Vente !');
		END IF ;
	
	ELSIF  '&leprix'< Le_curseur_prix.prix THEN
	
	DBMS_OUTPUT.PUT_LINE('Le Prix de vente ne doit pas etre inferieur au prix du produit!');
	
	ELSE
--affichage du message d'insertion si la vente se fait correctement puis affichage de la liste
		IF Le_curseur_prix.quantiteStock>'&laquantite' AND Le_curseur_prix.quantiteStock>0  THEN
			INSERT INTO VENTECLIENTS(codeVente,numClient,numProd,dateVente,quantiteVendue,prixVente) 
			VALUES(seq_vente_gr408.NEXTVAL,'&lenumclient','&lenumproduit','&ladate','&laquantite','&leprix');
		
			UPDATE PRODUITS  SET quantiteStock=quantiteStock-'&laquantite' WHERE numProd='&lenumproduit'; 
		
			COMMIT;
			DBMS_OUTPUT.PUT_LINE('Insertion de venteClient reussi!');
			DBMS_OUTPUT.PUT_LINE('Liste des ventes');
			DBMS_OUTPUT.PUT_LINE(RPAD('CODE VENTE',20)||RPAD('NUMERO CLIENT',20)||RPAD('NUMERO PRODUIT',20)||RPAD('DATE VENTE',20)||RPAD('QUANTITE VENDUE',20)||RPAD('PRIX DE VENTE',20));
			FOR Liste IN (SELECT  codeVente,numClient,numProd,dateVente,quantitevendue,prixVente FROM VENTECLIENTS ) LOOP
			DBMS_OUTPUT.PUT_LINE(rpad(Liste.codeVente,20)||rpad(Liste.numClient,20)||rpad(Liste.numProd,20)||rpad(Liste.dateVente,20)||rpad(Liste.quantiteVendue,20)||rpad(Liste.prixVente,20));
			END LOOP;
		ELSIF   Le_curseur_prix.quantiteStock=0  THEN
			DBMS_OUTPUT.PUT_LINE('Impossible la quantiteStock est Null !');
		ELSIF   Le_curseur_prix.quantiteStock< '&laquantite' THEN
				DBMS_OUTPUT.PUT_LINE('Impossible la quantiteStock est inferieur a la quantite de Vente !');
		END IF ;
	
    END IF;
--3. Fermeture du curseur
    CLOSE Cur_prix;
EXCEPTION
     
		
--affichage du message d'erreur si le format de la date est incorrect
	WHEN date_invalide THEN
	DBMS_OUTPUT.PUT_LINE('Date invalide, Le format de la date doit etre : 2020-01-01');
	
	--affichage du message d'erreur si numClient et ou numProd n'existe pas
	WHEN cle_reference THEN
			DBMS_OUTPUT.PUT_LINE('Le numClient ou le numProd  n''existe pas!');
			
 --affichage des numClient et numProd existants
		DBMS_OUTPUT.PUT_LINE('Liste des numero clients');
		FOR Liste IN (SELECT  numClient FROM clients ) LOOP
			DBMS_OUTPUT.PUT_LINE(rpad(Liste.numClient,20));
		END LOOP;
	  
	   DBMS_OUTPUT.PUT_LINE('Liste des codes produits');
	   FOR Liste IN (SELECT  numProd FROM produits ) LOOP
			DBMS_OUTPUT.PUT_LINE(rpad(Liste.numProd,20));
       END LOOP;
	WHEN OTHERS THEN
           dbms_output.put_line('Une erreur s''est produite!');	
	
END;
/
SET VERIFY ON
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\INSERTION.sql
