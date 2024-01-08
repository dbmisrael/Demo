CREATE TABLE TMCS_SQ_ANSWERS_BKUP_344
   (	QID NUMBER NOT NULL ENABLE,
	ANSWER_ID NUMBER NOT NULL ENABLE,
	ANSWER_LABEL VARCHAR2(500),
	ANSWER_VALUE VARCHAR2(500),
	DEFAULT_SELECTED VARCHAR2(50),
	ANSWER_DESC VARCHAR2(256),
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
	Q_TYPE VARCHAR2(1),
	MIN_VALUE NUMBER,
	MAX_VALUE NUMBER,
	MODEL_SHORT_CODE VARCHAR2(30),
	SITE_ANSWER_MAPPING NUMBER,
	BU_ID NUMBER,
	DEFAULT_VALUE VARCHAR2(500),
	SQ_HEADER_ID NUMBER,
	SQ_VERSION NUMBER
   ) ;
