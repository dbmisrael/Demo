CREATE TABLE TMCS_APP_RESOURCE_BUNDLE
   (	RESOURCE_ID NUMBER DEFAULT TMCS_APP_RESOURCE_BUNDLE_S.NEXTVAL,
	CLIENT_ID NUMBER NOT NULL ENABLE,
	LANGUAGE_CODE VARCHAR2(50) NOT NULL ENABLE,
	COMPONENT_KEY VARCHAR2(500) NOT NULL ENABLE,
	LABEL_VALUE VARCHAR2(500 CHAR),
	DISPLAY VARCHAR2(50),
	COMPONENT_TYPE VARCHAR2(50),
	PARENT_KEY VARCHAR2(500),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	TABLE_NAME VARCHAR2(30),
	COLUMN_NAME VARCHAR2(30),
	COMPONENT_KEY_OLD VARCHAR2(500),
	COMPONENT_NAME VARCHAR2(100),
	EDITABLE VARCHAR2(50) DEFAULT 'FALSE',
	BU_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	LOOKUP_CODE VARCHAR2(30),
	DEPRECATED VARCHAR2(20) DEFAULT 'FALSE',
	MANDATORY VARCHAR2(50) DEFAULT 'FALSE',
	COLUMN_TYPE VARCHAR2(30),
	EXPORT_COLUMN VARCHAR2(50),
	EXPORT_SEQ NUMBER,
	BRAND_ID NUMBER,
	SHOW_MOBILE VARCHAR2(10),
	ENABLE_AUDITING VARCHAR2(10),
	DIVISION_ID NUMBER,
	DEFAULT_VALUE VARCHAR2(500),
	FORMATTING VARCHAR2(200),
	RESTRICTED VARCHAR2(50),
	DISPLAY_IN_VQB VARCHAR2(50) DEFAULT 'TRUE',
	DISPLAY_IN_BULK_EDIT VARCHAR2(50),
	COLUMN_WIDTH NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_APP_RESOURCE_BUNDLE_PK ON TMCS_APP_RESOURCE_BUNDLE (RESOURCE_ID)
  ;
ALTER TABLE TMCS_APP_RESOURCE_BUNDLE ADD CONSTRAINT TMCS_APP_RESOURCE_BUNDLE_PK PRIMARY KEY (RESOURCE_ID)
  USING INDEX TMCS_APP_RESOURCE_BUNDLE_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_APP_RESOURCE_BUNDLE_PK ON TMCS_APP_RESOURCE_BUNDLE (RESOURCE_ID)
  ;
CREATE UNIQUE INDEX TMCS_APP_RESOURCE_BUNDLE_UK ON TMCS_APP_RESOURCE_BUNDLE (CLIENT_ID, DIVISION_ID, BRAND_ID, BU_ID, COUNTRY_CODE, LANGUAGE_CODE, COMPONENT_KEY)
  ;
CREATE INDEX TMCS_APP_RESOURCE_BUNDLE_INDX ON TMCS_APP_RESOURCE_BUNDLE (TABLE_NAME, CLIENT_ID, LOOKUP_CODE)
  ;

