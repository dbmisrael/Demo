CREATE TABLE TMCS_BIP_BURST_REPORTS_HDR
   (	BIP_ID NUMBER(10,0) NOT NULL ENABLE,
	CLIENT_ID NUMBER(10,0),
	BU_ID NUMBER(10,0),
	USER_NAME VARCHAR2(200),
	COUNTRY VARCHAR2(20),
	FREQUENCY VARCHAR2(200),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(50),
	 CONSTRAINT CUSTOMERS_PK PRIMARY KEY (BIP_ID)
  USING INDEX  ENABLE
   ) ;

