CREATE TABLE TMCS_USER_COUNTRIES_HIST
   (	USER_COUNTRY_ID NUMBER(*,0),
	USER_NAME VARCHAR2(200),
	COUNTRY_CODE VARCHAR2(10),
	BRAND_ID NUMBER(*,0),
	CLIENT_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	BU_ID NUMBER,
	ACTION VARCHAR2(50),
	HISTORY_CREATION_DATE DATE DEFAULT sysdate,
	HISTORY_CREATED_BY VARCHAR2(100)
   ) ;

