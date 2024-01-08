CREATE TABLE TMCS_SCOPE_PUNCH_LISTS_HIST
   (	SCOPE_PUNCH_LIST_ID NUMBER,
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	SCOPE_PUNCH_NAME VARCHAR2(250),
	DESCRIPTION VARCHAR2(4000),
	C_EXT_ATTR1 VARCHAR2(250),
	C_EXT_ATTR2 VARCHAR2(250),
	C_EXT_ATTR3 VARCHAR2(250),
	C_EXT_ATTR4 VARCHAR2(250),
	C_EXT_ATTR5 VARCHAR2(250),
	C_EXT_ATTR6 VARCHAR2(250),
	C_EXT_ATTR7 VARCHAR2(250),
	C_EXT_ATTR8 VARCHAR2(250),
	C_EXT_ATTR9 VARCHAR2(250),
	C_EXT_ATTR10 VARCHAR2(250),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
	ASSIGNEE VARCHAR2(100),
	DUE_DATE DATE,
	LINE_ITEM_SEQ NUMBER,
	COMMENTS VARCHAR2(2000),
	ITEM_TYPE VARCHAR2(100),
	DIVISION VARCHAR2(100),
	D_EXT_ATTR1 DATE,
	NOT_APPLICABLE_FLAG VARCHAR2(50),
	C_EXT_LOV1 VARCHAR2(50),
	RESPONSIBILTY VARCHAR2(100),
	COST NUMBER,
	MAINTENANCE VARCHAR2(100),
	C_EXT_LOV2 VARCHAR2(50),
	C_EXT_LOV3 VARCHAR2(50),
	C_EXT_LOV4 VARCHAR2(50),
	C_EXT_LOV5 VARCHAR2(50),
	C_EXT_LOV6 VARCHAR2(50),
	C_EXT_LOV7 VARCHAR2(50),
	C_EXT_LOV8 VARCHAR2(50),
	C_EXT_LOV9 VARCHAR2(50),
	COMMENTS1 VARCHAR2(4000),
	COMMENTS2 VARCHAR2(4000),
	COMMENTS3 VARCHAR2(4000)
   ) ;
