CREATE TABLE TMCS_ENTITY_FORM_TEMPLATES
   (	FORM_TEMPLATE_ID NUMBER DEFAULT TMCS_ENTITY_FORM_TEMPLATES_S.NEXTVAL,
	ENTITY_TYPE VARCHAR2(100),
	FORM_NAME VARCHAR2(50),
	DESCRIPTION VARCHAR2(50),
	STATUS VARCHAR2(50),
	VERSION NUMBER,
	JSON_TEMPLATE CLOB,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	DIVISION_ID NUMBER,
	 CONSTRAINT TMCS_ENTITY_FORM_TEMPLATES_PK PRIMARY KEY (FORM_TEMPLATE_ID)
  USING INDEX  ENABLE
   ) ;

