CREATE TABLE TMCS_ADHOC_TEMPLATES
   (	ADHOC_TEMPLATE_ID NUMBER DEFAULT TMCS_ADHOC_TEMPLATES_S.NEXTVAL,
	ENTITY_TYPE VARCHAR2(50),
	TEMPLATE_NAME VARCHAR2(100),
	DESCRIPTION VARCHAR2(4000),
	STATUS VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	BU_ID NUMBER,
	COUNTRY VARCHAR2(100),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (ADHOC_TEMPLATE_ID)
  USING INDEX  ENABLE
   ) ;

