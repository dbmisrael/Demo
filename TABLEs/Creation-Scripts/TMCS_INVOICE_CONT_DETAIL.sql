CREATE TABLE TMCS_INVOICE_CONT_DETAIL
   (	INVOICE_CONT_DETAIL_ID NUMBER DEFAULT TMCS_INVOICE_CONT_DETAIL_S.NEXTVAL,
	INVOICE_ID NUMBER,
	PO_ID NUMBER,
	SUB_CONT_NAME VARCHAR2(200),
	PAID_AMOUNT NUMBER,
	COMMITMENT NUMBER,
	PA_WAIVERS NUMBER,
	WORK_DESC VARCHAR2(500),
	TRADE VARCHAR2(50),
	MBWB VARCHAR2(50),
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1
   ) ;
  CREATE UNIQUE INDEX TMCS_INVOICE_CONT_DETAIL_PK ON TMCS_INVOICE_CONT_DETAIL (INVOICE_CONT_DETAIL_ID)
  ;
ALTER TABLE TMCS_INVOICE_CONT_DETAIL ADD CONSTRAINT TMCS_INVOICE_CONT_DETAIL_PK PRIMARY KEY (INVOICE_CONT_DETAIL_ID)
  USING INDEX TMCS_INVOICE_CONT_DETAIL_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_INVOICE_CONT_DETAIL_PK ON TMCS_INVOICE_CONT_DETAIL (INVOICE_CONT_DETAIL_ID)
  ;
