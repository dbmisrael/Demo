CREATE TABLE TMCS_COMPETITOR_EVENTS
   (	EVENT_ID NUMBER,
	EVENT_TYPE VARCHAR2(100),
	COMPETITOR_ID NUMBER,
	STATUS VARCHAR2(50),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	EVENT_NUMBER VARCHAR2(100),
	 PRIMARY KEY (EVENT_ID)
  USING INDEX  ENABLE
   ) ;
