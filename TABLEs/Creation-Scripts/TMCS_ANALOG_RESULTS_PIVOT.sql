CREATE TABLE TMCS_ANALOG_RESULTS_PIVOT
   (	ANALOG_ID NUMBER,
	ENTITY_TYPE VARCHAR2(500),
	STORE_ID NUMBER,
	SECTION_NAME VARCHAR2(240),
	ATTRIBUTE_NAME VARCHAR2(300),
	ATTRIBUTE_VALUE VARCHAR2(300),
	DISPLAY_ORDER NUMBER,
	COMMENTS VARCHAR2(500),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	SUB_SECTION VARCHAR2(240),
	STORE_NUMBER VARCHAR2(50)
   ) ;

