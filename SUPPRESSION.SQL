--suppression
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT lenum PROMPT "Entrer le numero du produit : "
DECLARE nbre NUMBER:=0;
BEGIN
--verifie si le code existe
   select count(numProd) INTO nbre FROM produits WHERE upper(numProd)=upper('&lenum');
   IF nbre>0 THEN
      DELETE FROM produits  WHERE upper(numProd)=upper('&lenum');
      DBMS_OUTPUT.PUT_LINE('suppression effectuee avec succes');
      COMMIT;
   ELSE
      DBMS_OUTPUT.PUT_LINE('Le numero produit n''existe pas');
	END IF;
END;
   /
   SET VERIFY ON
   	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MAJ_SUP.sql
