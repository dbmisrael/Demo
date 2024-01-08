CREATE TABLE TMCS_FTP_INTG_CLIENT_CONFIG
   (	CLIENT_CONFIG_ID NUMBER DEFAULT TMCS_FTP_INTG_CLIENT_CONFIG_S.NEXTVAL NOT NULL ENABLE,
	HEADER_CONFIG_ID NUMBER NOT NULL ENABLE,
	STANDARD_INTG VARCHAR2(10) DEFAULT 'Y',
	SFTP_PATH VARCHAR2(300),
	JOB_NAME VARCHAR2(300),
	JOB_FREQUENCY VARCHAR2(500),
	JOB_RUN_DAY VARCHAR2(2000),
	JOB_RUN_TIME VARCHAR2(300),
	TIMEZONE VARCHAR2(300),
	ENABLE_FLAG VARCHAR2(50),
	CLIENT_ID NUMBER,
	COUNTRY_CODE VARCHAR2(20),
	CREATED_DATE DATE DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	 CONSTRAINT TMCS_FTP_INTG_CLIENT_CONFIG_PK PRIMARY KEY (CLIENT_CONFIG_ID)
  USING INDEX  ENABLE
   ) ;

