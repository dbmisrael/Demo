CREATE TABLE TMCS_ENTITY_TAS_BATCHES
   (	BATCH_ID NUMBER,
	BATCH_DESC VARCHAR2(1000),
	STATUS VARCHAR2(20),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	FILE_NAME VARCHAR2(1000),
	S3_LOCATION VARCHAR2(1000),
	 PRIMARY KEY (BATCH_ID)
  USING INDEX  ENABLE
   ) ;
