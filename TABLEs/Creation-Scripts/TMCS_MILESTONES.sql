CREATE TABLE TMCS_MILESTONES
   (	MILESTONE_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	MILESTONE_NAME VARCHAR2(1000),
	DESCRIPTION VARCHAR2(4000),
	PLANNED_START DATE,
	PLANNED_FINISH DATE,
	ACTUAL_START DATE,
	ACTUAL_FINISH DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	BASE_LINE_START DATE,
	BASE_LINE_END DATE,
	FORECAST_START DATE,
	FORECAST_END DATE,
	LAG_LEAD_TIME NUMBER,
	DURATION NUMBER,
	MILESTONE_TYPE VARCHAR2(100),
	PREDECESSOR VARCHAR2(1000),
	CRITICAL_PATH VARCHAR2(10),
	RESOURCE_NAME VARCHAR2(100),
	TASK_RELATIONSHIP VARCHAR2(100),
	TASK_NUMBER NUMBER,
	NOTIFICATION1 NUMBER,
	NOTIFICATION2 NUMBER,
	NOTIFICATION3 NUMBER,
	ESCALATION_NOTIFICATION NUMBER,
	MILESTONE_NOTE VARCHAR2(4000),
	OPEN_DATE_TASK VARCHAR2(10),
	GANTT_CHART_TYPE VARCHAR2(100),
	CRITICAL VARCHAR2(10),
	PERCENT_COMPLETE NUMBER,
	SCORE_CARD_MILESTONE VARCHAR2(1),
	GROUP_NAME VARCHAR2(250),
	FORM_ID NUMBER,
	READ_ONLY VARCHAR2(10),
	LAST_RESCH_FORECAST_START_DATE DATE,
	LAST_RESCH_FORECAST_END_DATE DATE,
	LAST_RESCH_DURATION NUMBER,
	ENTITY_STATUS VARCHAR2(100),
	MASTER_PROJECT_ID NUMBER,
	EXT_PREDECESSOR VARCHAR2(2000),
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
	DELAY_REASON VARCHAR2(50),
	NOTIFICATION_SENT VARCHAR2(10),
	 PRIMARY KEY (MILESTONE_ID)
  USING INDEX  ENABLE
   ) ;

