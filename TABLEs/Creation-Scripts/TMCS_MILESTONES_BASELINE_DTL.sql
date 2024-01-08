CREATE TABLE TMCS_MILESTONES_BASELINE_DTL
   (	BASELINE_DETAIL_ID NUMBER,
	BASE_LINE_ID NUMBER,
	MILESTONE_NAME VARCHAR2(100),
	DESCRIPTION VARCHAR2(4000),
	BASE_LINE_START DATE,
	BASE_LINE_END DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	DURATION NUMBER,
	PLANNED_START DATE,
	PLANNED_FINISH DATE,
	ACTUAL_START DATE,
	ACTUAL_FINISH DATE,
	MILESTONE_TYPE VARCHAR2(100),
	PREDECESSOR VARCHAR2(1000),
	TASK_RELATIONSHIP VARCHAR2(100),
	TASK_NUMBER NUMBER,
	DISP_SEQ NUMBER,
	DELAY_REASON VARCHAR2(50),
	 PRIMARY KEY (BASELINE_DETAIL_ID)
  USING INDEX  ENABLE
   ) ;
