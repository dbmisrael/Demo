CREATE TABLE TMCS_SESSION_INFO
   (	ID NUMBER(*,0) NOT NULL ENABLE,
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	ENTITY_ID VARCHAR2(30),
	ENTITY_TYPE VARCHAR2(30),
	CREATE_DATE DATE
   ) ;
  CREATE UNIQUE INDEX TMCS_SESSION_INFO_PK ON TMCS_SESSION_INFO (ID)
  ;
ALTER TABLE TMCS_SESSION_INFO ADD CONSTRAINT TMCS_SESSION_INFO_PK PRIMARY KEY (ID)
  USING INDEX TMCS_SESSION_INFO_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SESSION_INFO_PK ON TMCS_SESSION_INFO (ID)
  ;

