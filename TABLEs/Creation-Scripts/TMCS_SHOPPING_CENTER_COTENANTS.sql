CREATE TABLE TMCS_SHOPPING_CENTER_COTENANTS
   (	COTENANTID NUMBER(38,0),
	SHOPPING_CENTER_ID NUMBER,
	COTENANT_NAME VARCHAR2(500),
	C_EXT_ATTR1 VARCHAR2(500),
	C_EXT_ATTR2 VARCHAR2(500),
	C_EXT_ATTR3 VARCHAR2(500),
	C_EXT_ATTR4 VARCHAR2(500),
	C_EXT_ATTR5 VARCHAR2(500),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	CLIENT_ID NUMBER,
	LEASE_EXPIRATION_DATE DATE
   ) ;
  CREATE UNIQUE INDEX TMCS_SC_COTENANTS_PK ON TMCS_SHOPPING_CENTER_COTENANTS (COTENANTID)
  ;
ALTER TABLE TMCS_SHOPPING_CENTER_COTENANTS ADD CONSTRAINT TMCS_SC_COTENANTS_PK PRIMARY KEY (COTENANTID)
  USING INDEX TMCS_SC_COTENANTS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SC_COTENANTS_PK ON TMCS_SHOPPING_CENTER_COTENANTS (COTENANTID)
  ;
