CREATE TABLE TMCS_SUBCONTRACTOR_DETAIL
   (	SUBC_DTL_ID NUMBER DEFAULT tmcs.tmcs_subcontractor_detail_s.nextval,
	SUBCONTRACTOR_NAME VARCHAR2(500),
	INV_NUMBER VARCHAR2(500),
	AMOUNT_WAIVED NUMBER,
	AMONT_PAID NUMBER,
	DATE_WAIVED DATE,
	DATE_PAID DATE,
	COMMENTS VARCHAR2(4000),
	IS_FINAL VARCHAR2(10),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER,
	SUBC_HEADER_ID NUMBER,
	AWS_KEY VARCHAR2(500),
	AWS_VERSIONID VARCHAR2(50),
	 PRIMARY KEY (SUBC_DTL_ID)
  USING INDEX  ENABLE
   ) ;

