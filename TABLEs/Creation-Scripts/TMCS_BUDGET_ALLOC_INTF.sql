CREATE TABLE TMCS_BUDGET_ALLOC_INTF
   (	BUDGET_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	ENTITY_ID NUMBER,
	TASK_NAME VARCHAR2(100),
	TASK_NUMBER NUMBER,
	DESCRIPTION VARCHAR2(1000),
	LINE_ITEM_SEQ NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	ALLOC_START_DATE DATE,
	ALLOC_NO_OF_MONTHS NUMBER,
	ALLOC_CURRENT_FY NUMBER,
	ALLOC_CURRENT_FY_1 NUMBER,
	ALLOC_CURRENT_FY_2 NUMBER,
	ALLOC_CURRENT_FY_3 NUMBER,
	ALLOC_CURRENT_FY_4 NUMBER
   ) ;

