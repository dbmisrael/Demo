CREATE TABLE TMCS_LANDS
   (	LAND_ID NUMBER,
	LAND_NUMBER VARCHAR2(50),
	LAND_NAME VARCHAR2(200 CHAR),
	ADDRESS1 VARCHAR2(500),
	ADDRESS2 VARCHAR2(500),
	ADDRESS3 VARCHAR2(500),
	CITY VARCHAR2(50),
	STATE VARCHAR2(50),
	COUNTY VARCHAR2(50),
	COUNTY_FIPS VARCHAR2(250),
	NEIGHBORHOOD VARCHAR2(100),
	COUNTRY VARCHAR2(50),
	ZIP VARCHAR2(50),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	STATUS VARCHAR2(50),
	MARKET_NAME VARCHAR2(50),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	LAND_SIZE NUMBER,
	OPEN_DATE DATE,
	CLOSE_DATE DATE,
	LEASE_EXP_DATE DATE,
	LEASE_OPTION VARCHAR2(50),
	CBSA_CLASS VARCHAR2(50),
	STORE_CLASS VARCHAR2(50),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	OPERATIONS_REGION VARCHAR2(100),
	CENSUS_REGION VARCHAR2(320),
	CENSUS_DIVISION VARCHAR2(320),
	LAND_TYPE VARCHAR2(250),
	OWNERSHIP_TYPE VARCHAR2(50),
	FACILITY_TYPE VARCHAR2(50),
	ASSET_TYPE VARCHAR2(200),
	FISCAL_PERIOD NUMBER,
	FISCAL_YEAR NUMBER,
	FISCAL_QUARTER NUMBER,
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
	D_EXT_ATTR16 DATE,
	D_EXT_ATTR17 DATE,
	D_EXT_ATTR18 DATE,
	D_EXT_ATTR19 DATE,
	D_EXT_ATTR20 DATE,
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
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	ORG_ID NUMBER(*,0),
	SITE_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   )
  COLUMN GEOMETRY NOT SUBSTITUTABLE AT ALL LEVELS
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_LANDS_PK ON TMCS_LANDS (LAND_ID)
  ;
ALTER TABLE TMCS_LANDS ADD CONSTRAINT TMCS_LANDS_PK PRIMARY KEY (LAND_ID)
  USING INDEX TMCS_LANDS_PK  ENABLE;
CREATE INDEX TMCS_LANDS_CL_INDX ON TMCS_LANDS (LAND_NUMBER, CLIENT_ID)
  ;
CREATE INDEX TMCS_LANDS_GIDX ON TMCS_LANDS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_LANDS_PK ON TMCS_LANDS (LAND_ID)
  ;
CREATE INDEX LAND_UPPER_STATUS_IDX ON TMCS_LANDS (UPPER(STATUS))
  ;
