CREATE TABLE TMCS_TAGGED_ATTR_VALUES
   (	TAGGED_VALUE_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	COLUMN_NAME VARCHAR2(50),
	TAG_VALUE VARCHAR2(500),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	C_EXT_ATTR1 VARCHAR2(500),
	C_EXT_ATTR2 VARCHAR2(500),
	C_EXT_ATTR3 VARCHAR2(500),
	C_EXT_ATTR4 VARCHAR2(500),
	C_EXT_ATTR5 VARCHAR2(500),
	C_EXT_ATTR6 VARCHAR2(500),
	C_EXT_ATTR7 VARCHAR2(500),
	C_EXT_ATTR8 VARCHAR2(500),
	C_EXT_ATTR9 VARCHAR2(500),
	C_EXT_ATTR10 VARCHAR2(500),
	COUNTRY VARCHAR2(50),
	 PRIMARY KEY (TAGGED_VALUE_ID)
  USING INDEX  ENABLE
   ) ;
CREATE UNIQUE INDEX TMCS_TAGGED_ATTR_VALUES_UKIDX1 ON TMCS_TAGGED_ATTR_VALUES (ENTITY_TYPE, COLUMN_NAME, UPPER(TAG_VALUE))
  ;

