CREATE TABLE TMCS_STORE_LEASE_DETAIL
   (	DDETAIL_ID NUMBER DEFAULT tmcs_store_lease_detail_s.nextval,
	LEASE_NUMBER VARCHAR2(100),
	OPTION_NUMBER VARCHAR2(100),
	LEASE_NAME VARCHAR2(500),
	PAYMENT_CATEGORY VARCHAR2(100),
	PAYMENT_TYPE VARCHAR2(100),
	TERM_STATUS VARCHAR2(100),
	COMMITTED VARCHAR2(100),
	MONTHS NUMBER,
	BEGIN_DATE DATE,
	END_DATE DATE,
	MONTHLY_PAYMENT NUMBER,
	ESCALATION_METHOD VARCHAR2(100),
	INCREASE_PCT NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	STORE_ID NUMBER,
	 PRIMARY KEY (DDETAIL_ID)
  USING INDEX  ENABLE
   ) ;

