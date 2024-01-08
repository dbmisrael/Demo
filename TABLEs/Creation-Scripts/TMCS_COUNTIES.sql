CREATE TABLE TMCS_COUNTIES
   (	NAME VARCHAR2(64),
	KEY VARCHAR2(32),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY VARCHAR2(50),
	ORG_ID NUMBER,
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
	C_EXT_ATTR1 VARCHAR2(256),
	C_EXT_ATTR2 VARCHAR2(256),
	C_EXT_ATTR3 VARCHAR2(256),
	C_EXT_ATTR4 VARCHAR2(256),
	C_EXT_ATTR5 VARCHAR2(256),
	C_EXT_ATTR6 VARCHAR2(256),
	C_EXT_ATTR7 VARCHAR2(256),
	C_EXT_ATTR8 VARCHAR2(256),
	C_EXT_ATTR9 VARCHAR2(256),
	C_EXT_ATTR10 VARCHAR2(256),
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
	 CONSTRAINT TMCS_COUNTIES_PK PRIMARY KEY (KEY)
  USING INDEX  ENABLE
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_COUNTIES_GIDX ON TMCS_COUNTIES (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
