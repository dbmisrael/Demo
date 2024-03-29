CREATE TABLE TMCS_SEC_CLIENT_ROLE_MAP_AMCN
   (	ROLE_MAP_ID NUMBER,
	ENT_ROLE_NAME VARCHAR2(50) NOT NULL ENABLE,
	APP_ROLE_NAME VARCHAR2(50) NOT NULL ENABLE,
	CREATION_DATE TIMESTAMP (6),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	BU_ID NUMBER
   ) ;

