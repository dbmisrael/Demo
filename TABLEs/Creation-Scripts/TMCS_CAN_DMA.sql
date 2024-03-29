CREATE TABLE TMCS_CAN_DMA
   (	GEO_NAME VARCHAR2(100),
	GEO_NUMBER VARCHAR2(100),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_CAN_DMA_GIDX ON TMCS_CAN_DMA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

