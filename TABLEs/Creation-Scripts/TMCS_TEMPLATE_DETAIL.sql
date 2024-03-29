CREATE TABLE TMCS_TEMPLATE_DETAIL
   (	TEMP_DETAIL_ID NUMBER,
	TEMPLATE_ID NUMBER,
	LINE_ITEM_NAME VARCHAR2(250),
	DESCRIPTION VARCHAR2(4000),
	ITEM_TYPE VARCHAR2(250),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	COUNTRY VARCHAR2(100),
	LINE_ITEM_SEQ NUMBER,
	TAX_CODE VARCHAR2(100),
	ITEM_AMOUNT NUMBER,
	DIVISION VARCHAR2(250),
	SEGMENT1 VARCHAR2(100),
	SEGMENT2 VARCHAR2(100),
	SEGMENT3 VARCHAR2(100),
	SEGMENT4 VARCHAR2(100),
	SEGMENT5 VARCHAR2(100),
	SEGMENT6 VARCHAR2(100),
	ACCT_CODE VARCHAR2(500),
	FORMULA_ID NUMBER,
	SUB_LINE_ITEM_NAME VARCHAR2(250),
	BUDGET_LINE_TYPE VARCHAR2(100),
	ROLLUP_FLAG VARCHAR2(100),
	SUB_ITEM_TYPE VARCHAR2(250),
	QUANTITY NUMBER,
	RATE NUMBER,
	UNIT VARCHAR2(100),
	LONG_LEAD VARCHAR2(100),
	FORMULA VARCHAR2(4000),
	MILESTONE_TEMPLATE_ID NUMBER,
	TASK_NUMBER NUMBER,
	DEPR_LIFE NUMBER,
	DEPARTMENT VARCHAR2(500),
	RESPONSIBILTY VARCHAR2(100),
	COST NUMBER,
	MAINTENANCE VARCHAR2(100),
	DISP_SEQ NUMBER,
	DATA_ENTRY_LEVEL VARCHAR2(100),
	LINE_TYPE VARCHAR2(100),
	C_EXT_LOV2 VARCHAR2(50),
	C_EXT_LOV3 VARCHAR2(50),
	C_EXT_LOV4 VARCHAR2(50),
	C_EXT_LOV5 VARCHAR2(50),
	C_EXT_LOV6 VARCHAR2(50),
	C_EXT_LOV7 VARCHAR2(50),
	C_EXT_LOV8 VARCHAR2(50),
	C_EXT_LOV9 VARCHAR2(50),
	COMMENTS1 VARCHAR2(4000),
	COMMENTS2 VARCHAR2(4000),
	COMMENTS3 VARCHAR2(4000),
	VERSION NUMBER,
	 PRIMARY KEY (TEMP_DETAIL_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX TMCS_TEMPLATE_DETAIL_01 ON TMCS_TEMPLATE_DETAIL (TEMPLATE_ID)
  ;

