CREATE TABLE TMCS_USERS
   (	USER_ID NUMBER,
	USER_NAME VARCHAR2(200) NOT NULL ENABLE,
	FIRST_NAME VARCHAR2(50),
	LAST_NAME VARCHAR2(50),
	EMAIL_ADDRESS VARCHAR2(100),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	FIRST_TIME_LOGIN VARCHAR2(1) DEFAULT 'Y',
	DEFAULT_CLIENT NUMBER,
	DEFAULT_COUNTRY VARCHAR2(3) DEFAULT 'USA',
	DEFAULT_LANGUAGE VARCHAR2(10) DEFAULT 'en-US',
	MOBILE_ACCESS VARCHAR2(1) DEFAULT 'N',
	TANGO_USER VARCHAR2(1) DEFAULT 'N',
	IS_CONTRACTOR VARCHAR2(10) DEFAULT 'N',
	USER_TYPE VARCHAR2(20) DEFAULT 'CORPORATE',
	SSO_LOGIN_ENABLED VARCHAR2(10),
	ACCESSBILITY VARCHAR2(20) DEFAULT 'N',
	DEFAULT_BRAND NUMBER,
	DEFAULT_BU NUMBER,
	MOBILE_NUMBER VARCHAR2(50),
	 PRIMARY KEY (USER_ID)
  USING INDEX  ENABLE
   ) ;
CREATE UNIQUE INDEX TMCS_USERS_UK ON TMCS_USERS (USER_NAME)
  ;
CREATE INDEX TMCS_USERS_INDX01 ON TMCS_USERS (LOWER(USER_NAME))
  ;
CREATE INDEX TMCS_USERS_INDX03 ON TMCS_USERS (USER_ID, DEFAULT_CLIENT)
  ;
CREATE INDEX TMCS_USERS_INDX02 ON TMCS_USERS (LOWER(EMAIL_ADDRESS), DEFAULT_CLIENT)
  ;
