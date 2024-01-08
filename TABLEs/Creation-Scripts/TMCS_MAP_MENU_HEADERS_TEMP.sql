CREATE TABLE TMCS_MAP_MENU_HEADERS_TEMP
   (	MENU_HEADER_ID NUMBER,
	MENU_NAME VARCHAR2(100),
	PARENT_ID NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	APP_ROLE_NAME VARCHAR2(255),
	MENU_DESCRIPTION VARCHAR2(500),
	MENU_ID VARCHAR2(500),
	MENU_CATEGORY VARCHAR2(500),
	JSON_STRING CLOB,
	BU_ID NUMBER,
	MENU_SEQUENCE NUMBER,
	RIGHTCLICK VARCHAR2(100),
	COUNTRY VARCHAR2(200),
	ENABLED VARCHAR2(10),
	TEMP_PARENT_ID VARCHAR2(1000),
	IS_MOBILE_ENABLED VARCHAR2(320)
   ) ;

