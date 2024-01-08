CREATE TABLE TMCS_REPORTS_ROLES
   (	REPORT_ID NUMBER NOT NULL ENABLE,
	ENT_ROLE_ID NUMBER NOT NULL ENABLE,
	CLIENT_ID NUMBER NOT NULL ENABLE,
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1
   ) ;
