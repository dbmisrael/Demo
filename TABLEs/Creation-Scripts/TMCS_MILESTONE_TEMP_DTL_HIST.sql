CREATE TABLE TMCS_MILESTONE_TEMP_DTL_HIST
   (	TEMP_DETAIL_ID NUMBER,
	TEMPLATE_ID NUMBER,
	MILESTONE_NAME VARCHAR2(1000),
	DESCRIPTION VARCHAR2(4000),
	LAG_LEAD_TIME NUMBER,
	DURATION NUMBER,
	MILESTONE_TYPE VARCHAR2(100),
	PREDECESSOR VARCHAR2(1000),
	CRITICAL_PATH VARCHAR2(10),
	RESOURCE_NAME VARCHAR2(100),
	TASK_RELATIONSHIP VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	TASK_NUMBER NUMBER,
	MAPPING VARCHAR2(100),
	NOTIFICATION1 NUMBER,
	NOTIFICATION2 NUMBER,
	NOTIFICATION3 NUMBER,
	ESCALATION_NOTIFICATION NUMBER,
	OPEN_DATE_TASK VARCHAR2(10),
	ENTITY_STATUS VARCHAR2(50),
	SCORE_CARD_MILESTONE VARCHAR2(1),
	GROUP_NAME VARCHAR2(250),
	FORM_ID NUMBER,
	READ_ONLY VARCHAR2(10),
	C_EXT_LOV1 VARCHAR2(250),
	DISP_SEQ NUMBER,
	SUB_GROUP_NAME VARCHAR2(250),
	MANDATORY VARCHAR2(10),
	C_EXT_ATTR1 VARCHAR2(1000),
	C_EXT_ATTR2 VARCHAR2(1000),
	C_EXT_ATTR3 VARCHAR2(1000),
	C_EXT_ATTR4 VARCHAR2(1000),
	C_EXT_ATTR5 VARCHAR2(1000),
	C_EXT_ATTR6 VARCHAR2(1000),
	VERSION NUMBER
   ) ;

