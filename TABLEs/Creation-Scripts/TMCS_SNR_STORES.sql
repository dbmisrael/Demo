CREATE TABLE TMCS_SNR_STORES
   (	SCENARIO_ID NUMBER NOT NULL ENABLE,
	STORE_ID NUMBER NOT NULL ENABLE,
	STORE_NUMBER VARCHAR2(20),
	STORE_NAME VARCHAR2(256),
	ADDRESS VARCHAR2(150),
	CITY VARCHAR2(100),
	STATE VARCHAR2(100),
	ZIP VARCHAR2(100),
	SELECT_FLAG VARCHAR2(1),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	TOTAL_SALES NUMBER(22,2),
	SQ_FOOT NUMBER(22,2),
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
	D_EXT_ATTR01 DATE,
	D_EXT_ATTR02 DATE,
	D_EXT_ATTR03 DATE,
	D_EXT_ATTR04 DATE,
	D_EXT_ATTR05 DATE,
	BRAND_ID NUMBER(*,0),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	PCT_IMPACT NUMBER,
	STORE_TYPE VARCHAR2(250),
	SEC_ATTR1 VARCHAR2(50),
	SEC_ATTR2 VARCHAR2(50)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_SNR_STORES_PK ON TMCS_SNR_STORES (SCENARIO_ID, STORE_ID)
  ;
ALTER TABLE TMCS_SNR_STORES ADD CONSTRAINT TMCS_SNR_STORES_PK PRIMARY KEY (SCENARIO_ID, STORE_ID)
  USING INDEX TMCS_SNR_STORES_PK  ENABLE;
CREATE INDEX TMCS_SNR_STORES_GIDX ON TMCS_SNR_STORES (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_SNR_STORES_PK ON TMCS_SNR_STORES (SCENARIO_ID, STORE_ID)
  ;

