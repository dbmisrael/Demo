CREATE TABLE TMCS_ENTITY_ASSOCIATIONS
   (	ENTITY_ASSOC_ID NUMBER DEFAULT TMCS_ENTITY_ASSOCIATIONS_S.NEXTVAL,
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	ASSOC_ENTITY_ID NUMBER,
	ASSOC_ENTITY_TYPE VARCHAR2(100),
	COMMENTS VARCHAR2(4000),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_ENTITY_ASSOCIATIONS_PK ON TMCS_ENTITY_ASSOCIATIONS (ENTITY_ASSOC_ID)
  ;
ALTER TABLE TMCS_ENTITY_ASSOCIATIONS ADD CONSTRAINT TMCS_ENTITY_ASSOCIATIONS_PK PRIMARY KEY (ENTITY_ASSOC_ID)
  USING INDEX TMCS_ENTITY_ASSOCIATIONS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_ENTITY_ASSOCIATIONS_PK ON TMCS_ENTITY_ASSOCIATIONS (ENTITY_ASSOC_ID)
  ;

