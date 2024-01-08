CREATE TABLE TMCS_ENTITY_ADDL_ATTRS
   (	ADDL_ATTR_ID NUMBER,
	SEQ_NO NUMBER,
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	N_EXT_ATTR6 NUMBER,
	N_EXT_ATTR7 NUMBER,
	N_EXT_ATTR8 NUMBER,
	N_EXT_ATTR9 NUMBER,
	N_EXT_ATTR10 NUMBER,
	C_EXT_ATTR1 VARCHAR2(50),
	C_EXT_ATTR2 VARCHAR2(50),
	C_EXT_ATTR3 VARCHAR2(50),
	C_EXT_ATTR4 VARCHAR2(50),
	C_EXT_ATTR5 VARCHAR2(50),
	C_EXT_ATTR6 VARCHAR2(50),
	C_EXT_ATTR7 VARCHAR2(50),
	C_EXT_ATTR8 VARCHAR2(50),
	C_EXT_ATTR9 VARCHAR2(50),
	C_EXT_ATTR10 VARCHAR2(250),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (ADDL_ATTR_ID)
  USING INDEX  ENABLE
   ) ;
