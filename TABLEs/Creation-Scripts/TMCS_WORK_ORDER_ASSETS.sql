CREATE TABLE TMCS_WORK_ORDER_ASSETS
   (	WO_ASSET_ID NUMBER NOT NULL ENABLE,
	WO_ID NUMBER,
	ASSET_INSTANCE_ID NUMBER,
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER
   ) ;

