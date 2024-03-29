CREATE TABLE TMCS_CLIENT_BRANDS
   (	CLIENT_BRAND_ID NUMBER NOT NULL ENABLE,
	CLIENT_ID NUMBER(*,0),
	BRAND_NAME VARCHAR2(100),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	BRAND_CODE VARCHAR2(50)
   ) ;
  CREATE UNIQUE INDEX TMCS_CLIENT_BRANDS_PK ON TMCS_CLIENT_BRANDS (CLIENT_BRAND_ID)
  ;
ALTER TABLE TMCS_CLIENT_BRANDS ADD CONSTRAINT TMCS_CLIENT_BRANDS_PK PRIMARY KEY (CLIENT_BRAND_ID)
  USING INDEX TMCS_CLIENT_BRANDS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_CLIENT_BRANDS_PK ON TMCS_CLIENT_BRANDS (CLIENT_BRAND_ID)
  ;

