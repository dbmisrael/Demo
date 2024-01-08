CREATE TABLE TMCS_SNR_SEED_TARGET
   (	OPTIMIZATION_ID VARCHAR2(10) NOT NULL ENABLE,
	TARGET_ID NUMBER NOT NULL ENABLE,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_SNR_SEED_TARGET_PK ON TMCS_SNR_SEED_TARGET (OPTIMIZATION_ID, TARGET_ID)
  ;
ALTER TABLE TMCS_SNR_SEED_TARGET ADD CONSTRAINT TMCS_SNR_SEED_TARGET_PK PRIMARY KEY (OPTIMIZATION_ID, TARGET_ID)
  USING INDEX TMCS_SNR_SEED_TARGET_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SNR_SEED_TARGET_PK ON TMCS_SNR_SEED_TARGET (OPTIMIZATION_ID, TARGET_ID)
  ;

