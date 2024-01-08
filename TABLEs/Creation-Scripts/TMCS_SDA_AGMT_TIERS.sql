CREATE TABLE TMCS_SDA_AGMT_TIERS
   (	TIER_ID NUMBER DEFAULT TMCS_SDA_AGMT_TIERS_S.NEXTVAL,
	AGREEMENT_ID NUMBER,
	SDA_ID NUMBER,
	TIER_NUMBER VARCHAR2(50),
	PERIOD_START_DATE DATE,
	PERIOD_END_DATE DATE,
	COMMENTS VARCHAR2(4000),
	UNIT_COMMITMENT NUMBER,
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER,
	BU_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	FORECASTED_NNU NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_SDA_AGMT_TIERS_PK ON TMCS_SDA_AGMT_TIERS (TIER_ID)
  ;
ALTER TABLE TMCS_SDA_AGMT_TIERS ADD CONSTRAINT TMCS_SDA_AGMT_TIERS_PK PRIMARY KEY (TIER_ID)
  USING INDEX TMCS_SDA_AGMT_TIERS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SDA_AGMT_TIERS_PK ON TMCS_SDA_AGMT_TIERS (TIER_ID)
  ;
