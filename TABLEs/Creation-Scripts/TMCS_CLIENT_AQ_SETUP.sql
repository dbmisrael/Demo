CREATE TABLE TMCS_CLIENT_AQ_SETUP
   (	AQ_SETUP_ID NUMBER DEFAULT TMCS_CLIENT_AQ_SETUP_S.NEXTVAL NOT NULL ENABLE,
	BASE_API_URL VARCHAR2(1000) NOT NULL ENABLE,
	BASE_AUTH_API_URL VARCHAR2(1000) NOT NULL ENABLE,
	APP_LOGIN VARCHAR2(1000) NOT NULL ENABLE,
	APP_PASSWORD VARCHAR2(1000) NOT NULL ENABLE,
	SERVICE_LOGIN VARCHAR2(1000) NOT NULL ENABLE,
	SERVICE_PASSWORD VARCHAR2(1000) NOT NULL ENABLE,
	APP_AUTH_TOKEN VARCHAR2(1000),
	DESCRIPTION VARCHAR2(100),
	CLIENT_ID NUMBER NOT NULL ENABLE,
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	COUNTRY_CODE VARCHAR2(20),
	CREATED_DATE DATE DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(50) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(50),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	 CONSTRAINT TMCS_CLIENT_AQ_SETUP_PK PRIMARY KEY (AQ_SETUP_ID)
  USING INDEX  ENABLE
   ) ;

