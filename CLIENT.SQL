--Insertion de donnees dans la table clients
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT nom PROMPT "Entrer le nom: "
ACCEPT prenom PROMPT "Entrer le prenom: "
ACCEPT letelephone PROMPT "Entrer le telephone: "
ACCEPT lenumrue PROMPT "Entrer le numero de la rue: "
ACCEPT lenomrue PROMPT "Entrer le nom de la rue: "
ACCEPT laville PROMPT "Entrer la ville: "
ACCEPT laprovince PROMPT "Entrer la province: "
ACCEPT lecodepostal PROMPT "Entrer le codepostal: "
ACCEPT lepays PROMPT "Entrer le pays: "

BEGIN
	
	-- IF regexp_like('&letelephone','^?\(?\d{3}?\)??-??\(?\d{3}?\)??-??\(?\d{4}?\)??-?$') = FALSE then
	
	    IF regexp_like('&letelephone','^\d{3}-\d{3}-\d{4}$') = FALSE then
			DBMS_OUTPUT.PUT_LINE('Format du telephone est incorect!, insertion echouee');
		ELSIF '&letelephone'='' THEN
			DBMS_OUTPUT.PUT_LINE('Le telephone ne doit pas etre nul!, insertion echouee');
		ELSIF   regexp_like('&lecodepostal','^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$')=FALSE THEN
			DBMS_OUTPUT.PUT_LINE('Format du Code postal est incorect!, insertion echouee');
		ELSE
		--	Format  OK!
			INSERT INTO clients(numClient,nomClient,prenomClient,telephone,noRue,nomRue,ville,province,codePostal,pays) 
			VALUES(upper(substr('&nom',1,3))||upper(substr('&prenom',1,2)),'&nom','&prenom','&letelephone','&lenumrue',
			'&lenomrue','&laville','&laprovince',upper('&lecodepostal'),'&lepays');
			COMMIT;
			DBMS_OUTPUT.PUT_LINE('Insertion de client reussi!');
			DBMS_OUTPUT.PUT_LINE('Liste des clients');
			DBMS_OUTPUT.PUT_LINE(RPAD('NUMERO CLIENT',10)||RPAD('NOM',10)||RPAD('PRENOM',10)||RPAD('TELEPHONE',10)||RPAD('NO RUE',10)||RPAD('NOM RUE',10)||RPAD('VILLE',10)||RPAD('PROVINCE',10)||RPAD('CODE POSTAL',10)||RPAD('PAYS',10));
			FOR Liste IN (SELECT * FROM CLIENTS ) LOOP
			DBMS_OUTPUT.PUT_LINE(rpad(Liste.numClient,10)||rpad(Liste.nomClient,10)||rpad(Liste.prenomClient,10)||rpad(Liste.telephone,10)||rpad(Liste.noRue,10)||rpad(Liste.nomRue,10)||rpad(Liste.ville,10)||rpad(Liste.province,10)||rpad(Liste.codePostal,10)||rpad(Liste.pays,10));
			END LOOP;
		END IF;

	
	EXCEPTION
--Utilisation de l'exception dup_val_on_index predefinie
	WHEN dup_val_on_index THEN
		DBMS_OUTPUT.PUT_LINE('Le noclient existe deja!');
	WHEN others THEN	
		DBMS_OUTPUT.PUT_LINE('Une erreur s''est produite!');
END;
/
SET VERIFY ON

 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\INSERTION.sql