CREATE GLOBAL TEMPORARY TABLE TEMP_LEASE_SALE_EXCL_STG
   (	LOAD_ORDER_ID NUMBER,
	LEASE_ID NUMBER,
	MONTH VARCHAR2(10),
	MONTH_NUMBER NUMBER,
	CALENDAR_MONTH_NUM NUMBER,
	FISCAL_YEAR NUMBER,
	CALENDAR_YEAR VARCHAR2(10),
	EFFECTIVE_FROM_DATE DATE,
	EFFECTIVE_TO_DATE DATE,
	SALES_CODE VARCHAR2(100),
	SALES_CATEGORY VARCHAR2(50),
	SALES_EXCLUSION VARCHAR2(10),
	SALES NUMBER,
	POSTING_STATUS VARCHAR2(50),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	ORG_ID NUMBER,
	LEASE_PCT_RENT_ID NUMBER,
	CURRENCY_CODE VARCHAR2(50),
	CAP_STATUS_LOAD VARCHAR2(500),
	MONTH_LOAD_TYPE VARCHAR2(500),
	CREATION_DATE DATE,
	DATA_SOURCE VARCHAR2(50),
	N_EXT_ATTR2 NUMBER,
	ORIGINAL_SALES NUMBER,
	CAP_PERCENTAGE NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	C_EXT_ATTR1 VARCHAR2(100),
	C_EXT_ATTR2 VARCHAR2(100),
	C_EXT_ATTR3 VARCHAR2(100)
   ) ON COMMIT PRESERVE ROWS ;

