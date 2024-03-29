CREATE TABLE TMCS_ALL_COMPETITORS_CUST
   (	STORE_NUMBER VARCHAR2(150),
	STORE_NAME VARCHAR2(150 CHAR),
	ADDRESS VARCHAR2(500 CHAR),
	CITY VARCHAR2(50 CHAR),
	STATE VARCHAR2(100 CHAR),
	ZIP VARCHAR2(50 CHAR),
	PHONE VARCHAR2(250),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	COUNTRY VARCHAR2(100) NOT NULL ENABLE,
	SALES NUMBER,
	COMPETITOR_ID NUMBER NOT NULL ENABLE,
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
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
	MI_PRINX NUMBER,
	C_EXT_ATTR16 VARCHAR2(500),
	C_EXT_ATTR17 VARCHAR2(500),
	C_EXT_ATTR18 VARCHAR2(500),
	C_EXT_ATTR19 VARCHAR2(500),
	C_EXT_ATTR20 VARCHAR2(500),
	LATITUDE NUMBER,
	LONGITUDE NUMBER,
	C_EXT_ATTR21 VARCHAR2(320),
	C_EXT_ATTR22 VARCHAR2(320),
	COMP_SOURCE VARCHAR2(320),
	STATUS VARCHAR2(50),
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200),
	D_EXT_ATTR6 DATE,
	D_EXT_ATTR7 DATE,
	D_EXT_ATTR8 DATE,
	D_EXT_ATTR9 DATE,
	D_EXT_ATTR10 DATE,
	COMMENTS VARCHAR2(4000),
	GROUP_LEVEL1 VARCHAR2(30),
	GROUP_LEVEL2 VARCHAR2(30),
	C_EXT_ATTR23 VARCHAR2(500),
	C_EXT_ATTR24 VARCHAR2(500),
	C_EXT_ATTR25 VARCHAR2(500),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250 CHAR),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250 CHAR),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250 CHAR),
	COUNTY VARCHAR2(100),
	COUNTY_FIPS VARCHAR2(250),
	C_EXT_LOV6 VARCHAR2(200),
	C_EXT_LOV7 VARCHAR2(200),
	C_EXT_LOV8 VARCHAR2(200),
	C_EXT_LOV9 VARCHAR2(200),
	C_EXT_LOV10 VARCHAR2(200),
	CUST_C_EXT_ATTR1 VARCHAR2(500),
	CUST_C_EXT_ATTR2 VARCHAR2(500),
	CUST_C_EXT_ATTR3 VARCHAR2(500),
	CUST_C_EXT_ATTR4 VARCHAR2(500),
	CUST_C_EXT_ATTR5 VARCHAR2(500),
	CUST_C_EXT_ATTR6 VARCHAR2(500),
	CUST_C_EXT_ATTR7 VARCHAR2(500),
	CUST_C_EXT_ATTR8 VARCHAR2(500),
	CUST_C_EXT_ATTR9 VARCHAR2(500),
	CUST_C_EXT_ATTR10 VARCHAR2(500),
	CUST_C_EXT_ATTR11 VARCHAR2(500),
	CUST_C_EXT_ATTR12 VARCHAR2(500),
	CUST_C_EXT_ATTR13 VARCHAR2(500),
	CUST_C_EXT_ATTR14 VARCHAR2(500),
	CUST_C_EXT_ATTR15 VARCHAR2(500),
	CUST_N_EXT_ATTR1 NUMBER,
	CUST_N_EXT_ATTR2 NUMBER,
	CUST_N_EXT_ATTR3 NUMBER,
	CUST_N_EXT_ATTR4 NUMBER,
	CUST_N_EXT_ATTR5 NUMBER,
	CUST_N_EXT_ATTR6 NUMBER,
	CUST_N_EXT_ATTR7 NUMBER,
	CUST_N_EXT_ATTR8 NUMBER,
	CUST_N_EXT_ATTR9 NUMBER,
	CUST_N_EXT_ATTR10 NUMBER,
	CUST_N_EXT_ATTR11 NUMBER,
	CUST_N_EXT_ATTR12 NUMBER,
	CUST_N_EXT_ATTR13 NUMBER,
	CUST_N_EXT_ATTR14 NUMBER,
	CUST_N_EXT_ATTR15 NUMBER,
	CUST_D_EXT_ATTR1 DATE,
	CUST_D_EXT_ATTR2 DATE,
	CUST_D_EXT_ATTR3 DATE,
	CUST_D_EXT_ATTR4 DATE,
	CUST_D_EXT_ATTR5 DATE,
	CUST_C_EXT_ATTR16 VARCHAR2(500),
	CUST_C_EXT_ATTR17 VARCHAR2(500),
	CUST_C_EXT_ATTR18 VARCHAR2(500),
	CUST_C_EXT_ATTR19 VARCHAR2(500),
	CUST_C_EXT_ATTR20 VARCHAR2(500),
	CUST_LATITUDE NUMBER,
	CUST_LONGITUDE NUMBER,
	CUST_C_EXT_ATTR21 VARCHAR2(320),
	CUST_C_EXT_ATTR22 VARCHAR2(320),
	CUST_C_EXT_LOV1 VARCHAR2(200),
	CUST_C_EXT_LOV2 VARCHAR2(200),
	CUST_C_EXT_LOV3 VARCHAR2(200),
	CUST_C_EXT_LOV4 VARCHAR2(200),
	CUST_C_EXT_LOV5 VARCHAR2(200),
	CUST_D_EXT_ATTR6 DATE,
	CUST_D_EXT_ATTR7 DATE,
	CUST_D_EXT_ATTR8 DATE,
	CUST_D_EXT_ATTR9 DATE,
	CUST_D_EXT_ATTR10 DATE,
	CUST_C_EXT_ATTR23 VARCHAR2(500),
	CUST_C_EXT_ATTR24 VARCHAR2(500),
	CUST_C_EXT_ATTR25 VARCHAR2(500),
	CUST_C_EXT_LOV6 VARCHAR2(200),
	CUST_C_EXT_LOV7 VARCHAR2(200),
	CUST_C_EXT_LOV8 VARCHAR2(200),
	CUST_C_EXT_LOV9 VARCHAR2(200),
	CUST_C_EXT_LOV10 VARCHAR2(200),
	CUST_SALES NUMBER,
	C_EXT_ATTR26 VARCHAR2(200),
	C_EXT_ATTR27 VARCHAR2(200),
	C_EXT_ATTR28 VARCHAR2(200),
	C_EXT_ATTR29 VARCHAR2(200),
	C_EXT_ATTR30 VARCHAR2(200),
	C_EXT_ATTR31 VARCHAR2(200),
	C_EXT_ATTR32 VARCHAR2(200),
	C_EXT_ATTR33 VARCHAR2(200),
	C_EXT_ATTR34 VARCHAR2(200),
	C_EXT_ATTR35 VARCHAR2(200),
	C_EXT_ATTR36 VARCHAR2(200),
	C_EXT_ATTR37 VARCHAR2(200),
	C_EXT_ATTR38 VARCHAR2(200),
	C_EXT_ATTR39 VARCHAR2(200),
	C_EXT_ATTR40 VARCHAR2(200),
	C_EXT_ATTR41 VARCHAR2(200),
	C_EXT_ATTR42 VARCHAR2(200),
	C_EXT_ATTR43 VARCHAR2(200),
	C_EXT_ATTR44 VARCHAR2(200),
	C_EXT_ATTR45 VARCHAR2(200),
	C_EXT_ATTR46 VARCHAR2(200),
	C_EXT_ATTR47 VARCHAR2(200),
	C_EXT_ATTR48 VARCHAR2(200),
	C_EXT_ATTR49 VARCHAR2(200),
	C_EXT_ATTR50 VARCHAR2(200),
	C_EXT_ATTR51 VARCHAR2(200),
	C_EXT_ATTR52 VARCHAR2(200),
	C_EXT_ATTR53 VARCHAR2(200),
	C_EXT_ATTR54 VARCHAR2(200),
	C_EXT_ATTR55 VARCHAR2(200),
	C_EXT_ATTR56 VARCHAR2(200),
	C_EXT_ATTR57 VARCHAR2(200),
	C_EXT_ATTR58 VARCHAR2(200),
	C_EXT_ATTR59 VARCHAR2(200),
	C_EXT_ATTR60 VARCHAR2(200),
	C_EXT_ATTR61 VARCHAR2(200),
	C_EXT_ATTR62 VARCHAR2(200),
	C_EXT_ATTR63 VARCHAR2(200),
	C_EXT_ATTR64 VARCHAR2(200),
	C_EXT_ATTR65 VARCHAR2(200),
	C_EXT_ATTR66 VARCHAR2(200),
	C_EXT_ATTR67 VARCHAR2(200),
	C_EXT_ATTR68 VARCHAR2(200),
	C_EXT_ATTR69 VARCHAR2(200),
	C_EXT_ATTR70 VARCHAR2(200),
	C_EXT_ATTR71 VARCHAR2(200),
	C_EXT_ATTR72 VARCHAR2(200),
	C_EXT_ATTR73 VARCHAR2(200),
	C_EXT_ATTR74 VARCHAR2(200),
	C_EXT_ATTR75 VARCHAR2(200),
	CUST_C_EXT_ATTR26 VARCHAR2(200),
	CUST_C_EXT_ATTR27 VARCHAR2(200),
	CUST_C_EXT_ATTR28 VARCHAR2(200),
	CUST_C_EXT_ATTR29 VARCHAR2(200),
	CUST_C_EXT_ATTR30 VARCHAR2(200),
	CUST_C_EXT_ATTR31 VARCHAR2(200),
	CUST_C_EXT_ATTR32 VARCHAR2(200),
	CUST_C_EXT_ATTR33 VARCHAR2(200),
	CUST_C_EXT_ATTR34 VARCHAR2(200),
	CUST_C_EXT_ATTR35 VARCHAR2(200),
	CUST_C_EXT_ATTR36 VARCHAR2(200),
	CUST_C_EXT_ATTR37 VARCHAR2(200),
	CUST_C_EXT_ATTR38 VARCHAR2(200),
	CUST_C_EXT_ATTR39 VARCHAR2(200),
	CUST_C_EXT_ATTR40 VARCHAR2(200),
	CUST_C_EXT_ATTR41 VARCHAR2(200),
	CUST_C_EXT_ATTR42 VARCHAR2(200),
	CUST_C_EXT_ATTR43 VARCHAR2(200),
	CUST_C_EXT_ATTR44 VARCHAR2(200),
	CUST_C_EXT_ATTR45 VARCHAR2(200),
	CUST_C_EXT_ATTR46 VARCHAR2(200),
	CUST_C_EXT_ATTR47 VARCHAR2(200),
	CUST_C_EXT_ATTR48 VARCHAR2(200),
	CUST_C_EXT_ATTR49 VARCHAR2(200),
	CUST_C_EXT_ATTR50 VARCHAR2(200),
	CUST_C_EXT_ATTR51 VARCHAR2(200),
	CUST_C_EXT_ATTR52 VARCHAR2(200),
	CUST_C_EXT_ATTR53 VARCHAR2(200),
	CUST_C_EXT_ATTR54 VARCHAR2(200),
	CUST_C_EXT_ATTR55 VARCHAR2(200),
	CUST_C_EXT_ATTR56 VARCHAR2(200),
	CUST_C_EXT_ATTR57 VARCHAR2(200),
	CUST_C_EXT_ATTR58 VARCHAR2(200),
	CUST_C_EXT_ATTR59 VARCHAR2(200),
	CUST_C_EXT_ATTR60 VARCHAR2(200),
	CUST_C_EXT_ATTR61 VARCHAR2(200),
	CUST_C_EXT_ATTR62 VARCHAR2(200),
	CUST_C_EXT_ATTR63 VARCHAR2(200),
	CUST_C_EXT_ATTR64 VARCHAR2(200),
	CUST_C_EXT_ATTR65 VARCHAR2(200),
	CUST_C_EXT_ATTR66 VARCHAR2(200),
	CUST_C_EXT_ATTR67 VARCHAR2(200),
	CUST_C_EXT_ATTR68 VARCHAR2(200),
	CUST_C_EXT_ATTR69 VARCHAR2(200),
	CUST_C_EXT_ATTR70 VARCHAR2(200),
	CUST_C_EXT_ATTR71 VARCHAR2(200),
	CUST_C_EXT_ATTR72 VARCHAR2(200),
	CUST_C_EXT_ATTR73 VARCHAR2(200),
	CUST_C_EXT_ATTR74 VARCHAR2(200),
	CUST_C_EXT_ATTR75 VARCHAR2(200),
	N_EXT_ATTR16 NUMBER,
	N_EXT_ATTR17 NUMBER,
	N_EXT_ATTR18 NUMBER,
	N_EXT_ATTR19 NUMBER,
	N_EXT_ATTR20 NUMBER,
	CUST_N_EXT_ATTR16 NUMBER,
	CUST_N_EXT_ATTR17 NUMBER,
	CUST_N_EXT_ATTR18 NUMBER,
	CUST_N_EXT_ATTR19 NUMBER,
	CUST_N_EXT_ATTR20 NUMBER,
	ADDRESS2 VARCHAR2(500 CHAR),
	CATEGORIES VARCHAR2(500),
	CHAIN_ID NUMBER,
	CHAIN_NAME VARCHAR2(500),
	COUNTRY_CODE VARCHAR2(500),
	COUNTRY_NAME VARCHAR2(500),
	DISTRIBUTOR_NAME VARCHAR2(500 CHAR),
	FIRST_APPEARED VARCHAR2(500),
	GEO_ACCURACY VARCHAR2(500),
	HASH_ID VARCHAR2(1000),
	LABEL VARCHAR2(500 CHAR),
	LAST_VENDOR_UPDATE DATE,
	NAICS VARCHAR2(500),
	OTHER_FIELDS VARCHAR2(4000 CHAR),
	PARENT_CHAIN_ID NUMBER,
	PARENT_CHAIN_NAME VARCHAR2(500),
	SIC VARCHAR2(500),
	STATE_CODE VARCHAR2(500),
	STATE_NAME VARCHAR2(500 CHAR),
	STORE_HOURS VARCHAR2(500),
	STORE_TYPE VARCHAR2(500 CHAR),
	SOURCE VARCHAR2(50) DEFAULT 'CUSTOM',
	ADD_ATTRIBUTES CLOB
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_ALL_COMPETITORS_CUST_GIDX ON TMCS_ALL_COMPETITORS_CUST (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('WORK_TABLESPACE=SPTL_TS_INDX');
CREATE INDEX TMCS_ALL_COMPETITORS_FIDX01 ON TMCS_ALL_COMPETITORS_CUST (CLIENT_ID, UPPER(STORE_NAME))
  ;
CREATE INDEX TMCS_ALL_COMPETITORS_INDX ON TMCS_ALL_COMPETITORS_CUST (STATE)
  ;
CREATE UNIQUE INDEX TMCS_ALL_COMPETITORS_PK ON TMCS_ALL_COMPETITORS_CUST (COMPETITOR_ID, CLIENT_ID, BRAND_ID, COUNTRY)
  ;
CREATE INDEX TMCS_ALL_COMPETITORS_INDX1 ON TMCS_ALL_COMPETITORS_CUST (CITY)
  ;

