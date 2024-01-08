CREATE TABLE TMCS_FFE_PO_DETAIL
   (	FFE_PO_ITEM_ID NUMBER,
	FFE_PO_ID NUMBER,
	ITEM_SEQ_NO NUMBER,
	TASK_ID NUMBER,
	CURRENCY VARCHAR2(50),
	RATE NUMBER,
	QTY NUMBER,
	UOM VARCHAR2(50),
	AMOUNT NUMBER,
	DELIVERY_DATE DATE,
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	INV_ISSUE_AMOUNT NUMBER,
	BRAND_ID NUMBER,
	RECEIVED_QUANTITY NUMBER,
	COMMENTS VARCHAR2(4000),
	SELECT_FLAG VARCHAR2(10),
	FFE_BUDGET_ID NUMBER,
	AMOUNT_LOCAL NUMBER,
	AMOUNT_BU NUMBER,
	AMOUNT_USD NUMBER,
	INV_ISSUE_AMOUNT_LOCAL NUMBER,
	INV_ISSUE_AMOUNT_BU NUMBER,
	INV_ISSUE_AMOUNT_USD NUMBER,
	RECEIVED_QUANTITY_LOCAL NUMBER,
	RECEIVED_QUANTITY_BU NUMBER,
	RECEIVED_QUANTITY_USD NUMBER,
	 PRIMARY KEY (FFE_PO_ITEM_ID)
  USING INDEX  ENABLE
   ) ;

