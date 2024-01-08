CREATE TABLE TMCS_SDA_AMENDMENTS
   (	AMENDMENT_ID NUMBER,
	SDA_ID NUMBER NOT NULL ENABLE,
	AMENDMENT_DATE DATE,
	AMENDMENT_TYPE VARCHAR2(100),
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	VERSION VARCHAR2(50),
	RATIONALE VARCHAR2(4000)
   ) ;
  CREATE UNIQUE INDEX TMCS_SDA_AMENDMENTS_PK ON TMCS_SDA_AMENDMENTS (AMENDMENT_ID)
  ;
ALTER TABLE TMCS_SDA_AMENDMENTS ADD CONSTRAINT TMCS_SDA_AMENDMENTS_PK PRIMARY KEY (AMENDMENT_ID)
  USING INDEX TMCS_SDA_AMENDMENTS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SDA_AMENDMENTS_PK ON TMCS_SDA_AMENDMENTS (AMENDMENT_ID)
  ;

