CREATE TABLE TMCS_SEED_STORE_OD
   (	SOURCE_SEED_ID VARCHAR2(11),
	STORE_NUMBER VARCHAR2(11),
	CBSA_CLASS NUMBER(10,0),
	STORE_CLASS NUMBER(10,0),
	DRIVETIME NUMBER(17,3),
	SL_DISTANCE NUMBER(17,3),
	DRIVEDISTANCE NUMBER(17,3),
	RANK NUMBER(10,0),
	C_EXT_ATTR1 VARCHAR2(254),
	C_EXT_ATTR2 VARCHAR2(254),
	CLIENT_ID VARCHAR2(64),
	BRAND_ID VARCHAR2(64)
   ) ;
  CREATE UNIQUE INDEX TMCS_SEED_STORE_OD_PK ON TMCS_SEED_STORE_OD (SOURCE_SEED_ID, STORE_NUMBER)
  ;
ALTER TABLE TMCS_SEED_STORE_OD ADD CONSTRAINT TMCS_SEED_STORE_OD_PK PRIMARY KEY (SOURCE_SEED_ID, STORE_NUMBER)
  USING INDEX TMCS_SEED_STORE_OD_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SEED_STORE_OD_PK ON TMCS_SEED_STORE_OD (SOURCE_SEED_ID, STORE_NUMBER)
  ;

