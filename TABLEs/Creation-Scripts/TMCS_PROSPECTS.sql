CREATE TABLE TMCS_PROSPECTS
   (	PROSPECT_ID NUMBER,
	PROSPECT_BATCH NUMBER,
	PROSPECT_SEQ NUMBER,
	PROJECT_NAME VARCHAR2(100),
	ADDRESS VARCHAR2(100),
	CITY VARCHAR2(100),
	STATE VARCHAR2(150),
	ZIP_CODE VARCHAR2(10),
	LATITUDE NUMBER,
	LONGITUDE NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	DEV_MANAGER VARCHAR2(50),
	STORE_TYPE VARCHAR2(50),
	DRIVE_THRU VARCHAR2(50),
	TARGET_ID NUMBER,
	STATUS VARCHAR2(20),
	PROX_ISSUE VARCHAR2(1),
	PROX_ISSUE_COMMENTS VARCHAR2(4000),
	SDA_ISSUE VARCHAR2(1),
	SDA_ISSUE_COMMENTS VARCHAR2(4000),
	STAGING_FLAG VARCHAR2(20),
	COMMENTS VARCHAR2(4000),
	C_EXT_ATTR01 VARCHAR2(500),
	C_EXT_ATTR02 VARCHAR2(500),
	C_EXT_ATTR03 VARCHAR2(500),
	C_EXT_ATTR04 VARCHAR2(500),
	C_EXT_ATTR05 VARCHAR2(500),
	C_EXT_ATTR06 VARCHAR2(500),
	C_EXT_ATTR07 VARCHAR2(500),
	C_EXT_ATTR08 VARCHAR2(500),
	C_EXT_ATTR09 VARCHAR2(500),
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
	C_EXT_ATTR27 VARCHAR2(500),
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
	C_EXT_ATTR40 VARCHAR2(500),
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
	DEMO_FLAG VARCHAR2(1) DEFAULT 'N',
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	UPLOAD_STATUS VARCHAR2(100),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	COUNTY_FIPS VARCHAR2(250),
	COUNTY VARCHAR2(100),
	SC_ID VARCHAR2(50),
	N_EXT_ATTR21 NUMBER,
	N_EXT_ATTR22 NUMBER,
	N_EXT_ATTR23 NUMBER,
	N_EXT_ATTR24 NUMBER,
	N_EXT_ATTR25 NUMBER,
	CENSUS_REGION VARCHAR2(320),
	CENSUS_DIVISION VARCHAR2(320),
	OWNERSHIP_TYPE VARCHAR2(50),
	COUNTRY VARCHAR2(250),
	C_EXT_LOV1 VARCHAR2(100),
	C_EXT_LOV2 VARCHAR2(100),
	C_EXT_LOV3 VARCHAR2(100),
	C_EXT_LOV4 VARCHAR2(100),
	C_EXT_LOV5 VARCHAR2(100),
	C_EXT_ATTR41 VARCHAR2(500),
	C_EXT_ATTR42 VARCHAR2(500),
	C_EXT_ATTR43 VARCHAR2(500),
	C_EXT_ATTR44 VARCHAR2(500),
	C_EXT_ATTR45 VARCHAR2(500),
	C_EXT_ATTR46 VARCHAR2(500),
	C_EXT_ATTR47 VARCHAR2(500),
	C_EXT_ATTR48 VARCHAR2(500),
	C_EXT_ATTR49 VARCHAR2(500),
	C_EXT_ATTR50 VARCHAR2(500),
	C_EXT_LOV6 VARCHAR2(100),
	C_EXT_LOV7 VARCHAR2(100),
	C_EXT_LOV8 VARCHAR2(100),
	C_EXT_LOV9 VARCHAR2(100),
	C_EXT_LOV10 VARCHAR2(100)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_PROSPECTS_PK ON TMCS_PROSPECTS (PROSPECT_ID)
  ;
ALTER TABLE TMCS_PROSPECTS ADD CONSTRAINT TMCS_PROSPECTS_PK PRIMARY KEY (PROSPECT_ID)
  USING INDEX TMCS_PROSPECTS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_PROSPECTS_PK ON TMCS_PROSPECTS (PROSPECT_ID)
  ;
CREATE INDEX TMCS_PROSPECTS_SFLAG_IDX ON TMCS_PROSPECTS (STAGING_FLAG)
  ;
CREATE INDEX TMCS_PROSPECTS_GIDX ON TMCS_PROSPECTS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

