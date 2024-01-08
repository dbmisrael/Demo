CREATE TABLE TMCS_INVOICE_DETAIL_HIST
   (	INVOICE_DETAIL_ID NUMBER,
	INVOICE_ID NUMBER,
	TASK_ID NUMBER,
	PO_AMOUNT NUMBER,
	CURRENCY VARCHAR2(50),
	INV_AMOUNT NUMBER,
	REMAINING_BAL NUMBER,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	NET_AMOUNT NUMBER,
	PO_ID NUMBER,
	BRAND_ID NUMBER,
	ITEM_SEQ_NO NUMBER,
	PO_AMOUNT_LOCAL NUMBER,
	PO_AMOUNT_BU NUMBER,
	PO_AMOUNT_USD NUMBER,
	INV_AMOUNT_LOCAL NUMBER,
	INV_AMOUNT_BU NUMBER,
	INV_AMOUNT_USD NUMBER,
	REMAINING_BAL_LOCAL NUMBER,
	REMAINING_BAL_BU NUMBER,
	REMAINING_BAL_USD NUMBER,
	NET_AMOUNT_LOCAL NUMBER,
	NET_AMOUNT_BU NUMBER,
	NET_AMOUNT_USD NUMBER,
	RETAINAGE_PCT NUMBER,
	STATUS VARCHAR2(50),
	CO_AMOUNT NUMBER,
	CO_AMOUNT_LOCAL NUMBER,
	CO_AMOUNT_BU NUMBER,
	CO_AMOUNT_USD NUMBER,
	REMAINING_PO_BALANCE NUMBER,
	REMAING_RET_AMT NUMBER,
	PCT_INV_AMT NUMBER,
	TAX_GROUP VARCHAR2(100),
	TAX_RATE NUMBER,
	VENDOR_TAX_AMOUNT NUMBER,
	ACCRUED_TAX_AMOUNT NUMBER,
	SEQUENCE NUMBER
   ) ;

