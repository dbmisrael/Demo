CREATE TABLE TMCS_CLIENT_USER_MAP_ROLES
   (	USER_NAME VARCHAR2(200) NOT NULL ENABLE,
	CLIENT_ID NUMBER NOT NULL ENABLE,
	ROLES VARCHAR2(4000),
	 CONSTRAINT TMCS_CLIENT_USER_MAP_ROLE_UK1 UNIQUE (USER_NAME, CLIENT_ID)
  USING INDEX  ENABLE
   ) ;
