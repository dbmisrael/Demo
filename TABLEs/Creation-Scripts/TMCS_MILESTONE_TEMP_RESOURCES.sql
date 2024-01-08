CREATE TABLE TMCS_MILESTONE_TEMP_RESOURCES
   (	RESOURCE_ID NUMBER,
	TEMP_DETAIL_ID NUMBER,
	RESOURCE_NAME VARCHAR2(100),
	RESOURCE_ROLE VARCHAR2(100),
	ESCALATION_NOTIFICATION VARCHAR2(10),
	EMAIL VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	COMPLETION_NOTIFICATION VARCHAR2(10),
	VERSION NUMBER,
	 PRIMARY KEY (RESOURCE_ID)
  USING INDEX  ENABLE
   ) ;

