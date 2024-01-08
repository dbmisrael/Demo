CREATE TABLE TMCS_ALL_STORES_TA
   (	STORE_ID NUMBER,
	STORE_NUMBER VARCHAR2(256),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	MI_PRINX NUMBER,
	DESCRIPTION VARCHAR2(250),
	CURRENT_STATUS VARCHAR2(55),
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
	C_EXT_ATTR1 VARCHAR2(150),
	C_EXT_ATTR2 VARCHAR2(150),
	C_EXT_ATTR3 VARCHAR2(150),
	C_EXT_ATTR4 VARCHAR2(150),
	C_EXT_ATTR5 VARCHAR2(150),
	C_EXT_ATTR6 VARCHAR2(150),
	C_EXT_ATTR7 VARCHAR2(150),
	C_EXT_ATTR8 VARCHAR2(150),
	C_EXT_ATTR9 VARCHAR2(150),
	C_EXT_ATTR10 VARCHAR2(150),
	C_EXT_ATTR11 VARCHAR2(150),
	C_EXT_ATTR12 VARCHAR2(150),
	C_EXT_ATTR13 VARCHAR2(150),
	C_EXT_ATTR14 VARCHAR2(150),
	C_EXT_ATTR15 VARCHAR2(150),
	C_EXT_ATTR16 VARCHAR2(150),
	C_EXT_ATTR17 VARCHAR2(150),
	C_EXT_ATTR18 VARCHAR2(150),
	C_EXT_ATTR19 VARCHAR2(150),
	C_EXT_ATTR20 VARCHAR2(150),
	N_EXT_ATTR31 NUMBER,
	N_EXT_ATTR32 NUMBER,
	DEMO_SCORE NUMBER,
	SCORE1 NUMBER,
	SCORE2 NUMBER,
	N_EXT_ATTR33 NUMBER,
	N_EXT_ATTR34 NUMBER,
	N_EXT_ATTR35 NUMBER,
	N_EXT_ATTR36 NUMBER,
	N_EXT_ATTR37 NUMBER,
	N_EXT_ATTR38 NUMBER,
	N_EXT_ATTR39 NUMBER,
	N_EXT_ATTR40 NUMBER,
	TA_TYPE VARCHAR2(50),
	PRIMARY_FLAG VARCHAR2(5),
	TRADEAREA_ID NUMBER,
	N_EXT_ATTR41 NUMBER,
	N_EXT_ATTR42 NUMBER,
	N_EXT_ATTR43 NUMBER,
	N_EXT_ATTR44 NUMBER,
	N_EXT_ATTR45 NUMBER,
	N_EXT_ATTR46 NUMBER,
	N_EXT_ATTR47 NUMBER,
	N_EXT_ATTR48 NUMBER,
	N_EXT_ATTR49 NUMBER,
	N_EXT_ATTR50 NUMBER,
	TA_YEAR NUMBER
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_ALL_STORES_TA_PK ON TMCS_ALL_STORES_TA (TRADEAREA_ID)
  ;
ALTER TABLE TMCS_ALL_STORES_TA ADD CONSTRAINT TMCS_ALL_STORES_TA_PK PRIMARY KEY (TRADEAREA_ID)
  USING INDEX TMCS_ALL_STORES_TA_PK  ENABLE;
CREATE INDEX TMCS_ALL_STORES_TA_IDX3 ON TMCS_ALL_STORES_TA (TA_TYPE, PRIMARY_FLAG)
  ;
CREATE INDEX TMCS_ALL_STORES_TA_INDX2 ON TMCS_ALL_STORES_TA (STORE_ID)
  ;
CREATE INDEX TMCS_ALL_STORES_TA_GIDX ON TMCS_ALL_STORES_TA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_ALL_STORES_TA_PK ON TMCS_ALL_STORES_TA (TRADEAREA_ID)
  ;
