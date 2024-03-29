CREATE TABLE TMCS_INTERFACE_FIELD_MAPPING
   (	INTERFACE_ID NUMBER,
	INTERFACE_FIELD_NAME VARCHAR2(50),
	INTERFACE_FIELD_ORDER_OLD VARCHAR2(50),
	INTERFACE_FIELD_TYPE VARCHAR2(10),
	TMCS_DB_TABLE_NAME VARCHAR2(50),
	TMCS_DB_FIELD_NAME VARCHAR2(1000),
	MAPPING_COMMENTS VARCHAR2(500),
	DB_FIELD_UPDATE_YN VARCHAR2(1),
	DB_FIELD_INSERT_YN VARCHAR2(1),
	MAPPING_CALCULATIONS VARCHAR2(2000),
	TABLE_EXECUTE_ORDER NUMBER,
	RECORD_ACTIVE_YN VARCHAR2(1),
	DATE_CREATED DATE,
	CREATED_BY VARCHAR2(100),
	INTERFACE_FIELD_ORDER NUMBER,
	INTERFACE_FIELD_DATE_FORMAT VARCHAR2(100),
	IS_REQUIRED VARCHAR2(100)
   ) ;

