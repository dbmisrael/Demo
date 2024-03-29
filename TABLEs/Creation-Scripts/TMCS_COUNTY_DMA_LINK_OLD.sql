CREATE TABLE TMCS_COUNTY_DMA_LINK_OLD
   (	NAME VARCHAR2(31),
	STATE_NAME VARCHAR2(20),
	STATE_FIPS VARCHAR2(2),
	CNTY_FIPS VARCHAR2(3),
	FIPS VARCHAR2(5) NOT NULL ENABLE,
	X NUMBER,
	Y NUMBER,
	DMA_NUM VARCHAR2(5)
   ) ;
  CREATE UNIQUE INDEX TMCS_COUNTY_DMA_LINK_PK ON TMCS_COUNTY_DMA_LINK_OLD (FIPS)
  ;
ALTER TABLE TMCS_COUNTY_DMA_LINK_OLD ADD CONSTRAINT TMCS_COUNTY_DMA_LINK_PK PRIMARY KEY (FIPS)
  USING INDEX TMCS_COUNTY_DMA_LINK_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_COUNTY_DMA_LINK_PK ON TMCS_COUNTY_DMA_LINK_OLD (FIPS)
  ;

