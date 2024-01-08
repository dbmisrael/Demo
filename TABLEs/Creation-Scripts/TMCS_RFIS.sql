CREATE TABLE TMCS_RFIS
   (	RFI_ID NUMBER DEFAULT TMCS_RFIS_S.NEXTVAL,
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	RFI_DATE DATE,
	DESCRIPTION VARCHAR2(4000),
	C_EXT_ATTR1 VARCHAR2(4000),
	C_EXT_ATTR2 VARCHAR2(4000),
	C_EXT_ATTR3 VARCHAR2(4000),
	C_EXT_ATTR4 VARCHAR2(4000),
	C_EXT_ATTR5 VARCHAR2(4000),
	C_EXT_ATTR6 VARCHAR2(4000),
	C_EXT_ATTR7 VARCHAR2(4000),
	C_EXT_ATTR8 VARCHAR2(4000),
	C_EXT_ATTR9 VARCHAR2(4000),
	C_EXT_ATTR10 VARCHAR2(4000),
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	RFI_TYPE VARCHAR2(200),
	STATUS VARCHAR2(50),
	DOC_REFERENCE VARCHAR2(500),
	RECOMMENDATION VARCHAR2(4000),
	ASSIGNED_TO VARCHAR2(200),
	COST_ADJUSTMENT NUMBER,
	SCHEDULE_ADJUSTMENT VARCHAR2(2000),
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	 PRIMARY KEY (RFI_ID)
  USING INDEX  ENABLE
   ) ;
