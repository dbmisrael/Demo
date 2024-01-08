CREATE TABLE TMCS_LOOKUP_VALUES_CUST
   (	LOOKUP_VALUE_ID NUMBER(*,0) NOT NULL ENABLE,
	LANGUAGE_CODE VARCHAR2(300) NOT NULL ENABLE,
	NAME VARCHAR2(300) NOT NULL ENABLE,
	DESCRIPTION VARCHAR2(240),
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	BRAND_ID NUMBER,
	LOOKUP_ID NUMBER,
	MULTIPLIER NUMBER,
	VERSION NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_LOOKUP_VALUES_CUST_PK ON TMCS_LOOKUP_VALUES_CUST (LOOKUP_VALUE_ID, LANGUAGE_CODE)
  ;
ALTER TABLE TMCS_LOOKUP_VALUES_CUST ADD CONSTRAINT TMCS_LOOKUP_VALUES_CUST_PK PRIMARY KEY (LOOKUP_VALUE_ID, LANGUAGE_CODE)
  USING INDEX TMCS_LOOKUP_VALUES_CUST_PK  ENABLE;
CREATE INDEX TMCS_LOOKUP_VALUES_CUST_INDX02 ON TMCS_LOOKUP_VALUES_CUST (LOOKUP_ID, LOOKUP_VALUE_ID)
  ;
CREATE UNIQUE INDEX TMCS_LOOKUP_VALUES_CUST_PK ON TMCS_LOOKUP_VALUES_CUST (LOOKUP_VALUE_ID, LANGUAGE_CODE)
  ;
CREATE INDEX TMCS_LOOKUP_VALUES_CUST_INDX01 ON TMCS_LOOKUP_VALUES_CUST (LOOKUP_ID)
  ;
