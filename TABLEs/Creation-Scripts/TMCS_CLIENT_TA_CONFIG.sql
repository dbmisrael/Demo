CREATE TABLE TMCS_CLIENT_TA_CONFIG
   (	CLIENT_CONFIG_ID NUMBER(*,0) DEFAULT TMCS_CLIENT_TA_CONFIG_S.NEXTVAL,
	CLIENT_ID NUMBER(*,0),
	COUNTRY_CODE VARCHAR2(10),
	BRAND_ID NUMBER(*,0),
	TA_PARAM_VALUE VARCHAR2(100),
	TA_TYPE VARCHAR2(10),
	DEFAULT_TA VARCHAR2(10),
	MODEL_TYPE VARCHAR2(10),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_CLIENT_TA_CONFIG_PK ON TMCS_CLIENT_TA_CONFIG (CLIENT_CONFIG_ID, CLIENT_ID, COUNTRY_CODE, BRAND_ID, TA_PARAM_VALUE, TA_TYPE)
  ;
ALTER TABLE TMCS_CLIENT_TA_CONFIG ADD CONSTRAINT TMCS_CLIENT_TA_CONFIG_PK PRIMARY KEY (CLIENT_CONFIG_ID, CLIENT_ID, COUNTRY_CODE, BRAND_ID, TA_PARAM_VALUE, TA_TYPE)
  USING INDEX TMCS_CLIENT_TA_CONFIG_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_CLIENT_TA_CONFIG_PK ON TMCS_CLIENT_TA_CONFIG (CLIENT_CONFIG_ID, CLIENT_ID, COUNTRY_CODE, BRAND_ID, TA_PARAM_VALUE, TA_TYPE)
  ;

