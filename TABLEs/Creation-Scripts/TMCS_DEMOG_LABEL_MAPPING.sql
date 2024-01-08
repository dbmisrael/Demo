CREATE TABLE TMCS_DEMOG_LABEL_MAPPING
   (	COLUMN_NAME VARCHAR2(100),
	STORES_COMP_KEY VARCHAR2(200),
	ENTITY_TYPE VARCHAR2(200),
	ENTITY_COMP_KEY VARCHAR2(200),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1
   ) ;
  CREATE UNIQUE INDEX TMCS_DEMOG_LABEL_MAPPING_PK ON TMCS_DEMOG_LABEL_MAPPING (ENTITY_TYPE, STORES_COMP_KEY)
  ;
ALTER TABLE TMCS_DEMOG_LABEL_MAPPING ADD CONSTRAINT TMCS_DEMOG_LABEL_MAPPING_PK PRIMARY KEY (ENTITY_TYPE, STORES_COMP_KEY)
  USING INDEX TMCS_DEMOG_LABEL_MAPPING_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_DEMOG_LABEL_MAPPING_PK ON TMCS_DEMOG_LABEL_MAPPING (ENTITY_TYPE, STORES_COMP_KEY)
  ;

