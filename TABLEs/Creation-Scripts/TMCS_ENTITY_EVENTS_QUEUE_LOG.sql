CREATE TABLE TMCS_ENTITY_EVENTS_QUEUE_LOG
   (	AQ_SERVICE_LOG_ID NUMBER DEFAULT ON NULL TMCS_ENTITY_EVENTS_QUEUE_LOG_S.NEXTVAL NOT NULL ENABLE,
	EVENT_ID NUMBER,
	PROGRAM_NAME VARCHAR2(100),
	START_DATE DATE,
	END_DATE DATE,
	FILE_NAME VARCHAR2(200),
	MESSAGE_CODE NUMBER,
	MESSAGE VARCHAR2(4000),
	LOG_USER VARCHAR2(200),
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	ENTITY_NUMBER VARCHAR2(100),
	STATUS VARCHAR2(50)
   ) ;
  CREATE UNIQUE INDEX TMCS_ENTITY_EVENTS_QUEUE_LOG_PK ON TMCS_ENTITY_EVENTS_QUEUE_LOG (AQ_SERVICE_LOG_ID)
  ;
ALTER TABLE TMCS_ENTITY_EVENTS_QUEUE_LOG ADD CONSTRAINT TMCS_ENTITY_EVENTS_QUEUE_LOG_PK PRIMARY KEY (AQ_SERVICE_LOG_ID)
  USING INDEX TMCS_ENTITY_EVENTS_QUEUE_LOG_PK  ENABLE;
CREATE INDEX TMCS_ENTITY_EVENTS_QUEUE_LOG_INDX ON TMCS_ENTITY_EVENTS_QUEUE_LOG (CLIENT_ID)
  ;
CREATE UNIQUE INDEX TMCS_ENTITY_EVENTS_QUEUE_LOG_PK ON TMCS_ENTITY_EVENTS_QUEUE_LOG (AQ_SERVICE_LOG_ID)
  ;

