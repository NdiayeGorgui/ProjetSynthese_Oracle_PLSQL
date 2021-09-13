SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER triggerupdate_client
AFTER UPDATE OF numClient ON clients
FOR EACH ROW


BEGIN
    DBMS_OUTPUT.PUT_LINE('Modification en cascade de : ' ||:NEW.numClient);
    update venteclients set numClient=:NEW.numClient where numClient=:OLD.numClient;
	
		
	--affichage des donnees mises a jour
	FOR maliste IN(select * from venteclients) LOOP
		dbms_output.put_line(rpad(maliste.codeVente,10)||rpad(maliste.numClient,20)||rpad(maliste.numProd,20)
		||maliste.dateVente||rpad(maliste.quantiteVendue,20)||rpad(maliste.prixVente,20));
	
	END LOOP;
	
END;
/
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
