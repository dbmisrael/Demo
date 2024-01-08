CREATE TABLE TMCS_STORE_HOURS
   (	STORE_HOUR_ID NUMBER,
	STORE_ID NUMBER,
	OPNE_DAY VARCHAR2(50),
	OPEN_TIME_HH NUMBER,
	OPEN_TIME_MM NUMBER,
	CLOSE_TIME_HH NUMBER,
	CLOSE_TIME_MM NUMBER,
	OPEN_TIME_HH_LOV NUMBER,
	OPEN_TIME_MM_LOV NUMBER,
	CLOSE_TIME_HH_LOV NUMBER,
	CLOSE_TIME_MM_LOV NUMBER,
	COMMENTS VARCHAR2(500),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	C_EXT_LOV1 VARCHAR2(50),
	C_EXT_LOV2 VARCHAR2(50),
	C_EXT_LOV3 VARCHAR2(50),
	C_EXT_LOV4 VARCHAR2(50),
	C_EXT_LOV5 VARCHAR2(50),
	EXCEPTION_DATE DATE,
	 PRIMARY KEY (STORE_HOUR_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX UK_TMCS_STORE_HOURS ON TMCS_STORE_HOURS (STORE_ID)
  ;
