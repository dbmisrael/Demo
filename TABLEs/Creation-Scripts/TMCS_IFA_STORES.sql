CREATE TABLE TMCS_IFA_STORES
   (	IFA_STORE_ID NUMBER,
	IFA_ID NUMBER,
	STORE_ID NUMBER,
	ORG_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY_CODE VARCHAR2(50),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER DEFAULT 1,
	 CONSTRAINT TMCS_IFA_STORES_PK PRIMARY KEY (IFA_STORE_ID)
  USING INDEX  ENABLE
   ) ;
