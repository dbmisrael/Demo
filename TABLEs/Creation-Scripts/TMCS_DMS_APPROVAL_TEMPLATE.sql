CREATE TABLE TMCS_DMS_APPROVAL_TEMPLATE
   (	DOCUMENT_TYPE_ID NUMBER NOT NULL ENABLE,
	DOCUMENT_TYPE VARCHAR2(100),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	ENTITY_TYPE VARCHAR2(20),
	REQUIRED VARCHAR2(10) DEFAULT 'N',
	SEQ_NO NUMBER,
	BU_ID NUMBER,
	COUNTRY VARCHAR2(100),
	TEMPLATE VARCHAR2(500),
	PROJECT_TYPE VARCHAR2(100)
   ) ;
  CREATE UNIQUE INDEX TMCS_DMS_APPROVAL_TEMPLATE_PK ON TMCS_DMS_APPROVAL_TEMPLATE (DOCUMENT_TYPE_ID)
  ;
ALTER TABLE TMCS_DMS_APPROVAL_TEMPLATE ADD CONSTRAINT TMCS_DMS_APPROVAL_TEMPLATE_PK PRIMARY KEY (DOCUMENT_TYPE_ID)
  USING INDEX TMCS_DMS_APPROVAL_TEMPLATE_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_DMS_APPROVAL_TEMPLATE_PK ON TMCS_DMS_APPROVAL_TEMPLATE (DOCUMENT_TYPE_ID)
  ;
