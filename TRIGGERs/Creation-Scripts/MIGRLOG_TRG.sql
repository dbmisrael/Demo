CREATE OR REPLACE EDITIONABLE TRIGGER MIGRLOG_TRG BEFORE INSERT OR UPDATE ON MIGRLOG
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;

/
ALTER TRIGGER MIGRLOG_TRG ENABLE;

