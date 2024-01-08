CREATE TABLE TMCS_CLIENT_COUNTRIES_LOCALE
   (	CLIENT_ID NUMBER NOT NULL ENABLE,
	COUNTRY_CODE VARCHAR2(30),
	LANGUAGE VARCHAR2(100) NOT NULL ENABLE,
	DEFAULT_LOCALE VARCHAR2(100) NOT NULL ENABLE,
	LANGUAGE_LOCALE VARCHAR2(100) NOT NULL ENABLE,
	CREATED_BY VARCHAR2(200) DEFAULT 'sysadmin',
	CREATION_DATE DATE DEFAULT sysdate,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	LOCALE_ID NUMBER DEFAULT TMCS_CLIENT_COUNTRIES_LOCALE_S.nextval NOT NULL ENABLE,
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	MAP_LOCALE VARCHAR2(50) DEFAULT 'en',
	 CONSTRAINT TMCS_CLIENT_COUNTRIES_LOCA_U01 UNIQUE (COUNTRY_CODE, CLIENT_ID, LANGUAGE_LOCALE, BRAND_ID, BU_ID)
  USING INDEX  ENABLE,
	 CONSTRAINT TMCS_CLIENT_COUNTRIES_LOCALEPK PRIMARY KEY (LOCALE_ID)
  USING INDEX  ENABLE
   ) ;

