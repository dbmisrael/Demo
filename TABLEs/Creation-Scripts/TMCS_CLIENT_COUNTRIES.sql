CREATE TABLE TMCS_CLIENT_COUNTRIES
   (	CLIENT_COUNTRY_ID NUMBER(38,0) DEFAULT TMCS_CLIENT_COUNTRIES_S.nextval,
	CLIENT_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATION_DATE DATE DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	BU_ID NUMBER,
	SHOPPING_CENTER_SRC_CODE VARCHAR2(20),
	BASE_MAP VARCHAR2(20) DEFAULT 'GOOGLE',
	BRAND_ID NUMBER,
	INSERT_SECONDARY_SALES VARCHAR2(10) DEFAULT 'N',
	COUNTRY_CURRENCY VARCHAR2(10),
	DEF_LANG_CODE VARCHAR2(20),
	UOM VARCHAR2(50),
	DIALING_CODE VARCHAR2(100),
	HIJRI_CALENDAR VARCHAR2(20) DEFAULT 'N',
	SPACE_UOM VARCHAR2(10) DEFAULT 'I',
	 PRIMARY KEY (CLIENT_COUNTRY_ID)
  USING INDEX  ENABLE
   ) ;
