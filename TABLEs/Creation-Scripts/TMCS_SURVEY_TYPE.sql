CREATE TABLE TMCS_SURVEY_TYPE
   (	SURVEY_TYPE_ID NUMBER(*,0),
	SURVEY_TYPE VARCHAR2(60),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	 PRIMARY KEY (SURVEY_TYPE_ID)
  USING INDEX  ENABLE
   ) ;

