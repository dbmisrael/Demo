CREATE TABLE TMCS_ANALOG_RESULTS_COMMENTS
   (	ANALOG_ID NUMBER,
	MAIN_COMMENTS VARCHAR2(4000),
	TA_COMMENTS VARCHAR2(4000),
	SC_COMMENTS VARCHAR2(4000),
	COMP_COMMENTS VARCHAR2(4000),
	SALES_COMMENTS VARCHAR2(4000),
	MISC_COMMENTS VARCHAR2(4000),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER
   ) ;

