--mise a jour
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT newnumber PROMPT "Entrer le nouveau numero : "
ACCEPT lenumero PROMPT "Entrer le numero a modifier : "

DECLARE nbre NUMBER:=0;
BEGIN
--verifie si le code existe
   select count(numClient) INTO nbre FROM clients WHERE upper(numClient)=upper('&lenumero');
   IF nbre>0 THEN
   UPDATE clients SET numClient='&newnumber' WHERE upper(numClient)=upper('&lenumero');
    DBMS_OUTPUT.PUT_LINE('modification effectuée avec succés');
   COMMIT;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Le numero client n''existe pas');
	END IF;
END;
   /
      SET VERIFY ON
	  
	  	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MAJ_SUP.sql
