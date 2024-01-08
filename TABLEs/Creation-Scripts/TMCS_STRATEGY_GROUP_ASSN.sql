CREATE TABLE TMCS_STRATEGY_GROUP_ASSN
   (	STRATEGY_GROUP_ID NUMBER,
	STORE_ID NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_STRATEGY_GROUP_ASSN_PK ON TMCS_STRATEGY_GROUP_ASSN (STRATEGY_GROUP_ID, STORE_ID)
  ;
ALTER TABLE TMCS_STRATEGY_GROUP_ASSN ADD CONSTRAINT TMCS_STRATEGY_GROUP_ASSN_PK PRIMARY KEY (STRATEGY_GROUP_ID, STORE_ID)
  USING INDEX TMCS_STRATEGY_GROUP_ASSN_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_STRATEGY_GROUP_ASSN_PK ON TMCS_STRATEGY_GROUP_ASSN (STRATEGY_GROUP_ID, STORE_ID)
  ;

