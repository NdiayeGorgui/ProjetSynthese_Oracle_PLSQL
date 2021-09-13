SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT  lenum PROMPT  "Saisir le numero du client : "
ACCEPT  ladate PROMPT  "Saisir la date: "

BEGIN
	RABAIS  ('&lenum','&ladate');
	
END;
/
SET VERIFY ON 
	  
 PAUSE "Appuyer sur touche pour continuer..."
@C:\Projet\MENUPROJET.sql
