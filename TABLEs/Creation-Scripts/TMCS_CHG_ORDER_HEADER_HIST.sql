CREATE TABLE TMCS_CHG_ORDER_HEADER_HIST
   (	CHG_ORDER_ID NUMBER,
	PO_ID NUMBER,
	PROJECT_ID NUMBER,
	CHG_REASON VARCHAR2(400),
	STATUS VARCHAR2(50),
	CHG_ORDER_DATE DATE,
	APPROVED_BY VARCHAR2(100),
	APPROVED_DATE DATE,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	CHG_REASON_DESCRIPTION VARCHAR2(1000),
	BRAND_ID NUMBER,
	WF_STATUS VARCHAR2(50),
	CHG_ORDER_NUMBER VARCHAR2(100),
	EXPORTED_FLAG VARCHAR2(10),
	BUYER_CODE VARCHAR2(200),
	BUYER_NAME VARCHAR2(200),
	SOURCE VARCHAR2(20),
	COMMENTS VARCHAR2(4000)
   ) ;

