CREATE TABLE TMCS_QUESTIONS
   (	QUESTION_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	DESCRIPTION VARCHAR2(500),
	QUESTION_TYPE VARCHAR2(10),
	BRAND_ID NUMBER(*,0),
	CLIENT_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	DISPLAY_SEQ NUMBER,
	 PRIMARY KEY (QUESTION_ID)
  USING INDEX  ENABLE
   ) ;

