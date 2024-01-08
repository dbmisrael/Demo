CREATE TABLE TMCS_ANALOG_RESULTS
   (	ANALOG_ID NUMBER,
	ANALOG_NAME VARCHAR2(500),
	ENTITY_TYPE VARCHAR2(500),
	STORE_ID NUMBER,
	ADDRESS VARCHAR2(500),
	CITY VARCHAR2(500),
	STATE VARCHAR2(500),
	COUNTY VARCHAR2(500),
	DMA VARCHAR2(500),
	OPEN_DATE DATE,
	SITE_TYPE VARCHAR2(500),
	TOTAL_SQFT NUMBER,
	PY_TOT_SALES NUMBER,
	CY_TOT_SALES NUMBER,
	C_EXT_ATTR1 VARCHAR2(500),
	C_EXT_ATTR2 VARCHAR2(500),
	C_EXT_ATTR3 VARCHAR2(500),
	C_EXT_ATTR4 VARCHAR2(500),
	C_EXT_ATTR5 VARCHAR2(500),
	C_EXT_ATTR6 VARCHAR2(500),
	C_EXT_ATTR7 VARCHAR2(500),
	C_EXT_ATTR8 VARCHAR2(500),
	C_EXT_ATTR9 VARCHAR2(500),
	C_EXT_ATTR10 VARCHAR2(500),
	C_EXT_ATTR11 VARCHAR2(500),
	C_EXT_ATTR12 VARCHAR2(500),
	C_EXT_ATTR13 VARCHAR2(500),
	C_EXT_ATTR14 VARCHAR2(500),
	C_EXT_ATTR15 VARCHAR2(500),
	C_EXT_ATTR16 VARCHAR2(500),
	C_EXT_ATTR17 VARCHAR2(500),
	C_EXT_ATTR18 VARCHAR2(500),
	C_EXT_ATTR19 VARCHAR2(500),
	C_EXT_ATTR20 VARCHAR2(500),
	C_EXT_ATTR21 VARCHAR2(500),
	C_EXT_ATTR22 VARCHAR2(500),
	C_EXT_ATTR23 VARCHAR2(500),
	C_EXT_ATTR24 VARCHAR2(500),
	C_EXT_ATTR25 VARCHAR2(500),
	C_EXT_ATTR26 VARCHAR2(500),
	DEMO_EXT_ATTR1 NUMBER,
	DEMO_EXT_ATTR2 NUMBER,
	DEMO_EXT_ATTR3 NUMBER,
	DEMO_EXT_ATTR4 NUMBER,
	DEMO_EXT_ATTR5 NUMBER,
	DEMO_EXT_ATTR6 NUMBER,
	DEMO_EXT_ATTR7 NUMBER,
	DEMO_EXT_ATTR8 NUMBER,
	DEMO_EXT_ATTR9 NUMBER,
	DEMO_EXT_ATTR10 NUMBER,
	DEMO_EXT_ATTR11 NUMBER,
	DEMO_EXT_ATTR12 NUMBER,
	DEMO_EXT_ATTR13 NUMBER,
	DEMO_EXT_ATTR14 NUMBER,
	DEMO_EXT_ATTR15 NUMBER,
	DEMO_EXT_ATTR16 NUMBER,
	DEMO_EXT_ATTR17 NUMBER,
	DEMO_EXT_ATTR18 NUMBER,
	DEMO_EXT_ATTR19 NUMBER,
	DEMO_EXT_ATTR20 NUMBER,
	DEMO_EXT_ATTR21 NUMBER,
	DEMO_EXT_ATTR22 NUMBER,
	DEMO_EXT_ATTR23 NUMBER,
	DEMO_EXT_ATTR24 NUMBER,
	DEMO_EXT_ATTR25 NUMBER,
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
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER,
	N_EXT_ATTR31 NUMBER,
	N_EXT_ATTR32 NUMBER,
	STORE_NUMBER VARCHAR2(50),
	BRAND_NAME VARCHAR2(50),
	C_EXT_ATTR27 VARCHAR2(500),
	D_EXT_ATTR1 DATE,
	N_EXT_ATTR33 NUMBER,
	N_EXT_ATTR34 NUMBER,
	N_EXT_ATTR35 NUMBER,
	DISPLAY_SEQ NUMBER,
	ZIP VARCHAR2(15),
	SQ_EXT_ATTR1 VARCHAR2(100),
	SQ_EXT_ATTR2 VARCHAR2(100),
	SQ_EXT_ATTR3 VARCHAR2(100),
	SQ_EXT_ATTR4 VARCHAR2(100),
	SQ_EXT_ATTR5 VARCHAR2(100),
	LOCATION_TYPE_CODE VARCHAR2(200),
	C_EXT_ATTR28 VARCHAR2(500),
	C_EXT_ATTR29 VARCHAR2(500),
	C_EXT_ATTR30 VARCHAR2(500),
	C_EXT_ATTR31 VARCHAR2(500),
	C_EXT_ATTR32 VARCHAR2(500),
	C_EXT_ATTR33 VARCHAR2(500),
	C_EXT_ATTR34 VARCHAR2(500),
	C_EXT_ATTR35 VARCHAR2(500),
	C_EXT_ATTR36 VARCHAR2(500),
	C_EXT_ATTR37 VARCHAR2(500),
	C_EXT_ATTR38 VARCHAR2(500),
	C_EXT_ATTR39 VARCHAR2(500),
	C_EXT_LOV1 VARCHAR2(500),
	C_EXT_LOV2 VARCHAR2(500),
	C_EXT_LOV3 VARCHAR2(500),
	C_EXT_LOV4 VARCHAR2(500),
	C_EXT_LOV5 VARCHAR2(500),
	C_EXT_LOV6 VARCHAR2(500),
	C_EXT_LOV7 VARCHAR2(500),
	C_EXT_LOV8 VARCHAR2(500),
	C_EXT_LOV9 VARCHAR2(500),
	C_EXT_LOV10 VARCHAR2(500),
	DEMO_EXT_ATTR26 NUMBER,
	DEMO_EXT_ATTR27 NUMBER,
	DEMO_EXT_ATTR28 NUMBER,
	DEMO_EXT_ATTR29 NUMBER,
	N_EXT_ATTR36 NUMBER,
	N_EXT_ATTR37 NUMBER,
	N_EXT_ATTR38 NUMBER,
	N_EXT_ATTR39 NUMBER,
	ENTITY_NAME VARCHAR2(200),
	STORE_SIZE NUMBER,
	DEMO_EXT_ATTR30 NUMBER,
	DEMO_EXT_ATTR31 NUMBER,
	DEMO_EXT_ATTR32 NUMBER,
	DEMO_EXT_ATTR33 NUMBER,
	DEMO_EXT_ATTR34 NUMBER,
	DEMO_EXT_ATTR35 NUMBER,
	DEMO_EXT_ATTR36 NUMBER,
	DEMO_EXT_ATTR37 NUMBER,
	DEMO_EXT_ATTR38 NUMBER,
	DEMO_EXT_ATTR39 NUMBER,
	DEMO_EXT_ATTR40 NUMBER,
	TERRITORY VARCHAR2(500),
	OWNED_BY VARCHAR2(500),
	DMA_NAME VARCHAR2(250),
	MARGIN_TOT_SALES NUMBER,
	EDITDA_TOT_SALES NUMBER,
	TA_N_EXT_ATTR29 NUMBER,
	TA_N_EXT_ATTR30 NUMBER
   ) ;

