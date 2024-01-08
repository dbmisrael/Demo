CREATE TABLE TMCS_TARGET_FRANSCHISEES
   (	TARGET_ID NUMBER,
	SDA_ID NUMBER,
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	PRIMARY_FRANCHISEE VARCHAR2(1) DEFAULT 'N',
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200)
   ) ;
  CREATE UNIQUE INDEX TMCS_TARGET_FRANSCHISEES_PK ON TMCS_TARGET_FRANSCHISEES (TARGET_ID, SDA_ID)
  ;
ALTER TABLE TMCS_TARGET_FRANSCHISEES ADD CONSTRAINT TMCS_TARGET_FRANSCHISEES_PK PRIMARY KEY (TARGET_ID, SDA_ID)
  USING INDEX TMCS_TARGET_FRANSCHISEES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_TARGET_FRANSCHISEES_PK ON TMCS_TARGET_FRANSCHISEES (TARGET_ID, SDA_ID)
  ;
