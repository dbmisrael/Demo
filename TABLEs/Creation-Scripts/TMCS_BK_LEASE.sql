CREATE TABLE TMCS_BK_LEASE
   (	BK_LEASE_ID NUMBER NOT NULL ENABLE,
	STORE_ID NUMBER NOT NULL ENABLE,
	COMPANY_CODE VARCHAR2(50),
	REST_NUMBER VARCHAR2(30),
	LEASE_NUMBER VARCHAR2(30),
	DEAL_TYPE VARCHAR2(30),
	LEASE_TYPE VARCHAR2(30),
	RENT_EFFECTIVE_DATE DATE,
	RENT_END_DATE DATE,
	ULTIMATE_EXP_DATE DATE,
	RENT_AMOUNT NUMBER,
	FUTURE_RENT_DATE DATE,
	FUTURE_RENT_END_DATE DATE,
	FUTURE_RENT_AMOUNT NUMBER,
	PCT_TYPE VARCHAR2(10),
	PCT_RENT NUMBER,
	VS VARCHAR2(50),
	OPT_TRIGGER_DATE DATE,
	OPT_TRIGGER_START_DATE DATE,
	OPT_TRIGGER_END_DATE DATE,
	LL_TENANT_NAME VARCHAR2(100),
	COUNTRY_KEY VARCHAR2(10),
	ADDRESS VARCHAR2(100),
	CITY VARCHAR2(50),
	NET_BOOK_VALUE NUMBER,
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	C_EXT_ATTR1 VARCHAR2(250),
	C_EXT_ATTR2 VARCHAR2(250),
	C_EXT_ATTR3 VARCHAR2(250),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	C_EXT_LOV1 VARCHAR2(250),
	C_EXT_LOV2 VARCHAR2(250),
	C_EXT_LOV3 VARCHAR2(250)
   ) ;
  CREATE UNIQUE INDEX TMCS_BK_LEASE_PK ON TMCS_BK_LEASE (BK_LEASE_ID)
  ;
ALTER TABLE TMCS_BK_LEASE ADD CONSTRAINT TMCS_BK_LEASE_PK PRIMARY KEY (BK_LEASE_ID)
  USING INDEX TMCS_BK_LEASE_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_BK_LEASE_PK ON TMCS_BK_LEASE (BK_LEASE_ID)
  ;

