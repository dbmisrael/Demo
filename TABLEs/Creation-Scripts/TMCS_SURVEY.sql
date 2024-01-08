CREATE TABLE TMCS_SURVEY
   (	SURVEY_ID NUMBER(*,0),
	CLIENT_BRAND_ID NUMBER(*,0),
	STORE_ID NUMBER(*,0),
	STORE_NUMNER NUMBER(*,0),
	STORE_ADDRESS1 VARCHAR2(60),
	STORE_ADDRESS2 VARCHAR2(60),
	STORE_CITY VARCHAR2(60),
	STORE_STATE VARCHAR2(60),
	STORE_ZIP VARCHAR2(10),
	STORE_PHONE_NUMBER VARCHAR2(10),
	SURVEY_TYPE_ID NUMBER(*,0),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	 PRIMARY KEY (SURVEY_ID)
  USING INDEX  ENABLE
   ) ;
