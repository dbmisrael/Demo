CREATE TABLE TMCS_PO_HEADER
   (	PO_ID NUMBER,
	PO_NUMBER VARCHAR2(200),
	PROJECT_ID NUMBER,
	ISSUE_DATE DATE,
	DUE_DATE DATE,
	STATUS VARCHAR2(50),
	PATMENT_TERMS VARCHAR2(50),
	CURRENCY VARCHAR2(50),
	AMOUNT NUMBER,
	ISSUED_BY VARCHAR2(100),
	APPROVED_BY VARCHAR2(100),
	APPROVED_DATE DATE,
	SUPPLIER_ID NUMBER,
	SUPPLIER_SITE_ID NUMBER,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	RETAINAGE_PCT NUMBER,
	BRAND_ID NUMBER,
	COMMENTS VARCHAR2(4000),
	WF_STATUS VARCHAR2(100),
	DELIVERY_DATE DATE,
	LEGAL_COMPANY VARCHAR2(200),
	PO_TYPE VARCHAR2(100),
	EXPORTED_FLAG VARCHAR2(10),
	AMOUNT_LOCAL NUMBER,
	AMOUNT_BU NUMBER,
	AMOUNT_USD NUMBER,
	BUYER_CODE VARCHAR2(200),
	BUYER_NAME VARCHAR2(200),
	LINK_FFE_PO_ID NUMBER,
	C_EXT_LOV1 VARCHAR2(100),
	SHIP_TO VARCHAR2(4000),
	BID_REFERENCE_NUMBER VARCHAR2(500),
	INSURANCE_VALID VARCHAR2(20),
	INSURANCE_REASON VARCHAR2(2000),
	UNALLOCATED_AMOUNT NUMBER,
	ALLOCATION_START_DATE DATE,
	NUMBER_OF_MONTHS NUMBER,
	ALLOCATION_COMMENTS VARCHAR2(4000),
	PO_GUID VARCHAR2(50),
	EXCHG_RATE NUMBER,
	SHP_DELVR_NAME VARCHAR2(500),
	SHP_DELVR_COMP VARCHAR2(500),
	SHP_DELVR_EMAIL VARCHAR2(500),
	SHP_DELVR_PHONE VARCHAR2(500),
	SHP_DELVER_ADD1 VARCHAR2(500),
	SHP_DELVR_ADDR2 VARCHAR2(500),
	SHP_DELVR_CITY VARCHAR2(500),
	SHP_DELVR_STATE VARCHAR2(500),
	SHP_DELVR_PINCODE VARCHAR2(500),
	SHP_DELVR_COUNTRY VARCHAR2(500),
	SHP_DELVR_TLOCATION VARCHAR2(500),
	SHP_DELVR_TROOM VARCHAR2(500),
	SHP_DELVR_PLANTCODE VARCHAR2(500),
	APPROVED_CO_AMOUNT NUMBER,
	C_EXT_ATTR1 VARCHAR2(100),
	C_EXT_LOV2 VARCHAR2(200),
	ADDL_COMMENTS VARCHAR2(4000),
	C_EXT_LOV3 VARCHAR2(100),
	STAGING_ID NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_PO_HEADER_PK ON TMCS_PO_HEADER (PO_ID)
  ;
ALTER TABLE TMCS_PO_HEADER ADD CONSTRAINT TMCS_PO_HEADER_PK PRIMARY KEY (PO_ID)
  USING INDEX TMCS_PO_HEADER_PK  ENABLE;
CREATE INDEX TMCS_PO_HEADER_INDX01 ON TMCS_PO_HEADER (PROJECT_ID)
  ;
CREATE INDEX TMCS_PO_HEADER_INDX5 ON TMCS_PO_HEADER (CLIENT_ID)
  ;
CREATE INDEX TMCS_PO_HEADER_INDX2 ON TMCS_PO_HEADER (SUPPLIER_ID)
  ;
CREATE INDEX TMCS_PO_HEADER_INDX3 ON TMCS_PO_HEADER (SUPPLIER_SITE_ID)
  ;
CREATE UNIQUE INDEX TMCS_PO_HEADER_PK ON TMCS_PO_HEADER (PO_ID)
  ;
CREATE INDEX TMCS_PO_HEADER_INDX4 ON TMCS_PO_HEADER (STATUS)
  ;

