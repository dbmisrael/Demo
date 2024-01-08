CREATE TABLE TMCS_SQ_CONDITONS
   (	CONDITION_ID NUMBER DEFAULT TMCS_SQ_CONDITONS_S.NEXTVAL,
	ID NUMBER,
	CONDITION_TYPE VARCHAR2(100),
	CONDITION_ATTRIBUTE VARCHAR2(100),
	CONDITION_OPERTOR VARCHAR2(100),
	CONDITION_CLAUSE VARCHAR2(4000),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	COUNTRY VARCHAR2(100),
	CREATION_DATE TIMESTAMP (6) DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	JOIN_CLAUSE VARCHAR2(500),
	TABLE_NAME VARCHAR2(50),
	 PRIMARY KEY (CONDITION_ID)
  USING INDEX  ENABLE
   ) ;

