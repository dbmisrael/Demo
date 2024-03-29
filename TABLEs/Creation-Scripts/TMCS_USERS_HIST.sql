CREATE TABLE TMCS_USERS_HIST
   (	USER_ID NUMBER,
	USER_NAME VARCHAR2(100) NOT NULL ENABLE,
	FIRST_NAME VARCHAR2(50),
	LAST_NAME VARCHAR2(50),
	EMAIL_ADDRESS VARCHAR2(100),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	FIRST_TIME_LOGIN VARCHAR2(1),
	DEFAULT_CLIENT NUMBER,
	DEFAULT_COUNTRY VARCHAR2(3),
	DEFAULT_LANGUAGE VARCHAR2(10),
	MOBILE_ACCESS VARCHAR2(1),
	TANGO_USER VARCHAR2(1),
	IS_CONTRACTOR VARCHAR2(10),
	USER_TYPE VARCHAR2(20),
	SSO_LOGIN_ENABLED VARCHAR2(10),
	ACCESSBILITY VARCHAR2(20),
	ACTION VARCHAR2(50),
	HISTORY_CREATION_DATE DATE DEFAULT sysdate,
	HISTORY_CREATED_BY VARCHAR2(100)
   ) ;

