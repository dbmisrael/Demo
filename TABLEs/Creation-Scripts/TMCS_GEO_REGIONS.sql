CREATE TABLE TMCS_GEO_REGIONS
   (	REGION_ID NUMBER DEFAULT TMCS_GEO_REGIONS_S.NEXTVAL,
	REGION VARCHAR2(100),
	GEOMETRY SDO_GEOMETRY,
	COUNTRY VARCHAR2(50),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	ORG_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
	HIERARCHY_TYPE VARCHAR2(100),
	HDR_C_EXT_ATTR1 VARCHAR2(256),
	HDR_C_EXT_ATTR2 VARCHAR2(256),
	HDR_C_EXT_ATTR3 VARCHAR2(256),
	HDR_C_EXT_ATTR4 VARCHAR2(256),
	HDR_C_EXT_ATTR5 VARCHAR2(256),
	HDR_C_EXT_ATTR6 VARCHAR2(256),
	HDR_C_EXT_ATTR7 VARCHAR2(256),
	HDR_C_EXT_ATTR8 VARCHAR2(256),
	HDR_C_EXT_ATTR9 VARCHAR2(256),
	HDR_C_EXT_ATTR10 VARCHAR2(256),
	HDR_N_EXT_ATTR1 NUMBER,
	HDR_N_EXT_ATTR2 NUMBER,
	HDR_N_EXT_ATTR3 NUMBER,
	HDR_N_EXT_ATTR4 NUMBER,
	HDR_N_EXT_ATTR5 NUMBER,
	HDR_D_EXT_ATTR1 DATE,
	HDR_D_EXT_ATTR2 DATE,
	HDR_D_EXT_ATTR3 DATE,
	HDR_D_EXT_ATTR4 DATE,
	HDR_D_EXT_ATTR5 DATE,
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
	OVR_C_EXT_ATTR1 VARCHAR2(4000),
	OVR_C_EXT_ATTR2 VARCHAR2(4000),
	OVR_C_EXT_ATTR3 VARCHAR2(4000),
	OVR_C_EXT_ATTR4 VARCHAR2(4000),
	OVR_C_EXT_ATTR5 VARCHAR2(4000),
	OVR_C_EXT_ATTR6 VARCHAR2(4000),
	OVR_C_EXT_ATTR7 VARCHAR2(4000),
	OVR_C_EXT_ATTR8 VARCHAR2(4000),
	OVR_C_EXT_ATTR9 VARCHAR2(4000),
	OVR_C_EXT_ATTR10 VARCHAR2(4000),
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
	 PRIMARY KEY (REGION_ID)
  USING INDEX  ENABLE
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_GEO_REGIONS_GIDX ON TMCS_GEO_REGIONS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

