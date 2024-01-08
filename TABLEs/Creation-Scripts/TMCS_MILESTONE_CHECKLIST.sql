CREATE TABLE TMCS_MILESTONE_CHECKLIST
   (	CHECKLIST_ID NUMBER,
	MILESTONE_ID NUMBER,
	CHECKLIST_NAME VARCHAR2(100),
	CHECKLIST_VALUE VARCHAR2(4000),
	CHECKLIST_OPTION VARCHAR2(10),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	ACTUAL_DATE DATE,
	FILE_ID NUMBER,
	APPLICABLE_FLAG VARCHAR2(10),
	SEQ_NUMBER NUMBER,
	COMMENTS VARCHAR2(4000),
	STAGING_ID NUMBER,
	 PRIMARY KEY (CHECKLIST_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX TMCS_MILESTONE_CHECKLIST_INDX1 ON TMCS_MILESTONE_CHECKLIST (CLIENT_ID, MILESTONE_ID)
  ;

