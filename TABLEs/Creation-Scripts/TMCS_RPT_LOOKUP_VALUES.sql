CREATE GLOBAL TEMPORARY TABLE TMCS_RPT_LOOKUP_VALUES
   (	LOOKUP_KEY VARCHAR2(500),
	LOOKUP_VALUE VARCHAR2(300),
	 PRIMARY KEY (LOOKUP_KEY) ENABLE
   ) ON COMMIT DELETE ROWS ;
