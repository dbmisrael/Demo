CREATE TABLE TMCS_TRANSACTIONS
   (	TRANS_ID NUMBER DEFAULT TMCS_TRANSACTIONS_S.NEXTVAL,
	TRANS_NAME VARCHAR2(256),
	TRANS_TYPE VARCHAR2(256),
	TRANS_SUB_TYPE VARCHAR2(256),
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(256),
	INTERSECTION VARCHAR2(100),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	ADDRESS VARCHAR2(500),
	ADDRESS2 VARCHAR2(100),
	ADDRESS3 VARCHAR2(100),
	DMA VARCHAR2(120),
	CITY VARCHAR2(100),
	COUNTY VARCHAR2(100),
	STATE VARCHAR2(100),
	ZIP_CODE VARCHAR2(20),
	COUNTRY VARCHAR2(100),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	STATUS VARCHAR2(50),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
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
	C_EXT_ATTR36 VARCHAR2(4000),
	C_EXT_ATTR37 VARCHAR2(500),
	C_EXT_ATTR38 VARCHAR2(500),
	C_EXT_ATTR39 VARCHAR2(500),
	C_EXT_ATTR40 VARCHAR2(500),
	C_EXT_ATTR41 VARCHAR2(500),
	C_EXT_ATTR42 VARCHAR2(500),
	C_EXT_ATTR43 VARCHAR2(500),
	C_EXT_ATTR44 VARCHAR2(500),
	C_EXT_ATTR45 VARCHAR2(500),
	C_EXT_ATTR50 VARCHAR2(500),
	C_EXT_ATTR49 VARCHAR2(500),
	C_EXT_ATTR46 VARCHAR2(500),
	C_EXT_ATTR47 VARCHAR2(500),
	C_EXT_ATTR48 VARCHAR2(500),
	C_EXT_ATTR51 VARCHAR2(500),
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
	N_EXT_ATTR33 NUMBER,
	N_EXT_ATTR34 NUMBER,
	N_EXT_ATTR35 NUMBER,
	N_EXT_ATTR36 NUMBER,
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
	D_EXT_ATTR21 DATE,
	D_EXT_ATTR22 DATE,
	D_EXT_ATTR23 DATE,
	D_EXT_ATTR24 DATE,
	D_EXT_ATTR25 DATE,
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
	SQ_STATUS VARCHAR2(32),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	COUNTY_FIPS VARCHAR2(250),
	PROPOSED_START_DATE DATE,
	STRENGTH VARCHAR2(4000),
	WEAKNESS VARCHAR2(4000),
	OPPORTUNITY VARCHAR2(4000),
	THREAT VARCHAR2(4000),
	SWOT_DESCRIPTION VARCHAR2(4000),
	CENSUS_REGION VARCHAR2(320),
	CENSUS_DIVISION VARCHAR2(320),
	WF_STATUS VARCHAR2(50),
	OWNERSHIP_TYPE VARCHAR2(50),
	SDA_ID NUMBER,
	FISCAL_PERIOD NUMBER,
	FISCAL_YEAR NUMBER,
	FISCAL_QUARTER NUMBER,
	FFE_BUDGET_TEMPLATE_ID NUMBER,
	REAL_ESTATE_HIERARCHY_ID NUMBER,
	OPERATION_HIRERARCHY_ID NUMBER,
	SEC_ATTR1 VARCHAR2(100),
	SEC_ATTR2 VARCHAR2(100),
	CURRENCY VARCHAR2(50),
	NEW_RENTABLE_AREA NUMBER,
	TRANSACTION_MANAGER VARCHAR2(100),
	NEGOTIATOR VARCHAR2(100),
	STRATEGY_ID NUMBER,
	STRATEGY_APPROVED VARCHAR2(10),
	TEMPLATE_ID NUMBER,
	TRANS_SUB_ID NUMBER,
	BOV NUMBER,
	TARGET_RENT_PSF NUMBER,
	DECISION VARCHAR2(100),
	DECISION_RATIONALE VARCHAR2(4000),
	COMMENTS VARCHAR2(4000),
	REQUESTED_BY VARCHAR2(100),
	TARGET_RENT NUMBER,
	LANDLORD_CONTRIBUTIONS NUMBER,
	TOTAL_LL_LEASE_COUNT NUMBER,
	MASTER_LANDLORD VARCHAR2(500),
	FUTURE_SAVINGS NUMBER,
	IMMEDIATE_SAVINGS NUMBER,
	TOTAL_IMMEDIATE_SAVINGS NUMBER,
	TOTAL_SAVINGS NUMBER,
	FREE_RENT NUMBER,
	ALL_YR1_RENT_SAVINGS NUMBER,
	ALL_YR1_SAVINGS NUMBER,
	ENTITY_EMAIL VARCHAR2(500),
	NEW_FINAL_NOTICE_DATE DATE,
	REVIEW_YN VARCHAR2(10),
	APPROVAL_DATE DATE,
	APPROVED_BY VARCHAR2(200),
	TRANSACTION_GROUP VARCHAR2(200),
	DIVISION1 VARCHAR2(200),
	DIVISION2 VARCHAR2(200)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB  ENABLE ROW MOVEMENT ;
  CREATE UNIQUE INDEX TMCS_TRANSACTIONS_PK ON TMCS_TRANSACTIONS (TRANS_ID)
  ;
ALTER TABLE TMCS_TRANSACTIONS ADD CONSTRAINT TMCS_TRANSACTIONS_PK PRIMARY KEY (TRANS_ID)
  USING INDEX TMCS_TRANSACTIONS_PK  ENABLE;
CREATE INDEX TMCS_TRANSACTIONS_INDX1 ON TMCS_TRANSACTIONS (CLIENT_ID)
  ;
CREATE INDEX TMCS_TRANSACTIONS_GIDX ON TMCS_TRANSACTIONS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_TRANSACTIONS_PK ON TMCS_TRANSACTIONS (TRANS_ID)
  ;

