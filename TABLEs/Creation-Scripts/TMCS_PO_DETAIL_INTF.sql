CREATE TABLE TMCS_PO_DETAIL_INTF
   (	PO_ITEM_ID NUMBER,
	PO_ID NUMBER,
	PO_NUMBER VARCHAR2(500),
	ITEM_SEQ_NO NUMBER,
	TASK_ID NUMBER,
	CURRENCY VARCHAR2(50),
	RATE NUMBER,
	QTY NUMBER,
	UOM VARCHAR2(50),
	AMOUNT NUMBER,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER,
	INV_ISSUE_AMOUNT NUMBER,
	BRAND_ID NUMBER,
	RECEIVED_QUANTITY NUMBER,
	COMMENTS VARCHAR2(4000),
	DELIVERY_DATE DATE,
	AMOUNT_LOCAL NUMBER,
	AMOUNT_BU NUMBER,
	AMOUNT_USD NUMBER,
	INV_ISSUE_AMOUNT_LOCAL NUMBER,
	INV_ISSUE_AMOUNT_BU NUMBER,
	INV_ISSUE_AMOUNT_USD NUMBER,
	RECEIVED_QUANTITY_LOCAL NUMBER,
	RECEIVED_QUANTITY_BU NUMBER,
	RECEIVED_QUANTITY_USD NUMBER,
	RETAINAGE_PCT NUMBER,
	STATUS VARCHAR2(50),
	UNAPPROVED_INV_AMT NUMBER,
	INV_ISSUE_RET_AMOUNT NUMBER,
	UNAPPROVED_INV_RET_AMT NUMBER,
	TAX_GROUP VARCHAR2(100),
	TAX_RATE NUMBER,
	VENDOR_TAX_AMOUNT NUMBER,
	ACCRUED_TAX_AMOUNT NUMBER,
	SEQUENCE NUMBER,
	UPLOAD_STATUS VARCHAR2(100),
	DIVISION VARCHAR2(100),
	TASK_TYPE VARCHAR2(100),
	SUB_TASK_TYPE VARCHAR2(100),
	TASK_NAME VARCHAR2(100),
	STORE_NUMBER VARCHAR2(100),
	TAXABLE VARCHAR2(50)
   ) ;
CREATE INDEX TMCS_PO_DETAIL_INTF_01 ON TMCS_PO_DETAIL_INTF (PO_ID)
  ;
CREATE INDEX TMCS_PO_DETAIL_INTF_02 ON TMCS_PO_DETAIL_INTF (PO_ITEM_ID)
  ;

