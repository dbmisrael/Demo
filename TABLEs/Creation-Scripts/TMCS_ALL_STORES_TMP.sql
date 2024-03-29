CREATE TABLE TMCS_ALL_STORES_TMP
   (	STORE_ID NUMBER,
	STORE_NUMBER VARCHAR2(50),
	STORE_NAME VARCHAR2(50),
	ADDRESS VARCHAR2(500),
	CITY VARCHAR2(50),
	STATE VARCHAR2(50),
	COUNTY VARCHAR2(50),
	NEIGHBORHOOD VARCHAR2(100),
	COUNTRY VARCHAR2(50),
	ZIP VARCHAR2(50),
	FULL_ADDRESS VARCHAR2(50),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	STATUS VARCHAR2(50),
	MARKET_NAME VARCHAR2(50),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	CY_ANNUAL_SALES NUMBER,
	SIS_TYPE_CODE VARCHAR2(50),
	LOCATION_TYPE_CODE VARCHAR2(50),
	STORE_SIZE NUMBER,
	TOTAL_ANNUAL_RENT NUMBER,
	BASE_RENT_PER_SIZE NUMBER,
	OPEN_DATE DATE,
	CLOSE_DATE DATE,
	LEASE_EXP_DATE DATE,
	LEASE_OPTION VARCHAR2(50),
	CY_TRL_12_MO_SALES NUMBER,
	PY_TRL_12_MO_SALES NUMBER,
	PCT_DIFF_SALES NUMBER,
	CY_EBITDA NUMBER,
	PY_EBITDA NUMBER,
	PCT_DIFF_EBITDA NUMBER,
	PERIOD_ENDING VARCHAR2(50),
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
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
	D_EXT_ATTR6 DATE,
	D_EXT_ATTR7 DATE,
	D_EXT_ATTR8 DATE,
	D_EXT_ATTR9 DATE,
	D_EXT_ATTR10 DATE,
	D_EXT_ATTR11 DATE,
	D_EXT_ATTR12 DATE,
	D_EXT_ATTR13 DATE,
	D_EXT_ATTR14 DATE,
	D_EXT_ATTR15 DATE,
	CBSA_CLASS VARCHAR2(50),
	STORE_CLASS VARCHAR2(50),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
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
	C_EXT_ATTR27 VARCHAR2(500),
	C_EXT_ATTR28 VARCHAR2(500),
	C_EXT_ATTR29 VARCHAR2(500),
	C_EXT_ATTR30 VARCHAR2(500),
	N_EXT_ATTR16 NUMBER,
	BRAND_ID NUMBER(*,0),
	N_EXT_ATTR17 NUMBER,
	N_EXT_ATTR18 NUMBER,
	N_EXT_ATTR19 NUMBER,
	N_EXT_ATTR20 NUMBER,
	N_EXT_ATTR21 NUMBER,
	N_EXT_ATTR22 NUMBER,
	N_EXT_ATTR23 NUMBER,
	N_EXT_ATTR24 NUMBER,
	N_EXT_ATTR25 NUMBER,
	C_EXT_ATTR31 VARCHAR2(500),
	C_EXT_ATTR32 VARCHAR2(500),
	C_EXT_ATTR33 VARCHAR2(500),
	C_EXT_ATTR34 VARCHAR2(500),
	C_EXT_ATTR35 VARCHAR2(500),
	C_EXT_ATTR36 VARCHAR2(500),
	C_EXT_ATTR37 VARCHAR2(500),
	C_EXT_ATTR38 VARCHAR2(500),
	C_EXT_ATTR39 VARCHAR2(500),
	C_EXT_ATTR40 VARCHAR2(500),
	C_EXT_ATTR41 VARCHAR2(500),
	C_EXT_ATTR42 VARCHAR2(500),
	C_EXT_ATTR43 VARCHAR2(500),
	C_EXT_ATTR44 VARCHAR2(500),
	ADDRESS2 VARCHAR2(100),
	OUTBOUND_INTEG_FLAG VARCHAR2(1),
	N_EXT_ATTR26 NUMBER,
	N_EXT_ATTR27 NUMBER,
	N_EXT_ATTR28 NUMBER,
	N_EXT_ATTR29 NUMBER,
	N_EXT_ATTR30 NUMBER,
	C_EXT_ATTR45 VARCHAR2(500),
	MI_PRINX NUMBER,
	SITE_ID NUMBER,
	 PRIMARY KEY (STORE_ID)
  USING INDEX  ENABLE
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

