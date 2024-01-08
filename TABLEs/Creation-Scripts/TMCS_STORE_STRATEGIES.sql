CREATE TABLE TMCS_STORE_STRATEGIES
   (	STORE_STRATEGY_ID NUMBER,
	STORE_ID NUMBER,
	STRATEGY VARCHAR2(50),
	FISCAL_YEAR NUMBER,
	FISCAL_PERIOD NUMBER,
	COMMENTS VARCHAR2(4000),
	EFFECTIVE_DATE DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	C_EXT_ATTR1 VARCHAR2(250),
	C_EXT_ATTR2 VARCHAR2(250),
	C_EXT_ATTR3 VARCHAR2(250),
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200),
	PROJECT_ID NUMBER,
	FISCAL_MONTH VARCHAR2(50),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	C_EXT_LOV6 VARCHAR2(200),
	C_EXT_LOV7 VARCHAR2(200),
	C_EXT_LOV8 VARCHAR2(200),
	C_EXT_LOV9 VARCHAR2(200),
	C_EXT_LOV10 VARCHAR2(200),
	FISCAL_QUARTER NUMBER,
	COMPLETED VARCHAR2(10),
	COMPLETION_DATE DATE,
	PROJECTED_COMPLETION_DATE DATE,
	CAPITAL_COST NUMBER,
	EXPENSE_COST NUMBER,
	RENT_CHANGE NUMBER,
	COST_REDUCTION NUMBER,
	EXPENSE_AVOIDANCE NUMBER,
	ADDITIONAL_SALES NUMBER,
	PRIORITY VARCHAR2(50),
	SUB_STRATEGY VARCHAR2(50),
	IS_CONFIDENTIAL VARCHAR2(100),
	DECOMM_RATE_PER_UNIT NUMBER,
	MOVE_RATE_PER_UNIT NUMBER,
	UPFIT_RATE_PER_UNIT NUMBER,
	DECOMM_COST NUMBER,
	MOVE_COST NUMBER,
	GROSS_CAPITAL NUMBER,
	STRATEGY_GROUP_ID NUMBER,
	RSF_CHANGE NUMBER,
	STRATEGY_SF NUMBER,
	NO_OF_MOVES NUMBER,
	NET_CAPITAL NUMBER,
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
	N_EXT_ATTR6 NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_STORE_STRATEGIES_PK ON TMCS_STORE_STRATEGIES (STORE_STRATEGY_ID)
  ;
ALTER TABLE TMCS_STORE_STRATEGIES ADD CONSTRAINT TMCS_STORE_STRATEGIES_PK PRIMARY KEY (STORE_STRATEGY_ID)
  USING INDEX TMCS_STORE_STRATEGIES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_STORE_STRATEGIES_PK ON TMCS_STORE_STRATEGIES (STORE_STRATEGY_ID)
  ;
