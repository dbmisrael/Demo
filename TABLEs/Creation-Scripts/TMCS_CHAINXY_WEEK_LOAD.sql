CREATE TABLE TMCS_CHAINXY_WEEK_LOAD
   (	STORE_NAME VARCHAR2(500 CHAR),
	STORE_NUMBER VARCHAR2(500),
	CHAIN_ID NUMBER,
	CHAIN_NAME VARCHAR2(500),
	LABEL VARCHAR2(500 CHAR),
	PARENT_CHAIN_ID NUMBER,
	PARENT_CHAIN_NAME VARCHAR2(500),
	ADDRESS VARCHAR2(500 CHAR),
	ADDRESS2 VARCHAR2(500 CHAR),
	CITY VARCHAR2(500 CHAR),
	ZIP VARCHAR2(500 CHAR),
	STATE VARCHAR2(500 CHAR),
	PHONE VARCHAR2(500),
	STORE_TYPE VARCHAR2(500 CHAR),
	DISTRIBUTOR_NAME VARCHAR2(500 CHAR),
	STORE_HOURS VARCHAR2(3000),
	OTHER_FIELDS VARCHAR2(4000 CHAR),
	LATITUDE NUMBER,
	LONGITUDE NUMBER,
	GEO_ACCURACY VARCHAR2(500),
	HASH_ID VARCHAR2(1000),
	FIRST_APPEARED VARCHAR2(500),
	SIC VARCHAR2(500),
	NAICS VARCHAR2(250),
	CATEGORIES VARCHAR2(500),
	COUNTRY_CODE VARCHAR2(250),
	COUNTRY_NAME VARCHAR2(250),
	STATE_CODE VARCHAR2(250),
	STATE_NAME VARCHAR2(500 CHAR),
	CBSA_ID NUMBER,
	CBSA_NAME VARCHAR2(250 CHAR),
	COUNTY_FIPS VARCHAR2(250),
	COUNTY_NAME VARCHAR2(250),
	DMA_ID NUMBER,
	DMA_NAME VARCHAR2(250 CHAR),
	STATUS VARCHAR2(250),
	COUNTRY VARCHAR2(250),
	LAST_VENDOR_UPDATE DATE,
	ADD_ATTRIBUTES CLOB
   )
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY CHAINXY
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
         FIELDS TERMINATED BY |  OPTIONALLY ENCLOSED BY ''  LRTRIM
         MISSING FIELD VALUES ARE NULL
                 ( STORE_NAME           CHAR (500),
                   STORE_NUMBER         CHAR (500),
                   CHAIN_ID             CHAR (500),
                   CHAIN_NAME           CHAR (500),
                   LABEL                CHAR (500),
                   PARENT_CHAIN_ID      CHAR (500),
                   PARENT_CHAIN_NAME    CHAR (500),
                   ADDRESS              CHAR (500),
                   ADDRESS2             CHAR (500),
                   CITY                 CHAR (500),
                   ZIP                  CHAR (500),
                   STATE                CHAR (500),
                   PHONE                CHAR (500),
                   STORE_TYPE           CHAR (500),
                   DISTRIBUTOR_NAME     CHAR (500),
                   STORE_HOURS          CHAR (3000),
                   OTHER_FIELDS         CHAR (3000),
                   LATITUDE             CHAR (30),
                   LONGITUDE            CHAR (30),
                   GEO_ACCURACY         CHAR (500),
                   HASH_ID              CHAR (1000),
                   FIRST_APPEARED       CHAR (500),
                   SIC                  CHAR (500),
                   NAICS                CHAR (250),
                   CATEGORIES           CHAR (500),
                   COUNTRY_CODE         CHAR (250),
                   COUNTRY_NAME         CHAR (250),
                   STATE_CODE           CHAR (250),
                   STATE_NAME           CHAR (250),
                   CBSA_ID              CHAR (8),
                   CBSA_NAME            CHAR (250),
                   COUNTY_FIPS          CHAR (250),
                   COUNTY_NAME          CHAR (250),
                   DMA_ID               CHAR (8),
                   DMA_NAME             CHAR (250),
                   STATUS               CHAR (250),
                   COUNTRY              CHAR (250),
                   LAST_VENDOR_UPDATE   CHAR (25)  date_format DATE mask yyyy-MM-DD,
                   ADD_ATTRIBUTES	    CHAR(4000)
                )
       )
      LOCATION
       ( CHAINXY:'Chainxy_output_update1.csv'
       )
    )
   REJECT LIMIT UNLIMITED
  PARALLEL 10 ;

