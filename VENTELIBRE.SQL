SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
 -- variable exception associee au code d'erreur -955 pour table existe
	table_existe EXCEPTION;
	PRAGMA EXCEPTION_INIT(table_existe,-955);

BEGIN 
    BEGIN

-- Creation de la table CLIENTS avec PLSQL;
		EXECUTE IMMEDIATE'create table CLIENTS(numClient varchar2(50) primary key,nomClient varchar2(20),prenomClient varchar2(30),
		telephone  varchar2(20),noRue number (10),nomRue varchar2(50), ville varchar2(30), province varchar2(30),codePostal varchar2(10),pays varchar2(20) )';
		dbms_output.put_line('La table CLIENTS est creee!');		
	EXCEPTION
		WHEN table_existe THEN
			dbms_output.put_line('Table CLIENTS existe deja!');
		WHEN OTHERS THEN
            dbms_output.put_line('Une erreur s''est produite!');		
	END;
	
	
	DECLARE
	 -- variable exception associee au code d'erreur -955 pour table existe
		table_existe2 EXCEPTION;
		PRAGMA EXCEPTION_INIT(table_existe2,-955);
	BEGIN
	-- Creation de la table PRODUITS avec PLSQL;
		EXECUTE IMMEDIATE'create table PRODUITS(numProd varchar2(50) primary key,nom varchar2(50),quantiteStock number(20),prix number(10,2))';
		dbms_output.put_line('La table PRODUITS est creee!');					
	EXCEPTION
		WHEN table_existe2 THEN
			dbms_output.put_line('Table PRODUITS existe deja!');
		WHEN OTHERS THEN
           dbms_output.put_line('Une erreur s''est produite!');	
	END;
	
	
	DECLARE
	 -- variable exception associee au code d'erreur -955 pour table existe
		table_existe3 EXCEPTION;
		PRAGMA EXCEPTION_INIT(table_existe3,-955);
	BEGIN
	
	-- Creation de la table VENTECLIENTS avec PLSQL;
		EXECUTE IMMEDIATE'create table VENTECLIENTS (codeVente varchar2(50) primary key,numClient varchar2(50),
		                    numProd varchar2(50), 
							dateVente DATE,
							quantiteVendue number(10),
							prixVente number(10,2),
							constraint fk_numprod FOREIGN KEY(numProd) REFERENCES PRODUITS(numProd),
							constraint fk_numclient FOREIGN KEY(numClient) REFERENCES CLIENTS(numClient))';
		dbms_output.put_line('La table VENTECLIENTS est creee!');					
	EXCEPTION
		WHEN table_existe3 THEN
			dbms_output.put_line('Table VENTECLIENTS existe deja!');
		WHEN OTHERS THEN
           dbms_output.put_line('Une erreur s''est produite!');	
	END;

END;
	/
	  SET VERIFY ON
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql

