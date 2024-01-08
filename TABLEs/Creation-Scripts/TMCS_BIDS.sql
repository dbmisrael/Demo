CREATE TABLE TMCS_BIDS
   (	BID_ID NUMBER DEFAULT tmcs.tmcs_bids_s.nextval,
	BID_NAME VARCHAR2(500),
	BID_REFERENCE_NUMBER VARCHAR2(500),
	PROJECT_ID NUMBER,
	STATUS VARCHAR2(50),
	BID_MANAGER VARCHAR2(100),
	BID_MANAGER_EMAIL VARCHAR2(100),
	PROJECT_MANAGER VARCHAR2(100),
	PROJECT_MANAGER_EMAIL VARCHAR2(100),
	ARCHITECT VARCHAR2(100),
	ARCHITECT_EMAIL VARCHAR2(100),
	DESIGN_MANAGER VARCHAR2(100),
	DESIGN_MANAGER_EMAIL VARCHAR2(100),
	OPEN_DATE DATE,
	INTENT_TO_BID_DATE DATE,
	QA_END_DATE DATE,
	EXPIRATION_DATE DATE,
	SOLICITED_SUPPLIERS VARCHAR2(100),
	AWARDED_SUPPLIER VARCHAR2(100),
	AWARDED_AMOUNT NUMBER,
	AWARDED_DATE DATE,
	AWARD_JUSTIFICATION VARCHAR2(1000),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	EDGE_BID_ID NUMBER,
	 PRIMARY KEY (BID_ID)
  USING INDEX  ENABLE
   ) ;
