CREATE TABLE TMCS_MAP_INFO_ATTRIBUTES
   (	MAP_INFO_ATTR_ID NUMBER NOT NULL ENABLE,
	LABEL VARCHAR2(150) NOT NULL ENABLE,
	ENTITY_NAME VARCHAR2(20) NOT NULL ENABLE,
	TABLE_COL_NAME VARCHAR2(150) NOT NULL ENABLE,
	TABLE_NAME VARCHAR2(150) NOT NULL ENABLE,
	LANGUAGE_CODE VARCHAR2(20),
	ENABLED VARCHAR2(1),
	DISPLAY_ORDER NUMBER,
	TAB_CODE VARCHAR2(50),
	TAB_LABEL VARCHAR2(150),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_MAP_INFO_ATTRIBUTES_PK ON TMCS_MAP_INFO_ATTRIBUTES (MAP_INFO_ATTR_ID)
  ;
ALTER TABLE TMCS_MAP_INFO_ATTRIBUTES ADD CONSTRAINT TMCS_MAP_INFO_ATTRIBUTES_PK PRIMARY KEY (MAP_INFO_ATTR_ID)
  USING INDEX TMCS_MAP_INFO_ATTRIBUTES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_MAP_INFO_ATTRIBUTES_PK ON TMCS_MAP_INFO_ATTRIBUTES (MAP_INFO_ATTR_ID)
  ;

