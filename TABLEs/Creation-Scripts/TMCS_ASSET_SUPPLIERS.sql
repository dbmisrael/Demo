CREATE TABLE TMCS_ASSET_SUPPLIERS
   (	ASSET_SUPPLIER_ID NUMBER,
	ASSET_ID NUMBER,
	SUPPLIER_SITE_ID NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	COUNTRY VARCHAR2(250),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 PRIMARY KEY (ASSET_SUPPLIER_ID)
  USING INDEX  ENABLE
   ) ;
