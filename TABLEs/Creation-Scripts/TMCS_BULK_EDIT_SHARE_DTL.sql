CREATE TABLE TMCS_BULK_EDIT_SHARE_DTL
   (	QUERY_SHARE_ID NUMBER NOT NULL ENABLE,
	QUERY_ID NUMBER,
	SHARED_BY VARCHAR2(50),
	SHARED_TO VARCHAR2(50),
	ACCESS_LEVEL VARCHAR2(50),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY VARCHAR2(32),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	FULLNAME VARCHAR2(320),
	BU_ID NUMBER
   ) ;

