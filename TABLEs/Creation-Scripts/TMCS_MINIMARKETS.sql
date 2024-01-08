CREATE TABLE TMCS_MINIMARKETS
   (	ID NUMBER NOT NULL ENABLE,
	AREA NUMBER,
	MM_ID VARCHAR2(500),
	NAME VARCHAR2(500),
	DMA_ID VARCHAR2(500),
	COUNTRY VARCHAR2(500),
	CCSTYLE NUMBER,
	COUNTY_FIPS VARCHAR2(500),
	COUNTY_NAME VARCHAR2(500),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(500),
	CBSA_ID NUMBER,
	CBSA_NUMBER VARCHAR2(500),
	COLOR NUMBER,
	MI_PRINX NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	DMA_NAME VARCHAR2(500),
	EFF_DATE DATE,
	AMEND_DATE DATE,
	EXP_DATE DATE,
	COMMENTS VARCHAR2(4000),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
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
	N_EXT_ATTR31 NUMBER,
	N_EXT_ATTR32 NUMBER,
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
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
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
	DEMO_EXT_ATTR26 NUMBER,
	DEMO_EXT_ATTR27 NUMBER,
	DEMO_EXT_ATTR28 NUMBER,
	DEMO_EXT_ATTR29 NUMBER,
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
	DEMO_EXT_ATTR41 NUMBER,
	DEMO_EXT_ATTR42 NUMBER,
	DEMO_EXT_ATTR43 NUMBER,
	DEMO_EXT_ATTR44 NUMBER,
	DEMO_EXT_ATTR45 NUMBER,
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
	DEVFOCUS VARCHAR2(60),
	 CONSTRAINT ID_PK PRIMARY KEY (ID)
  USING INDEX  ENABLE
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_MINIMARKETS_GIDX ON TMCS_MINIMARKETS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

