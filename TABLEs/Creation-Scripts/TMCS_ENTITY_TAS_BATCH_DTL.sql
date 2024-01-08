CREATE TABLE TMCS_ENTITY_TAS_BATCH_DTL
   (	BATCH_DETAIL_ID NUMBER,
	BATCH_ID NUMBER,
	ENTITY_TYPE VARCHAR2(3200),
	ENTITY_NUMBER VARCHAR2(3200),
	TA_TYPE VARCHAR2(3200),
	TA_DESCRIPTION VARCHAR2(4000),
	GEOM_STRING CLOB,
	STATUS VARCHAR2(4000),
	COUNTRY VARCHAR2(3200),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	MESSAGE VARCHAR2(4000),
	 PRIMARY KEY (BATCH_DETAIL_ID)
  USING INDEX  ENABLE
   ) ;
