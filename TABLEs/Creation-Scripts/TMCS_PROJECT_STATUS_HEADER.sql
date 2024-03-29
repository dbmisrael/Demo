CREATE TABLE TMCS_PROJECT_STATUS_HEADER
   (	STATUS_ID NUMBER,
	PROJECT_ID NUMBER,
	WEEK_ENDING DATE,
	PROJECT_MANAGER VARCHAR2(100),
	GENERAL_CONTRACTOR VARCHAR2(100),
	JOB_SUPER VARCHAR2(100),
	PHONE_NUMBER VARCHAR2(100),
	WEATHER_THIS_WEEK VARCHAR2(4000),
	WEATHER_NEXT_WEEK VARCHAR2(4000),
	PROJECT_IN_WEEK NUMBER,
	WORK_SCHEDULE_THIS_WEEK VARCHAR2(4000),
	WORK_NOT_COMPLETED VARCHAR2(4000),
	REASON_NOT_COMPLETED VARCHAR2(4000),
	WORK_SCHEDULE_NEXT_WEEK VARCHAR2(4000),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	STATUS VARCHAR2(100),
	GENERAL_COMMENTS VARCHAR2(4000),
	SCHEDULE_COMMENTS VARCHAR2(4000),
	BUDGET_COMMENTS VARCHAR2(4000),
	RISK_COMMENTS VARCHAR2(4000),
	ACTION_ITEMS VARCHAR2(4000),
	PER_REPORT_COMMENTS VARCHAR2(4000),
	FINANCIAL_HEALTH VARCHAR2(100),
	SCHEDULE_HEALTH VARCHAR2(100),
	RISK_HEALTH VARCHAR2(100),
	 PRIMARY KEY (STATUS_ID)
  USING INDEX  ENABLE
   ) ;

