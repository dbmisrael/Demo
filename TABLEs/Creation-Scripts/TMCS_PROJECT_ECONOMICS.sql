CREATE TABLE TMCS_PROJECT_ECONOMICS
   (	ECONOMIC_ID NUMBER,
	PROJECT_ID NUMBER,
	ECONOMY_TYPE VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	C_EXT_ATTR01 VARCHAR2(4000),
	C_EXT_ATTR02 VARCHAR2(4000),
	C_EXT_ATTR03 VARCHAR2(4000),
	C_EXT_ATTR04 VARCHAR2(500),
	C_EXT_ATTR05 VARCHAR2(500),
	C_EXT_ATTR06 VARCHAR2(500),
	C_EXT_ATTR07 VARCHAR2(4000),
	C_EXT_ATTR08 VARCHAR2(4000),
	C_EXT_ATTR09 VARCHAR2(500),
	C_EXT_ATTR10 VARCHAR2(4000),
	N_EXT_ATTR01 NUMBER,
	N_EXT_ATTR02 NUMBER,
	N_EXT_ATTR03 NUMBER,
	N_EXT_ATTR04 NUMBER,
	N_EXT_ATTR05 NUMBER,
	N_EXT_ATTR06 NUMBER,
	N_EXT_ATTR07 NUMBER,
	N_EXT_ATTR08 NUMBER,
	N_EXT_ATTR09 NUMBER,
	N_EXT_ATTR10 NUMBER,
	D_EXT_ATTR01 DATE,
	D_EXT_ATTR02 DATE,
	D_EXT_ATTR03 DATE,
	D_EXT_ATTR04 DATE,
	D_EXT_ATTR05 DATE,
	D_EXT_ATTR06 DATE,
	D_EXT_ATTR07 DATE,
	D_EXT_ATTR08 DATE,
	D_EXT_ATTR09 DATE,
	D_EXT_ATTR10 DATE,
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200),
	C_EXT_LOV6 VARCHAR2(200),
	C_EXT_LOV7 VARCHAR2(200),
	C_EXT_LOV8 VARCHAR2(200),
	C_EXT_LOV9 VARCHAR2(200),
	C_EXT_LOV10 VARCHAR2(200),
	N_EXT_ATTR11 NUMBER,
	N_EXT_ATTR12 NUMBER,
	N_EXT_ATTR13 NUMBER,
	N_EXT_ATTR14 NUMBER,
	N_EXT_ATTR15 NUMBER,
	N_EXT_ATTR16 NUMBER,
	N_EXT_ATTR17 NUMBER,
	N_EXT_ATTR18 NUMBER,
	N_EXT_ATTR19 NUMBER,
	N_EXT_ATTR20 NUMBER,
	N_EXT_ATTR21 NUMBER,
	N_EXT_ATTR22 NUMBER,
	N_EXT_ATTR23 NUMBER,
	N_EXT_ATTR24 NUMBER,
	N_EXT_ATTR25 NUMBER,
	N_EXT_ATTR26 NUMBER,
	N_EXT_ATTR27 NUMBER,
	N_EXT_ATTR28 NUMBER,
	N_EXT_ATTR29 NUMBER,
	N_EXT_ATTR30 NUMBER,
	N_EXT_ATTR31 NUMBER,
	N_EXT_ATTR32 NUMBER,
	N_EXT_ATTR33 NUMBER,
	N_EXT_ATTR34 NUMBER,
	N_EXT_ATTR35 NUMBER,
	C_EXT_ATTR11 VARCHAR2(4000),
	C_EXT_ATTR12 VARCHAR2(4000),
	C_EXT_ATTR13 VARCHAR2(4000),
	C_EXT_ATTR14 VARCHAR2(4000),
	C_EXT_ATTR15 VARCHAR2(250),
	C_EXT_ATTR16 VARCHAR2(250),
	C_EXT_ATTR17 VARCHAR2(250),
	C_EXT_ATTR18 VARCHAR2(250),
	C_EXT_ATTR19 VARCHAR2(250),
	C_EXT_ATTR20 VARCHAR2(250),
	C_EXT_ATTR21 VARCHAR2(250),
	C_EXT_ATTR22 VARCHAR2(250),
	C_EXT_ATTR23 VARCHAR2(250),
	C_EXT_ATTR24 VARCHAR2(250),
	C_EXT_ATTR25 VARCHAR2(4000),
	N_EXT_ATTR36 NUMBER,
	N_EXT_ATTR37 NUMBER,
	N_EXT_ATTR38 NUMBER,
	N_EXT_ATTR39 NUMBER,
	N_EXT_ATTR40 NUMBER,
	D_EXT_ATTR11 DATE,
	D_EXT_ATTR12 DATE,
	D_EXT_ATTR13 DATE,
	D_EXT_ATTR14 DATE,
	D_EXT_ATTR15 DATE,
	C_EXT_LOV11 VARCHAR2(200),
	C_EXT_LOV12 VARCHAR2(200),
	C_EXT_LOV13 VARCHAR2(200),
	C_EXT_LOV14 VARCHAR2(200),
	C_EXT_LOV15 VARCHAR2(200),
	C_EXT_ATTR_TXT01 VARCHAR2(4000),
	C_EXT_ATTR_TXT02 VARCHAR2(4000),
	C_EXT_ATTR_TXT03 VARCHAR2(4000),
	C_EXT_ATTR_TXT04 VARCHAR2(4000),
	C_EXT_ATTR_TXT05 VARCHAR2(4000),
	N_EXT_ATTR41 NUMBER,
	 CONSTRAINT TMCS_PROJECT_ECONOMICS_PK PRIMARY KEY (ECONOMIC_ID)
  USING INDEX  ENABLE
   ) ;

