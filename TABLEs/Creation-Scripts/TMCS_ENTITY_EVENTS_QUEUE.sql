CREATE TABLE TMCS_ENTITY_EVENTS_QUEUE
   (	EVENT_ID NUMBER DEFAULT TMCS_ENTITY_EVENTS_QUEUE_S.NEXTVAL,
	EVENT_TYPE VARCHAR2(100) NOT NULL ENABLE,
	ENTITY_TYPE VARCHAR2(100) NOT NULL ENABLE,
	ENTITY_ID NUMBER NOT NULL ENABLE,
	STATUS VARCHAR2(50) DEFAULT 'N',
	MODULE VARCHAR2(100),
	TRIGGERING_TABLE VARCHAR2(100),
	EVENT_DATA CLOB,
	CLIENT_ID NUMBER NOT NULL ENABLE,
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATION_DATE TIMESTAMP (6) DEFAULT SYSDATE,
	CREATED_BY VARCHAR2(200) NOT NULL ENABLE,
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1
   ) ;
  CREATE UNIQUE INDEX TMCS_ENTITY_EVENTS_QUEUE_PK ON TMCS_ENTITY_EVENTS_QUEUE (EVENT_ID)
  ;
ALTER TABLE TMCS_ENTITY_EVENTS_QUEUE ADD CONSTRAINT TMCS_ENTITY_EVENTS_QUEUE_PK PRIMARY KEY (EVENT_ID)
  USING INDEX TMCS_ENTITY_EVENTS_QUEUE_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_ENTITY_EVENTS_QUEUE_PK ON TMCS_ENTITY_EVENTS_QUEUE (EVENT_ID)
  ;
