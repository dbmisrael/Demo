CREATE TABLE TMCS_PROJECT_VENDORS
   (	PV_ID NUMBER,
	PROJECT_ID NUMBER,
	VENDOR_ID NUMBER,
	VENDOR_SITE_ID NUMBER,
	CLIENT_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (PV_ID)
  USING INDEX  ENABLE
   ) ;

