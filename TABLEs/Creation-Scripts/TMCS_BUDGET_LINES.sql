CREATE TABLE TMCS_BUDGET_LINES
   (	BUDGET_ID NUMBER,
	LINE_ID NUMBER,
	VERSION_NUMBER NUMBER,
	CSI VARCHAR2(100),
	PRICE NUMBER,
	QUANTITY NUMBER,
	AMOUNT NUMBER,
	PRICE2 NUMBER,
	QUANTITY2 NUMBER,
	AMOUNT2 NUMBER,
	REVISED_FLAG VARCHAR2(1),
	PARENT NUMBER,
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
  CREATE UNIQUE INDEX TMCS_BUDGET_LINES_PK ON TMCS_BUDGET_LINES (BUDGET_ID)
  ;
ALTER TABLE TMCS_BUDGET_LINES ADD CONSTRAINT TMCS_BUDGET_LINES_PK PRIMARY KEY (BUDGET_ID)
  USING INDEX TMCS_BUDGET_LINES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_BUDGET_LINES_PK ON TMCS_BUDGET_LINES (BUDGET_ID)
  ;
