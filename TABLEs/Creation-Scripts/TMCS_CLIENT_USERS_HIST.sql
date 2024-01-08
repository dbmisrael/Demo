CREATE TABLE TMCS_CLIENT_USERS_HIST
   (	USER_ID NUMBER,
	CLIENT_ID NUMBER NOT NULL ENABLE,
	USER_NAME VARCHAR2(200) NOT NULL ENABLE,
	STATUS VARCHAR2(20),
	START_DATE DATE,
	END_DATE DATE,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	SYSTEM_USER CHAR(1) DEFAULT 'N',
	DMA NUMBER,
	MANAGER_NAME VARCHAR2(50),
	DEFAULT_BRAND_ID NUMBER,
	DEFAULT_COUNTRY VARCHAR2(50),
	TAADMIN VARCHAR2(1) DEFAULT 'N',
	LEASE_FULL_ACCESS VARCHAR2(10) DEFAULT 'Y',
	TARGET_ADDITIONAL_SECURITY VARCHAR2(10) DEFAULT 'Y',
	SITE_ADDITIONAL_SECURITY VARCHAR2(10) DEFAULT 'Y',
	PROJECT_ADDITIONAL_SECURITY VARCHAR2(10) DEFAULT 'Y',
	STORE_ADDITIONAL_SECURITY VARCHAR2(10) DEFAULT 'Y',
	PREFERRED_LOCALE VARCHAR2(100),
	USER_ACCESS_LEVEL VARCHAR2(50) DEFAULT 'F',
	CONFIDENTIAL_PROJECT_ACCESS VARCHAR2(10) DEFAULT 'N',
	ACTION VARCHAR2(50),
	HISTORY_CREATION_DATE DATE DEFAULT sysdate,
	HISTORY_CREATED_BY VARCHAR2(100)
   ) ;
CREATE INDEX TMCS_CLIENT_USERS_HIST_IDX0 ON TMCS_CLIENT_USERS_HIST (USER_NAME, CLIENT_ID)
  ;

