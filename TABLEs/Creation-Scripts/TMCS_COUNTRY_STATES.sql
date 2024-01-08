CREATE TABLE TMCS_COUNTRY_STATES
   (	COUNTRY_CODE_3 VARCHAR2(200),
	COUNTRY VARCHAR2(200),
	STATE_CODE VARCHAR2(200),
	STATE_NAME VARCHAR2(200),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	POPULATION NUMBER,
	HOUSEHOLD NUMBER
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_COUNTRY_STATES_PK ON TMCS_COUNTRY_STATES (COUNTRY_CODE_3, STATE_CODE)
  ;
ALTER TABLE TMCS_COUNTRY_STATES ADD CONSTRAINT TMCS_COUNTRY_STATES_PK PRIMARY KEY (COUNTRY_CODE_3, STATE_CODE)
  USING INDEX TMCS_COUNTRY_STATES_PK  ENABLE;
CREATE INDEX TMCS_COUNTRY_STATES_GIDX ON TMCS_COUNTRY_STATES (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_COUNTRY_STATES_PK ON TMCS_COUNTRY_STATES (COUNTRY_CODE_3, STATE_CODE)
  ;
CREATE INDEX TMCS_COUNTRY_STATES_IDX ON TMCS_COUNTRY_STATES (COUNTRY_CODE_3)
  ;
