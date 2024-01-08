CREATE TABLE TMCS_LEAP_REPORT_BATCHES
   (	BATCH_ID NUMBER,
	REPORT_LINK VARCHAR2(1000),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	STATUS VARCHAR2(20),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	XML_SOURCE_VARCHAR VARCHAR2(4000),
	XML_DATA_SOURCE CLOB,
	 CONSTRAINT TMCS_LEAP_REPORT_BATCHES_PK PRIMARY KEY (BATCH_ID)
  USING INDEX  ENABLE
   ) ;

