CREATE GLOBAL TEMPORARY TABLE TMCS_GLOB_BRAND_ACCESS_TMP
   (	G_CLIENT_ID NUMBER,
	G_CLIENT_NAME VARCHAR2(50),
	G_BRAND_ID NUMBER,
	G_BRAND_NAME VARCHAR2(50),
	G_DIVISION_ID NUMBER,
	G_DIVISION_CODE VARCHAR2(50)
   ) ON COMMIT PRESERVE ROWS ;

