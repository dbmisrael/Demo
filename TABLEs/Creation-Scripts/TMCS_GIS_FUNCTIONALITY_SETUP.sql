CREATE TABLE TMCS_GIS_FUNCTIONALITY_SETUP
   (	CLIENT_ID VARCHAR2(32),
	COUNTRY VARCHAR2(32),
	TMC_FUNCTIONALITY VARCHAR2(4000),
	DOMAIN VARCHAR2(4000),
	WIZARD_NAME VARCHAR2(4000),
	BRAND_ID VARCHAR2(32),
	ENTITY_TYPE VARCHAR2(32),
	PROFILES VARCHAR2(32)
   ) ;
  CREATE UNIQUE INDEX TMCS_GIS_FUNCTIONALITY_PK ON TMCS_GIS_FUNCTIONALITY_SETUP (CLIENT_ID, COUNTRY, TMC_FUNCTIONALITY, BRAND_ID)
  ;
ALTER TABLE TMCS_GIS_FUNCTIONALITY_SETUP ADD CONSTRAINT TMCS_GIS_FUNCTIONALITY_PK PRIMARY KEY (CLIENT_ID, COUNTRY, TMC_FUNCTIONALITY, BRAND_ID)
  USING INDEX TMCS_GIS_FUNCTIONALITY_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_GIS_FUNCTIONALITY_PK ON TMCS_GIS_FUNCTIONALITY_SETUP (CLIENT_ID, COUNTRY, TMC_FUNCTIONALITY, BRAND_ID)
  ;

