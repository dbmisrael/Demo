CREATE TABLE TMCS_CRIME_HEX_AGG_DATA
   (	ARREST NUMBER(18,6),
	ARREST_COUNT NUMBER(18,6),
	ARSON NUMBER(18,6),
	ARSON_COUNT NUMBER(18,6),
	ASSAULT NUMBER(18,6),
	ASSAULT_COUNT NUMBER(18,6),
	BURGLARY NUMBER(18,6),
	BURGLARY_COUNT NUMBER(18,6),
	OTHER NUMBER(18,6),
	OTHER_COUNT NUMBER(18,6),
	ROBBERY NUMBER(18,6),
	ROBBERY_COUNT NUMBER(18,6),
	SHOOTING NUMBER(18,6),
	SHOOTING_COUNT NUMBER(18,6),
	THEFT NUMBER(18,6),
	THEFT_COUNT NUMBER(18,6),
	VANDALISM NUMBER(18,6),
	VANDALISM_COUNT NUMBER(18,6),
	TOTAL NUMBER(18,6),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_CRIME_HEX_AGG_DATA_GIDX ON TMCS_CRIME_HEX_AGG_DATA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

