CREATE TABLE TMCS_GENERAL_CLIENT_SETUP
   (	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	TMC_FUNCTIONALITY VARCHAR2(200),
	TMC_PACKAGE VARCHAR2(500),
	 CONSTRAINT PRIMARY_KEY PRIMARY KEY (TMC_FUNCTIONALITY, CLIENT_ID)
  USING INDEX  ENABLE
   ) ;

