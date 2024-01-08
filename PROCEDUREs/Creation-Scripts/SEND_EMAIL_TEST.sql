CREATE OR REPLACE EDITIONABLE PROCEDURE SEND_EMAIL_TEST AS
begin
  sys.utl_mail.send(sender     => 'Savita.rani@tangoanalytics.com',
                recipients => 'Savita.rani@tangoanalytics.com',
                subject    => 'Test utl_mail.send procedure',
                message    => 'If you are reading this it worked!');
EXCEPTION
WHEN OTHERS THEN
-- dbms_output.put_line('Fehler');
raise_application_error(-20001,'The following error has occured: ' || sqlerrm);
END;
/

