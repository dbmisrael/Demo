CREATE TABLE TMCS_CLIENT_OAUTH_SETUP
   (	OAUTH_SETUP_ID NUMBER DEFAULT TMCS_CLIENT_OAUTH_SETUP_S.NEXTVAL,
	PROFILE VARCHAR2(50) DEFAULT 'default',
	TOKEN_URL VARCHAR2(500),
	TOKEN_SEC_TYPE VARCHAR2(50) DEFAULT 'client_secret',
	SCOPES VARCHAR2(1000),
	OAUTH_CLIENT_ID VARCHAR2(500),
	CLIENT_SECRET VARCHAR2(500),
	CLAIM_AUD VARCHAR2(500),
	CLAIM_EXPIRY_DAYS NUMBER,
	PRIVATE_KEY VARCHAR2(4000),
	X509_THUMBPRINT VARCHAR2(500),
	CLIENT_ID NUMBER NOT NULL ENABLE,
	CREATED_DATE DATE DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	 CONSTRAINT TMCS_CLIENT_OAUTH_SETUP_PK PRIMARY KEY (OAUTH_SETUP_ID)
  USING INDEX  ENABLE
   ) ;

