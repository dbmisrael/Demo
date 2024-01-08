CREATE TABLE TMCS_SNR_OPTIMIZATION
   (	OPTIMIZATION_ID VARCHAR2(10) NOT NULL ENABLE,
	SCENARIO_ID NUMBER(10,0) NOT NULL ENABLE,
	NAME VARCHAR2(100),
	ADDRESS VARCHAR2(200),
	CITY VARCHAR2(50),
	STATE VARCHAR2(50),
	ZIP VARCHAR2(10),
	COUNTRY VARCHAR2(50),
	SIS_TYPE VARCHAR2(25),
	CBSA_CLASS NUMBER(*,0),
	STORE_CLASS VARCHAR2(25),
	LATITUDE NUMBER,
	LONGITUDE NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	OPEN_DATE DATE,
	SALES_ESTIMATE NUMBER,
	CANNIBALIZATION_ESTIMATE NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	C_EXT_ATTR01 VARCHAR2(100),
	C_EXT_ATTR02 VARCHAR2(100),
	C_EXT_ATTR03 VARCHAR2(100),
	C_EXT_ATTR04 VARCHAR2(100),
	C_EXT_ATTR05 VARCHAR2(100),
	C_EXT_ATTR06 VARCHAR2(100),
	C_EXT_ATTR07 VARCHAR2(100),
	C_EXT_ATTR08 VARCHAR2(100),
	C_EXT_ATTR09 VARCHAR2(100),
	C_EXT_ATTR10 VARCHAR2(100),
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
	ERROR_DETAIL VARCHAR2(1000),
	SALES_ESTIMATE2 NUMBER,
	SALES_ESTIMATE3 NUMBER,
	SALES_ESTIMATE4 NUMBER,
	SALES_ESTIMATE5 NUMBER,
	BRAND_ID NUMBER,
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	SELECT_FLAG VARCHAR2(10) DEFAULT 'Y',
	COUNTY VARCHAR2(500),
	COUNTY_FIPS VARCHAR2(500),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	SEC_ATTR1 VARCHAR2(50),
	SEC_ATTR2 VARCHAR2(50)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_SNR_OPTIMIZATION_PK ON TMCS_SNR_OPTIMIZATION (OPTIMIZATION_ID, SCENARIO_ID)
  ;
ALTER TABLE TMCS_SNR_OPTIMIZATION ADD CONSTRAINT TMCS_SNR_OPTIMIZATION_PK PRIMARY KEY (OPTIMIZATION_ID, SCENARIO_ID)
  USING INDEX TMCS_SNR_OPTIMIZATION_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SNR_OPTIMIZATION_PK ON TMCS_SNR_OPTIMIZATION (OPTIMIZATION_ID, SCENARIO_ID)
  ;
CREATE INDEX TMCS_SNR_OPTIMIZATION_GIDX ON TMCS_SNR_OPTIMIZATION (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
