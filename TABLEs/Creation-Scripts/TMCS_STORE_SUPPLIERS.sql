CREATE TABLE TMCS_STORE_SUPPLIERS
   (	STORE_SUPP_ID NUMBER,
	STORE_ID NUMBER,
	SUPPLIER_ID NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	COUNTRY VARCHAR2(250),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_STORE_SUPPLIERS_PK ON TMCS_STORE_SUPPLIERS (STORE_SUPP_ID)
  ;
ALTER TABLE TMCS_STORE_SUPPLIERS ADD CONSTRAINT TMCS_STORE_SUPPLIERS_PK PRIMARY KEY (STORE_SUPP_ID)
  USING INDEX TMCS_STORE_SUPPLIERS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_STORE_SUPPLIERS_PK ON TMCS_STORE_SUPPLIERS (STORE_SUPP_ID)
  ;

