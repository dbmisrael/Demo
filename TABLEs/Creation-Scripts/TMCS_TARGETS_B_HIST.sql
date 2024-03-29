CREATE TABLE TMCS_TARGETS_B_HIST
   (	TARGET_ID NUMBER,
	TARGET_SOURCE VARCHAR2(100),
	TARGET_NAME VARCHAR2(256),
	INTERSECTION VARCHAR2(100),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	DMA VARCHAR2(100),
	ADDRESS VARCHAR2(250),
	CITY VARCHAR2(100),
	COUNTY VARCHAR2(100),
	STATE VARCHAR2(100),
	ZIP_CODE VARCHAR2(100),
	COUNTRY VARCHAR2(100),
	REAL_ESTATE_MANAGER VARCHAR2(50),
	PROPOSED_START_DATE DATE,
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	ANNUAL_PLAN NUMBER(4,0),
	CAPITAL_EXPENSE NUMBER,
	STATUS VARCHAR2(50),
	GAS VARCHAR2(50),
	GAS_OTHER VARCHAR2(50),
	STRATEGY VARCHAR2(50),
	STATE_MANAGER NUMBER,
	SITE_TYPE VARCHAR2(50),
	NEIGHBORHOOD VARCHAR2(50),
	DIVISION VARCHAR2(50),
	MINI_MARKET VARCHAR2(100),
	DEV_PHASING VARCHAR2(50),
	DEV_PRIORITY VARCHAR2(20),
	RE_COST_IN_TA VARCHAR2(500),
	DIFFICULTY_ENTRY VARCHAR2(20),
	ABILITY_IMAGE VARCHAR2(20),
	TRAFFIC_RATING VARCHAR2(20),
	DEV_TARGET_YEAR VARCHAR2(20),
	COMMENTS VARCHAR2(4000),
	TEIR VARCHAR2(255),
	TERRITORY_ID VARCHAR2(255),
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
	C_EXT_ATTR6 VARCHAR2(500),
	C_EXT_ATTR7 VARCHAR2(500),
	C_EXT_ATTR8 VARCHAR2(500),
	C_EXT_ATTR9 VARCHAR2(500),
	C_EXT_ATTR10 VARCHAR2(500),
	SITE_RATING NUMBER,
	ALLOC_DMAND NUMBER,
	SCALE_FACTR NUMBER,
	ADJ_DEMAND NUMBER,
	INIT_DEM NUMBER,
	TRANSFER NUMBER,
	PCT_XFER NUMBER,
	N_EXT_ATTR26 NUMBER,
	C_EXT_ATTR11 VARCHAR2(500),
	MI_PRINX NUMBER,
	TARGET_NUMBER VARCHAR2(100),
	SEED_ID VARCHAR2(30),
	C_EXT_ATTR16 VARCHAR2(500),
	C_EXT_ATTR17 VARCHAR2(500),
	C_EXT_ATTR12 VARCHAR2(500),
	C_EXT_ATTR13 VARCHAR2(500),
	C_EXT_ATTR14 VARCHAR2(500),
	C_EXT_ATTR15 VARCHAR2(500),
	CBSA_CLASS NUMBER,
	STORE_CLASS NUMBER,
	C_EXT_ATTR18 VARCHAR2(500),
	C_EXT_ATTR19 VARCHAR2(500),
	SC_ID NUMBER,
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
	TEMPLATE_ID NUMBER,
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
	N_EXT_ATTR37 NUMBER,
	N_EXT_ATTR38 NUMBER,
	N_EXT_ATTR39 NUMBER,
	N_EXT_ATTR40 NUMBER,
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
	C_EXT_ATTR20 VARCHAR2(500),
	C_EXT_ATTR21 VARCHAR2(2000),
	C_EXT_ATTR22 VARCHAR2(500),
	C_EXT_ATTR23 VARCHAR2(500),
	C_EXT_ATTR24 VARCHAR2(500),
	C_EXT_ATTR25 VARCHAR2(500),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250),
	MSA_ID NUMBER,
	MSA_NAME VARCHAR2(250),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250),
	COUNTY_FIPS VARCHAR2(250),
	C_EXT_LOV11 VARCHAR2(200),
	C_EXT_LOV12 VARCHAR2(200),
	C_EXT_LOV13 VARCHAR2(200),
	C_EXT_LOV14 VARCHAR2(200),
	C_EXT_LOV15 VARCHAR2(200),
	CONSTRUCTION_MANAGER VARCHAR2(100),
	PCT_IMPACT NUMBER,
	CENSUS_REGION VARCHAR2(320),
	CENSUS_DIVISION VARCHAR2(320),
	SDA_ID NUMBER,
	FRANCHISE_TYPE VARCHAR2(50),
	OWNERSHIP_TYPE VARCHAR2(50),
	SALES_FORECAST NUMBER,
	FACILITY_TYPE VARCHAR2(50),
	FISCAL_PERIOD NUMBER,
	FISCAL_YEAR NUMBER,
	FISCAL_QUARTER NUMBER,
	RISK VARCHAR2(50),
	C_EXT_LOV16 VARCHAR2(200),
	C_EXT_LOV17 VARCHAR2(200),
	C_EXT_LOV18 VARCHAR2(200),
	C_EXT_LOV19 VARCHAR2(200),
	C_EXT_LOV20 VARCHAR2(200),
	N_EXT_ATTR41 NUMBER,
	N_EXT_ATTR42 NUMBER,
	REAL_ESTATE_HIERARCHY_ID NUMBER,
	OPERATION_HIRERARCHY_ID NUMBER,
	COMMENTS1 VARCHAR2(4000),
	SALES_FORECAST2 NUMBER,
	SALES_FORECAST3 NUMBER,
	SALES_FORECAST4 NUMBER,
	SALES_FORECAST5 NUMBER,
	TIMEZONE VARCHAR2(100),
	SEC_ATTR1 VARCHAR2(100),
	SEC_ATTR2 VARCHAR2(100),
	ASSET_TYPE VARCHAR2(100),
	PARENT_SDA_ID NUMBER,
	UOM VARCHAR2(50),
	PRODUCT_LIST VARCHAR2(50),
	PROFIT_CENTER VARCHAR2(50),
	COST_CENTER VARCHAR2(50),
	INTERNAL_ORDER VARCHAR2(50),
	INDEX_GROUP VARCHAR2(50)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

