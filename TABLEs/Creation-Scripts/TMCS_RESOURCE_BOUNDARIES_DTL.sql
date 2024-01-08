CREATE TABLE TMCS_RESOURCE_BOUNDARIES_DTL
   (	BOUNDRY_DTL_ID NUMBER,
	RESOURCE_BOUNDRY_ID NUMBER,
	RESOURCE_ROLE VARCHAR2(250),
	RESOURCE_NAME VARCHAR2(100),
	RESOURCE_USER_ID VARCHAR2(100),
	EMAIL VARCHAR2(100),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	LAST_NAME VARCHAR2(100),
	IS_SYSTEM_USER VARCHAR2(1),
	PO_APPROVAL_LIMIT NUMBER,
	RESOURCE_TYPE VARCHAR2(10),
	N_EXT_ATTR1 NUMBER,
	PHONE_NUMBER VARCHAR2(100),
	SEQ_NUMBER NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	WORKFLOW_CONTACT_FLAG VARCHAR2(10),
	 PRIMARY KEY (BOUNDRY_DTL_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX TMCS_RESOURCE_BOUNDARIES_DTL_IDX01 ON TMCS_RESOURCE_BOUNDARIES_DTL (RESOURCE_BOUNDRY_ID)
  ;

