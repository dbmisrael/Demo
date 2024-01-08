CREATE TABLE TMCS_ENTITY_SURVEYS
   (	SURVEY_ID NUMBER,
	SURVEY_NAME VARCHAR2(500),
	SURVEY_TYPE VARCHAR2(100),
	SURVEY_NUMBER VARCHAR2(100),
	ENTITY_TYPE VARCHAR2(100) NOT NULL ENABLE,
	SCORE NUMBER,
	COMPLETED_DATE TIMESTAMP (6),
	COMPLETED_BY VARCHAR2(50),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	ORG_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	ENTITY_ID NUMBER NOT NULL ENABLE,
	SURVEY_INSTANCE_ID VARCHAR2(100),
	STATUS VARCHAR2(20),
	 CONSTRAINT TMCS_ENTITY_SURVEYS_PK PRIMARY KEY (SURVEY_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX TMCS_ENTITY_SURVEYS_INDX01 ON TMCS_ENTITY_SURVEYS (ENTITY_TYPE, ENTITY_ID)
  ;
