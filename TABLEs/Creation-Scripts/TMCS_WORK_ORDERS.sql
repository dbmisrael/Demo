CREATE TABLE TMCS_WORK_ORDERS
   (	WO_ID NUMBER DEFAULT TMCS_WORK_ORDERS_S.nextval,
	WO_NUMBER VARCHAR2(100),
	ISSUE_TYPE VARCHAR2(100),
	DESCRIPTION VARCHAR2(4000),
	STORE_ID NUMBER,
	ASSET_INSTANCE_ID NUMBER,
	RESOLUTION_DATE DATE,
	VENDOR_NAME VARCHAR2(500),
	TOTAL_COST NUMBER,
	STATUS VARCHAR2(100),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
	IMPACTED_AREA VARCHAR2(500),
	PROBLEM_CODE VARCHAR2(500),
	FACILITY_MANAGER VARCHAR2(500),
	VENDOR_EMAIL VARCHAR2(500),
	NOT_TO_EXCEED_AMOUNT NUMBER,
	SLA VARCHAR2(500),
	REMAINING_SLA VARCHAR2(500),
	SR_NUMBER VARCHAR2(500),
	TYPE VARCHAR2(50),
	TRADE VARCHAR2(50),
	TECHNICIAN VARCHAR2(500),
	ESTIMATES NUMBER,
	WO_REFERENCE_NUMBER VARCHAR2(500),
	 PRIMARY KEY (WO_ID)
  USING INDEX  ENABLE
   ) ;
