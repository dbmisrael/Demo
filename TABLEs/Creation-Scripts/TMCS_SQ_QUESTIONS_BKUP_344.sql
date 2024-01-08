CREATE TABLE TMCS_SQ_QUESTIONS_BKUP_344
   (	QID NUMBER NOT NULL ENABLE,
	QUESTION VARCHAR2(500),
	Q_TYPE VARCHAR2(1),
	Q_STATUS VARCHAR2(1),
	ENTITY_TYPE VARCHAR2(32),
	GROUP_ID NUMBER,
	REQUIRED VARCHAR2(10),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY VARCHAR2(32),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	Q_SEQ_NO NUMBER,
	USED_IN_MODEL NUMBER(1,0),
	MODEL_SHORT_CODE VARCHAR2(30),
	SITE_QUESTION_MAPPING NUMBER,
	BU_ID NUMBER,
	HAS_CONDITION VARCHAR2(1),
	HAS_DEPENDENCY VARCHAR2(1),
	DISP_SEQ_NO VARCHAR2(10),
	SQ_HEADER_ID NUMBER,
	SQ_VERSION NUMBER,
	ANSWER_VALIDATION VARCHAR2(2000)
   ) ;

