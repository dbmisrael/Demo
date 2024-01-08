CREATE TABLE TMCS_ADHOC_TASKS
   (	ADHOC_TASK_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	TASK_NAME VARCHAR2(1000),
	TASK_DESC VARCHAR2(4000),
	ASSIGNED_TO VARCHAR2(100),
	TASK_START DATE,
	TASK_FINISH DATE,
	ACTUAL_FINSH DATE,
	NOTIFICATION1 NUMBER,
	NOTIFICATION2 NUMBER,
	NOTIFICATION3 NUMBER,
	STATUS VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	REMINDER VARCHAR2(50),
	TAGS VARCHAR2(500),
	TASK_TYPE VARCHAR2(100),
	STAGING_ID NUMBER,
	TASK_SEQ NUMBER,
	ESCALTION_NOTIFICATION NUMBER,
	TEMPLATE_ID NUMBER,
	COUNTRY VARCHAR2(100),
	PRIORITY VARCHAR2(50),
	MITIGATION_COMMENTS VARCHAR2(4000),
	FILE_ID NUMBER,
	EMAIL_ADDRESS VARCHAR2(200),
	TASK_NUMBER VARCHAR2(100),
	VALUE_ADD VARCHAR2(100),
	RISK_AMOUNT NUMBER,
	RISK_MITIGATION VARCHAR2(500),
	TASK_INTERNAL_ACTION DATE,
	TASK_NOTICE DATE,
	ASSIGNED_BY VARCHAR2(100),
	ASSIGNED_DATE DATE,
	ASSIGNED_BY_EMAIL VARCHAR2(200),
	ASSOSIATED_FILE_IDS VARCHAR2(1000),
	SUB_ENTITY_TYPE VARCHAR2(100),
	SUB_ENTITY_ID NUMBER,
	SEND_NOTIFICATION_FLAG VARCHAR2(10),
	ASSIGNED_TO_USERS VARCHAR2(4000),
	ADHOC_TEMP_DETAIL_ID NUMBER,
	ASSIGNED_TO_ROLE VARCHAR2(500),
	 PRIMARY KEY (ADHOC_TASK_ID)
  USING INDEX  ENABLE
   ) ;
