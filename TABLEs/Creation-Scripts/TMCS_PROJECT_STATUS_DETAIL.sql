CREATE TABLE TMCS_PROJECT_STATUS_DETAIL
   (	DETAIL_STATUS_ID NUMBER,
	STATUS_ID NUMBER,
	PROJECT_ID NUMBER,
	TEMPLATE_ID NUMBER,
	MILESTONE_NAME VARCHAR2(100),
	TASK_NUMBER NUMBER,
	ORIGIANL_COMPLETION_DATE DATE,
	PROJECTED_COMPLETION_DATE DATE,
	ACTUAL_COMPLETION_DATE DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	MILESTONE_RISK VARCHAR2(50),
	 PRIMARY KEY (DETAIL_STATUS_ID)
  USING INDEX  ENABLE
   ) ;

