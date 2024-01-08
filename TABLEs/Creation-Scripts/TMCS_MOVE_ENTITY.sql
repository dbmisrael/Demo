CREATE TABLE TMCS_MOVE_ENTITY
   (	MOVE_ID NUMBER,
	ENTITY_TYPE VARCHAR2(320),
	ENTITY_ID VARCHAR2(320),
	ENTITY_NUMBER VARCHAR2(320),
	OLD_LONGITUDE NUMBER,
	OLD_LATITUDE NUMBER,
	NEW_LONGITUDE NUMBER,
	NEW_LATITUDE NUMBER,
	STATUS VARCHAR2(320),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	APPROVED_BY VARCHAR2(320),
	APPROVAL_DATE TIMESTAMP (6),
	COUNTRY VARCHAR2(100),
	BATCH_ID NUMBER,
	 PRIMARY KEY (MOVE_ID)
  USING INDEX  ENABLE
   ) ;

