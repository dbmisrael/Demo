CREATE TABLE TMCS_BUDGET_HEADERS
   (	BUDGET_ID NUMBER,
	SITE_ID NUMBER,
	FICAL_YEAR NUMBER,
	BUDGET_TYPE VARCHAR2(50),
	VERSION_NUMBER NUMBER,
	CURRENCY_CODE VARCHAR2(50),
	TOTAL_AMOUNT NUMBER,
	REVISED_FLAG VARCHAR2(1),
	PARENT NUMBER,
	STATUS VARCHAR2(20),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_BUDGET_HEADERS_PK ON TMCS_BUDGET_HEADERS (BUDGET_ID)
  ;
ALTER TABLE TMCS_BUDGET_HEADERS ADD CONSTRAINT TMCS_BUDGET_HEADERS_PK PRIMARY KEY (BUDGET_ID)
  USING INDEX TMCS_BUDGET_HEADERS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_BUDGET_HEADERS_PK ON TMCS_BUDGET_HEADERS (BUDGET_ID)
  ;

