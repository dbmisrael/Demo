CREATE TABLE TMCS_MAP_MENU_DETAIL
   (	MENU_DETAIL_ID NUMBER,
	MENU_HEADER_ID NUMBER,
	JSON_STRING CLOB,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (MENU_DETAIL_ID)
  USING INDEX  ENABLE
   ) ;
