CREATE TABLE TMCS_NOTIFICATIONS
   (	NOTIFICATION_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	MESSAGE VARCHAR2(1000),
	ASSIGNED_TO VARCHAR2(4000),
	COMPLETION_DATE DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (NOTIFICATION_ID)
  USING INDEX  ENABLE
   ) ;

