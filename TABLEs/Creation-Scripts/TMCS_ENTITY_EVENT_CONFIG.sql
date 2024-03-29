CREATE TABLE TMCS_ENTITY_EVENT_CONFIG
   (	EVENT_CONFIG_ID NUMBER DEFAULT TMCS_ENTITY_EVENT_CONFIG_S.NEXTVAL NOT NULL ENABLE,
	EVENT_TYPE VARCHAR2(200) NOT NULL ENABLE,
	STATUS VARCHAR2(5) DEFAULT 'A',
	CLIENT_ID NUMBER NOT NULL ENABLE,
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	COUNTRY_CODE VARCHAR2(20),
	CREATED_DATE DATE DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	DESCRIPTION VARCHAR2(100),
	MODULE VARCHAR2(100),
	CHILD_EVENT_CONFIG VARCHAR2(20) DEFAULT 'N',
	OLD_COL_SQL VARCHAR2(4000),
	NEW_COL_SQL VARCHAR2(4000),
	OUTPUT_JSON_LEVEL VARCHAR2(100) DEFAULT 'TABLE',
	 CONSTRAINT TMCS_ENTITY_EVENT_CONFIG_PK PRIMARY KEY (EVENT_CONFIG_ID)
  USING INDEX  ENABLE
   ) ;

