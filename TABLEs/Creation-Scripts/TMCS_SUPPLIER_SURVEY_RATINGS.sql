CREATE TABLE TMCS_SUPPLIER_SURVEY_RATINGS
   (	SUPPLIER_RATING_ID NUMBER DEFAULT TMCS_SUPPLIER_SURVEY_RATINGS_S.NEXTVAL,
	SUPPLIER_ID NUMBER,
	SUPPLIER_SITE_ID NUMBER,
	RATING_TYPE VARCHAR2(50),
	RATING NUMBER,
	RATING_RECORD VARCHAR2(500),
	RATING_DATE TIMESTAMP (6),
	RATED_BY VARCHAR2(500),
	CATEGORY VARCHAR2(50),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1
   ) ;
  CREATE UNIQUE INDEX TMCS_SUPPLIER_SURVEY_RATINGS_PK ON TMCS_SUPPLIER_SURVEY_RATINGS (SUPPLIER_RATING_ID)
  ;
ALTER TABLE TMCS_SUPPLIER_SURVEY_RATINGS ADD CONSTRAINT TMCS_SUPPLIER_SURVEY_RATINGS_PK PRIMARY KEY (SUPPLIER_RATING_ID)
  USING INDEX TMCS_SUPPLIER_SURVEY_RATINGS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SUPPLIER_SURVEY_RATINGS_PK ON TMCS_SUPPLIER_SURVEY_RATINGS (SUPPLIER_RATING_ID)
  ;

