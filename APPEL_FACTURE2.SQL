SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT  lenumero PROMPT  "Saisir le numero du client : "
ACCEPT  ladate PROMPT  "Saisir la date  : "

BEGIN

DBMS_OUTPUT.PUT_LINE(COUVENTE2('&lenumero','&ladate'));
END;
/

SET VERIFY ON 

	  

