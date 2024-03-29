CREATE TABLE TMCS_STRATEGY_GROUP
   (	STRATEGY_GROUP_ID NUMBER DEFAULT TMCS_STRATEGY_GROUP_S.NEXTVAL,
	STRATEGY_GROUP_NAME VARCHAR2(50),
	DESCRIPTION VARCHAR2(500),
	T_EXT_ATTR1 VARCHAR2(250),
	T_EXT_ATTR2 VARCHAR2(250),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	PROJECT_ID NUMBER,
	STATUS VARCHAR2(100)
   ) ;
  CREATE UNIQUE INDEX TMCS_STRATEGY_GROUP_PK ON TMCS_STRATEGY_GROUP (STRATEGY_GROUP_ID)
  ;
ALTER TABLE TMCS_STRATEGY_GROUP ADD CONSTRAINT TMCS_STRATEGY_GROUP_PK PRIMARY KEY (STRATEGY_GROUP_ID)
  USING INDEX TMCS_STRATEGY_GROUP_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_STRATEGY_GROUP_PK ON TMCS_STRATEGY_GROUP (STRATEGY_GROUP_ID)
  ;

