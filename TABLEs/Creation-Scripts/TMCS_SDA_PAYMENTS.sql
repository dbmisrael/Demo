CREATE TABLE TMCS_SDA_PAYMENTS
   (	PAYMENT_ID NUMBER,
	SDA_ID NUMBER NOT NULL ENABLE,
	PAYMENT_INSTALLMENT DATE,
	PAYMENT_TRANSFERRED VARCHAR2(100),
	PAYMENT_TOTAL NUMBER,
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	CUST_PMT_ID VARCHAR2(100),
	TYPE_OF_FEE VARCHAR2(100),
	TYPE_OF_UNIT VARCHAR2(50),
	STORE_OPEN_DATE DATE,
	STORE_CLOSE_DATE DATE,
	CONTRACT_BEGIN_DATE DATE,
	CONTRACT_EXP_DATE DATE,
	UPFRONT_FEE_STATUS VARCHAR2(100),
	UPFRONT_FEE_AMOUNT NUMBER,
	STORE_ID NUMBER,
	PAYMENT_TYPE VARCHAR2(50),
	COMMENTS VARCHAR2(4000),
	C_EXT_ATTR1 VARCHAR2(1000)
   ) ;
  CREATE UNIQUE INDEX TMCS_SDA_PAYMENTS_PK ON TMCS_SDA_PAYMENTS (PAYMENT_ID)
  ;
ALTER TABLE TMCS_SDA_PAYMENTS ADD CONSTRAINT TMCS_SDA_PAYMENTS_PK PRIMARY KEY (PAYMENT_ID)
  USING INDEX TMCS_SDA_PAYMENTS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SDA_PAYMENTS_PK ON TMCS_SDA_PAYMENTS (PAYMENT_ID)
  ;
