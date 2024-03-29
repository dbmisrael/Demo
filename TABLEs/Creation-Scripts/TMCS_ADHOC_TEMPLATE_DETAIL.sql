CREATE TABLE TMCS_ADHOC_TEMPLATE_DETAIL
   (	ADHOC_TEMP_DETAIL_ID NUMBER DEFAULT TMCS_ADHOC_TEMPLATE_DETAIL_S.NEXTVAL,
	ADHOC_TEMPLATE_ID NUMBER,
	TASK_NAME VARCHAR2(1000),
	DESCRIPTION VARCHAR2(4000),
	TASK_TYPE VARCHAR2(100),
	TASK_SEQ NUMBER,
	NOTIFICATION1 NUMBER,
	NOTIFICATION2 NUMBER,
	NOTIFICATION3 NUMBER,
	ESCALATION_NOTIFICATION NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	ASSIGNED_TO_ROLE VARCHAR2(500),
	 PRIMARY KEY (ADHOC_TEMP_DETAIL_ID)
  USING INDEX  ENABLE
   ) ;

