CREATE TABLE TMCS_BUDGET_VERSION_DETAIL
   (	BUDGET_VERSION_DTL_ID NUMBER DEFAULT TMCS_BUDGET_VERSION_DETAIL_S.NEXTVAL,
	BUDGET_VERSION NUMBER,
	TASK_NAME VARCHAR2(100),
	DESCRIPTION VARCHAR2(1000),
	INITIAL_BUDGET NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	TASK_TYPE VARCHAR2(100),
	COMMENTS VARCHAR2(500),
	LINE_ITEM_SEQ NUMBER,
	DIVISION VARCHAR2(100),
	SEGMENT1 VARCHAR2(100),
	SEGMENT2 VARCHAR2(100),
	SEGMENT3 VARCHAR2(100),
	SEGMENT4 VARCHAR2(100),
	SEGMENT5 VARCHAR2(100),
	SEGMENT6 VARCHAR2(100),
	ACCT_CODE VARCHAR2(500),
	BUDGET_TEMPLATE_DTL_ID NUMBER,
	INITIAL_TEMPLATE_AMOUNT NUMBER,
	BUDGET_LINE_TYPE VARCHAR2(100),
	ROLLUP_FLAG VARCHAR2(100),
	SUB_TASK_NAME VARCHAR2(250),
	SUB_TASK_TYPE VARCHAR2(250),
	TASK_NUMBER NUMBER,
	EXPENSE_TYPE VARCHAR2(50),
	ACCOUNT_TYPE VARCHAR2(50),
	REMODEL_TYPE VARCHAR2(50),
	MASTER_PROJECT_ID NUMBER,
	FFE_BUDGET_ID NUMBER,
	STORE_ID NUMBER,
	STORE_NAME VARCHAR2(200),
	QUANTITY NUMBER,
	RATE NUMBER,
	UNIT VARCHAR2(100),
	DATA_ENTRY_LEVEL VARCHAR2(100),
	LINE_TYPE VARCHAR2(100),
	PROJECT_NUMBER VARCHAR2(100),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	BUDGET_VERSION_ID NUMBER,
	DEPR_LIFE NUMBER,
	BUDGET_ID NUMBER,
	 PRIMARY KEY (BUDGET_VERSION_DTL_ID)
  USING INDEX  ENABLE
   ) ;
