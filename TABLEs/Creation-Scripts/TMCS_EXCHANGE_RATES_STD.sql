CREATE TABLE TMCS_EXCHANGE_RATES_STD
   (	EXCHG_RATE_ID NUMBER(15,0) DEFAULT TMCS_EXCHANGE_RATES_S.NEXTVAL,
	SOURCE_CURRENCY_CODE VARCHAR2(15),
	TO_CURRENCY_CODE VARCHAR2(15),
	EXCHANGE_RATE NUMBER,
	EXCHG_RATE_DATE DATE,
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	CLIENT_ID NUMBER,
	COUNTRY VARCHAR2(100),
	BRAND_ID NUMBER,
	ORG_ID NUMBER,
	EFFECTIVE_DATE DATE,
	END_DATE DATE,
	EXCHANGE_RATE_AVG NUMBER,
	 PRIMARY KEY (EXCHG_RATE_ID)
  USING INDEX  ENABLE
   ) ;

