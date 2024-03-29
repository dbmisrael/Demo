CREATE TABLE TMCS_EXT_AUTH_HEADER_HIST
   (	EXT_AUTH_ID NUMBER,
	PO_ID NUMBER,
	PROJECT_ID NUMBER,
	CHG_REASON VARCHAR2(4000),
	STATUS VARCHAR2(50),
	APPROVED_BY VARCHAR2(100),
	APPROVED_DATE DATE,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	CHNG_ORDER_ID NUMBER,
	CHNG_CREATED VARCHAR2(1),
	BRAND_ID NUMBER,
	WF_STATUS VARCHAR2(50),
	CHANGE_REASON VARCHAR2(1000),
	DESCRIPTION VARCHAR2(4000),
	EXT_AUTH_NUMBER VARCHAR2(50),
	C_EXT_ATTR1 VARCHAR2(4000)
   ) ;

