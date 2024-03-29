CREATE MATERIALIZED VIEW TMCS_ALL_COMPETITORS_STD_MV (COMPETITOR_ID, HASH_ID, STORE_NUMBER, STORE_NAME, STORE_TYPE, CHAIN_ID, CHAIN_NAME, PARENT_CHAIN_ID, PARENT_CHAIN_NAME, LABEL, ADDRESS, ADDRESS2, CITY, STATE, ZIP, COUNTRY, PHONE, GEOMETRY, LATITUDE, LONGITUDE, GEO_ACCURACY, DISTRIBUTOR_NAME, STORE_HOURS, OTHER_FIELDS, SALES, FIRST_APPEARED, SIC, NAICS, CATEGORIES, COMP_SOURCE, STATUS, COMMENTS, CBSA_ID, CBSA_NAME, MSA_ID, MSA_NAME, DMA_ID, DMA_NAME, COUNTY, COUNTY_FIPS, COUNTRY_CODE, COUNTRY_NAME, STATE_CODE, STATE_NAME, LAST_VENDOR_UPDATE, C_EXT_ATTR1, C_EXT_ATTR2, C_EXT_ATTR3, C_EXT_ATTR4, C_EXT_ATTR5, C_EXT_ATTR6, C_EXT_ATTR7, C_EXT_ATTR8, C_EXT_ATTR9, C_EXT_ATTR10, C_EXT_ATTR11, C_EXT_ATTR12, C_EXT_ATTR13, C_EXT_ATTR14, C_EXT_ATTR15, C_EXT_ATTR16, C_EXT_ATTR17, C_EXT_ATTR18, C_EXT_ATTR19, C_EXT_ATTR20, C_EXT_ATTR21, C_EXT_ATTR22, C_EXT_ATTR23, C_EXT_ATTR24, C_EXT_ATTR25, C_EXT_ATTR26, C_EXT_ATTR27, C_EXT_ATTR28, C_EXT_ATTR29, C_EXT_ATTR30, C_EXT_ATTR31, C_EXT_ATTR32, C_EXT_ATTR33, C_EXT_ATTR34, C_EXT_ATTR35, C_EXT_ATTR36, C_EXT_ATTR37, C_EXT_ATTR38, C_EXT_ATTR39, C_EXT_ATTR40, C_EXT_ATTR41, C_EXT_ATTR42, C_EXT_ATTR43, C_EXT_ATTR44, C_EXT_ATTR45, C_EXT_ATTR46, C_EXT_ATTR47, C_EXT_ATTR48, C_EXT_ATTR49, C_EXT_ATTR50, C_EXT_ATTR51, C_EXT_ATTR52, C_EXT_ATTR53, C_EXT_ATTR54, C_EXT_ATTR55, C_EXT_ATTR56, C_EXT_ATTR57, C_EXT_ATTR58, C_EXT_ATTR59, C_EXT_ATTR60, C_EXT_ATTR61, C_EXT_ATTR62, C_EXT_ATTR63, C_EXT_ATTR64, C_EXT_ATTR65, C_EXT_ATTR66, C_EXT_ATTR67, C_EXT_ATTR68, C_EXT_ATTR69, C_EXT_ATTR70, C_EXT_ATTR71, C_EXT_ATTR72, C_EXT_ATTR73, C_EXT_ATTR74, C_EXT_ATTR75, N_EXT_ATTR1, N_EXT_ATTR2, N_EXT_ATTR3, N_EXT_ATTR4, N_EXT_ATTR5, N_EXT_ATTR6, N_EXT_ATTR7, N_EXT_ATTR8, N_EXT_ATTR9, N_EXT_ATTR10, N_EXT_ATTR11, N_EXT_ATTR12, N_EXT_ATTR13, N_EXT_ATTR14, N_EXT_ATTR15, N_EXT_ATTR16, N_EXT_ATTR17, N_EXT_ATTR18, N_EXT_ATTR19, N_EXT_ATTR20, D_EXT_ATTR1, D_EXT_ATTR2, D_EXT_ATTR3, D_EXT_ATTR4, D_EXT_ATTR5, D_EXT_ATTR6, D_EXT_ATTR7, D_EXT_ATTR8, D_EXT_ATTR9, D_EXT_ATTR10, MI_PRINX, C_EXT_LOV1, C_EXT_LOV2, C_EXT_LOV3, C_EXT_LOV4, C_EXT_LOV5, C_EXT_LOV6, C_EXT_LOV7, C_EXT_LOV8, C_EXT_LOV9, C_EXT_LOV10, CUST_SALES, CUST_LATITUDE, CUST_LONGITUDE, CUST_C_EXT_ATTR1, CUST_C_EXT_ATTR2, CUST_C_EXT_ATTR3, CUST_C_EXT_ATTR4, CUST_C_EXT_ATTR5, CUST_C_EXT_ATTR6, CUST_C_EXT_ATTR7, CUST_C_EXT_ATTR8, CUST_C_EXT_ATTR9, CUST_C_EXT_ATTR10, CUST_C_EXT_ATTR11, CUST_C_EXT_ATTR12, CUST_C_EXT_ATTR13, CUST_C_EXT_ATTR14, CUST_C_EXT_ATTR15, CUST_C_EXT_ATTR16, CUST_C_EXT_ATTR17, CUST_C_EXT_ATTR18, CUST_C_EXT_ATTR19, CUST_C_EXT_ATTR20, CUST_C_EXT_ATTR21, CUST_C_EXT_ATTR22, CUST_C_EXT_ATTR23, CUST_C_EXT_ATTR24, CUST_C_EXT_ATTR25, CUST_C_EXT_ATTR26, CUST_C_EXT_ATTR27, CUST_C_EXT_ATTR28, CUST_C_EXT_ATTR29, CUST_C_EXT_ATTR30, CUST_C_EXT_ATTR31, CUST_C_EXT_ATTR32, CUST_C_EXT_ATTR33, CUST_C_EXT_ATTR34, CUST_C_EXT_ATTR35, CUST_C_EXT_ATTR36, CUST_C_EXT_ATTR37, CUST_C_EXT_ATTR38, CUST_C_EXT_ATTR39, CUST_C_EXT_ATTR40, CUST_C_EXT_ATTR41, CUST_C_EXT_ATTR42, CUST_C_EXT_ATTR43, CUST_C_EXT_ATTR44, CUST_C_EXT_ATTR45, CUST_C_EXT_ATTR46, CUST_C_EXT_ATTR47, CUST_C_EXT_ATTR48, CUST_C_EXT_ATTR49, CUST_C_EXT_ATTR50, CUST_C_EXT_ATTR51, CUST_C_EXT_ATTR52, CUST_C_EXT_ATTR53, CUST_C_EXT_ATTR54, CUST_C_EXT_ATTR55, CUST_C_EXT_ATTR56, CUST_C_EXT_ATTR57, CUST_C_EXT_ATTR58, CUST_C_EXT_ATTR59, CUST_C_EXT_ATTR60, CUST_C_EXT_ATTR61, CUST_C_EXT_ATTR62, CUST_C_EXT_ATTR63, CUST_C_EXT_ATTR64, CUST_C_EXT_ATTR65, CUST_C_EXT_ATTR66, CUST_C_EXT_ATTR67, CUST_C_EXT_ATTR68, CUST_C_EXT_ATTR69, CUST_C_EXT_ATTR70, CUST_C_EXT_ATTR71, CUST_C_EXT_ATTR72, CUST_C_EXT_ATTR73, CUST_C_EXT_ATTR74, CUST_C_EXT_ATTR75, CUST_N_EXT_ATTR1, CUST_N_EXT_ATTR2, CUST_N_EXT_ATTR3, CUST_N_EXT_ATTR4, CUST_N_EXT_ATTR5, CUST_N_EXT_ATTR6, CUST_N_EXT_ATTR7, CUST_N_EXT_ATTR8, CUST_N_EXT_ATTR9, CUST_N_EXT_ATTR10, CUST_N_EXT_ATTR11, CUST_N_EXT_ATTR12, CUST_N_EXT_ATTR13, CUST_N_EXT_ATTR14, CUST_N_EXT_ATTR15, CUST_N_EXT_ATTR16, CUST_N_EXT_ATTR17, CUST_N_EXT_ATTR18, CUST_N_EXT_ATTR19, CUST_N_EXT_ATTR20, CUST_D_EXT_ATTR1, CUST_D_EXT_ATTR2, CUST_D_EXT_ATTR3, CUST_D_EXT_ATTR4, CUST_D_EXT_ATTR5, CUST_C_EXT_LOV1, CUST_C_EXT_LOV2, CUST_C_EXT_LOV3, CUST_C_EXT_LOV4, CUST_C_EXT_LOV5, CUST_C_EXT_LOV6, CUST_C_EXT_LOV7, CUST_C_EXT_LOV8, CUST_C_EXT_LOV9, CUST_C_EXT_LOV10, CUST_D_EXT_ATTR6, CUST_D_EXT_ATTR7, CUST_D_EXT_ATTR8, CUST_D_EXT_ATTR9, CUST_D_EXT_ATTR10, ORG_ID, CLIENT_ID, BRAND_ID, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_LOGIN, OBJECT_VERSION_NUMBER, ADD_ATTRIBUTES, GROUP1_CODE, GROUP2_CODE, SOURCE)
  SEGMENT CREATION IMMEDIATE
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS NOLOGGING
  TABLESPACE TA_DATA
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
  ( TABLESPACE TA_DATA ENABLE STORAGE IN ROW CHUNK 8192
  CACHE  NOCOMPRESS  KEEP_DUPLICATES )
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB
  ( TABLESPACE TA_DATA ENABLE STORAGE IN ROW CHUNK 8192
  CACHE  NOCOMPRESS  KEEP_DUPLICATES )
 LOB (ADD_ATTRIBUTES) STORE AS BASICFILE (
  TABLESPACE TA_DATA ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  NOCACHE LOGGING )
  PARALLEL
  BUILD IMMEDIATE
  USING INDEX
  REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING TRUSTED CONSTRAINTS DISABLE ON QUERY COMPUTATION DISABLE QUERY REWRITE
  AS (
SELECT a.COMPETITOR_ID,
          a.HASH_ID,
          a.STORE_NUMBER,
          a.STORE_NAME,
          a.STORE_TYPE,
          a.CHAIN_ID,
          a.CHAIN_NAME,
          a.PARENT_CHAIN_ID,
          a.PARENT_CHAIN_NAME,
          a.LABEL,
          a.ADDRESS,
          a.ADDRESS2,
          a.CITY,
          a.STATE,
          a.ZIP,
          a.COUNTRY,
          a.PHONE,
          a.GEOMETRY,
          a.LATITUDE,
          a.LONGITUDE,
          a.GEO_ACCURACY,
          a.DISTRIBUTOR_NAME,
          a.STORE_HOURS,
          a.OTHER_FIELDS,
          a.SALES,
          a.FIRST_APPEARED,
          a.SIC,
          a.NAICS,
          a.CATEGORIES,
          a.COMP_SOURCE,
          a.STATUS,
          a.COMMENTS,
          a.CBSA_ID,
          a.CBSA_NAME,
          a.MSA_ID,
          a.MSA_NAME,
          a.DMA_ID,
          a.DMA_NAME,
          a.COUNTY,
          a.COUNTY_FIPS,
          a.COUNTRY_CODE,
          a.COUNTRY_NAME,
          a.STATE_CODE,
          a.STATE_NAME,
          a.LAST_VENDOR_UPDATE,
          a.C_EXT_ATTR1,
          a.C_EXT_ATTR2,
          a.C_EXT_ATTR3,
          a.C_EXT_ATTR4,
          a.C_EXT_ATTR5,
          a.C_EXT_ATTR6,
          a.C_EXT_ATTR7,
          a.C_EXT_ATTR8,
          a.C_EXT_ATTR9,
          a.C_EXT_ATTR10,
          a.C_EXT_ATTR11,
          a.C_EXT_ATTR12,
          a.C_EXT_ATTR13,
          a.C_EXT_ATTR14,
          a.C_EXT_ATTR15,
          a.C_EXT_ATTR16,
          a.C_EXT_ATTR17,
          a.C_EXT_ATTR18,
          a.C_EXT_ATTR19,
          a.C_EXT_ATTR20,
          a.C_EXT_ATTR21,
          a.C_EXT_ATTR22,
          a.C_EXT_ATTR23,
          a.C_EXT_ATTR24,
          a.C_EXT_ATTR25,
          a.C_EXT_ATTR26,
          a.C_EXT_ATTR27,
          a.C_EXT_ATTR28,
          a.C_EXT_ATTR29,
          a.C_EXT_ATTR30,
          a.C_EXT_ATTR31,
          a.C_EXT_ATTR32,
          a.C_EXT_ATTR33,
          a.C_EXT_ATTR34,
          a.C_EXT_ATTR35,
          a.C_EXT_ATTR36,
          a.C_EXT_ATTR37,
          a.C_EXT_ATTR38,
          a.C_EXT_ATTR39,
          a.C_EXT_ATTR40,
          a.C_EXT_ATTR41,
          a.C_EXT_ATTR42,
          a.C_EXT_ATTR43,
          a.C_EXT_ATTR44,
          a.C_EXT_ATTR45,
          a.C_EXT_ATTR46,
          a.C_EXT_ATTR47,
          a.C_EXT_ATTR48,
          a.C_EXT_ATTR49,
          a.C_EXT_ATTR50,
          a.C_EXT_ATTR51,
          a.C_EXT_ATTR52,
          a.C_EXT_ATTR53,
          a.C_EXT_ATTR54,
          a.C_EXT_ATTR55,
          a.C_EXT_ATTR56,
          a.C_EXT_ATTR57,
          a.C_EXT_ATTR58,
          a.C_EXT_ATTR59,
          a.C_EXT_ATTR60,
          a.C_EXT_ATTR61,
          a.C_EXT_ATTR62,
          a.C_EXT_ATTR63,
          a.C_EXT_ATTR64,
          a.C_EXT_ATTR65,
          a.C_EXT_ATTR66,
          a.C_EXT_ATTR67,
          a.C_EXT_ATTR68,
          a.C_EXT_ATTR69,
          a.C_EXT_ATTR70,
          a.C_EXT_ATTR71,
          a.C_EXT_ATTR72,
          a.C_EXT_ATTR73,
          a.C_EXT_ATTR74,
          a.C_EXT_ATTR75,
          a.N_EXT_ATTR1,
          a.N_EXT_ATTR2,
          a.N_EXT_ATTR3,
          a.N_EXT_ATTR4,
          a.N_EXT_ATTR5,
          a.N_EXT_ATTR6,
          a.N_EXT_ATTR7,
          a.N_EXT_ATTR8,
          a.N_EXT_ATTR9,
          a.N_EXT_ATTR10,
          a.N_EXT_ATTR11,
          a.N_EXT_ATTR12,
          a.N_EXT_ATTR13,
          a.N_EXT_ATTR14,
          a.N_EXT_ATTR15,
          a.N_EXT_ATTR16,
          a.N_EXT_ATTR17,
          a.N_EXT_ATTR18,
          a.N_EXT_ATTR19,
          a.N_EXT_ATTR20,
          a.D_EXT_ATTR1,
          a.D_EXT_ATTR2,
          a.D_EXT_ATTR3,
          a.D_EXT_ATTR4,
          a.D_EXT_ATTR5,
          a.D_EXT_ATTR6,
          a.D_EXT_ATTR7,
          a.D_EXT_ATTR8,
          a.D_EXT_ATTR9,
          a.D_EXT_ATTR10,
          a.MI_PRINX,
          a.C_EXT_LOV1,
          a.C_EXT_LOV2,
          a.C_EXT_LOV3,
          a.C_EXT_LOV4,
          a.C_EXT_LOV5,
          a.C_EXT_LOV6,
          a.C_EXT_LOV7,
          a.C_EXT_LOV8,
          a.C_EXT_LOV9,
          a.C_EXT_LOV10,
          a.CUST_SALES,
          a.CUST_LATITUDE,
          a.CUST_LONGITUDE,
          a.CUST_C_EXT_ATTR1,
          a.CUST_C_EXT_ATTR2,
          a.CUST_C_EXT_ATTR3,
          a.CUST_C_EXT_ATTR4,
          a.CUST_C_EXT_ATTR5,
          a.CUST_C_EXT_ATTR6,
          a.CUST_C_EXT_ATTR7,
          a.CUST_C_EXT_ATTR8,
          a.CUST_C_EXT_ATTR9,
          a.CUST_C_EXT_ATTR10,
          a.CUST_C_EXT_ATTR11,
          a.CUST_C_EXT_ATTR12,
          a.CUST_C_EXT_ATTR13,
          a.CUST_C_EXT_ATTR14,
          a.CUST_C_EXT_ATTR15,
          a.CUST_C_EXT_ATTR16,
          a.CUST_C_EXT_ATTR17,
          a.CUST_C_EXT_ATTR18,
          a.CUST_C_EXT_ATTR19,
          a.CUST_C_EXT_ATTR20,
          a.CUST_C_EXT_ATTR21,
          a.CUST_C_EXT_ATTR22,
          a.CUST_C_EXT_ATTR23,
          a.CUST_C_EXT_ATTR24,
          a.CUST_C_EXT_ATTR25,
          a.CUST_C_EXT_ATTR26,
          a.CUST_C_EXT_ATTR27,
          a.CUST_C_EXT_ATTR28,
          a.CUST_C_EXT_ATTR29,
          a.CUST_C_EXT_ATTR30,
          a.CUST_C_EXT_ATTR31,
          a.CUST_C_EXT_ATTR32,
          a.CUST_C_EXT_ATTR33,
          a.CUST_C_EXT_ATTR34,
          a.CUST_C_EXT_ATTR35,
          a.CUST_C_EXT_ATTR36,
          a.CUST_C_EXT_ATTR37,
          a.CUST_C_EXT_ATTR38,
          a.CUST_C_EXT_ATTR39,
          a.CUST_C_EXT_ATTR40,
          a.CUST_C_EXT_ATTR41,
          a.CUST_C_EXT_ATTR42,
          a.CUST_C_EXT_ATTR43,
          a.CUST_C_EXT_ATTR44,
          a.CUST_C_EXT_ATTR45,
          a.CUST_C_EXT_ATTR46,
          a.CUST_C_EXT_ATTR47,
          a.CUST_C_EXT_ATTR48,
          a.CUST_C_EXT_ATTR49,
          a.CUST_C_EXT_ATTR50,
          a.CUST_C_EXT_ATTR51,
          a.CUST_C_EXT_ATTR52,
          a.CUST_C_EXT_ATTR53,
          a.CUST_C_EXT_ATTR54,
          a.CUST_C_EXT_ATTR55,
          a.CUST_C_EXT_ATTR56,
          a.CUST_C_EXT_ATTR57,
          a.CUST_C_EXT_ATTR58,
          a.CUST_C_EXT_ATTR59,
          a.CUST_C_EXT_ATTR60,
          a.CUST_C_EXT_ATTR61,
          a.CUST_C_EXT_ATTR62,
          a.CUST_C_EXT_ATTR63,
          a.CUST_C_EXT_ATTR64,
          a.CUST_C_EXT_ATTR65,
          a.CUST_C_EXT_ATTR66,
          a.CUST_C_EXT_ATTR67,
          a.CUST_C_EXT_ATTR68,
          a.CUST_C_EXT_ATTR69,
          a.CUST_C_EXT_ATTR70,
          a.CUST_C_EXT_ATTR71,
          a.CUST_C_EXT_ATTR72,
          a.CUST_C_EXT_ATTR73,
          a.CUST_C_EXT_ATTR74,
          a.CUST_C_EXT_ATTR75,
          a.CUST_N_EXT_ATTR1,
          a.CUST_N_EXT_ATTR2,
          a.CUST_N_EXT_ATTR3,
          a.CUST_N_EXT_ATTR4,
          a.CUST_N_EXT_ATTR5,
          a.CUST_N_EXT_ATTR6,
          a.CUST_N_EXT_ATTR7,
          a.CUST_N_EXT_ATTR8,
          a.CUST_N_EXT_ATTR9,
          a.CUST_N_EXT_ATTR10,
          a.CUST_N_EXT_ATTR11,
          a.CUST_N_EXT_ATTR12,
          a.CUST_N_EXT_ATTR13,
          a.CUST_N_EXT_ATTR14,
          a.CUST_N_EXT_ATTR15,
          a.CUST_N_EXT_ATTR16,
          a.CUST_N_EXT_ATTR17,
          a.CUST_N_EXT_ATTR18,
          a.CUST_N_EXT_ATTR19,
          a.CUST_N_EXT_ATTR20,
          a.CUST_D_EXT_ATTR1,
          a.CUST_D_EXT_ATTR2,
          a.CUST_D_EXT_ATTR3,
          a.CUST_D_EXT_ATTR4,
          a.CUST_D_EXT_ATTR5,
          a.CUST_C_EXT_LOV1,
          a.CUST_C_EXT_LOV2,
          a.CUST_C_EXT_LOV3,
          a.CUST_C_EXT_LOV4,
          a.CUST_C_EXT_LOV5,
          a.CUST_C_EXT_LOV6,
          a.CUST_C_EXT_LOV7,
          a.CUST_C_EXT_LOV8,
          a.CUST_C_EXT_LOV9,
          a.CUST_C_EXT_LOV10,
          a.CUST_D_EXT_ATTR6,
          a.CUST_D_EXT_ATTR7,
          a.CUST_D_EXT_ATTR8,
          a.CUST_D_EXT_ATTR9,
          a.CUST_D_EXT_ATTR10,
          a.ORG_ID,
          b.CLIENT_ID,
          b.BRAND_ID,
          a.CREATION_DATE,
          a.CREATED_BY,
          a.LAST_UPDATE_DATE,
          a.LAST_UPDATED_BY,
          a.LAST_UPDATE_LOGIN,
          a.OBJECT_VERSION_NUMBER,
          a.ADD_ATTRIBUTES,
          b.GROUP1_CODE,
          b.GROUP2_CODE,
          A.SOURCE
    FROM TMCS_ALL_COMPETITORS_STD a, TMCS_ALL_COMPETITORS_CONFIG b
    WHERE     a.CHAIN_ID = b.CHAIN_ID
          AND a.COUNTRY = b.COUNTRY
          AND b.IS_ENABLE = 'Y'
          AND COMPETITOR_ID NOT IN (SELECT COMPETITOR_ID FROM TMCS_ALL_COMPETITORS_CUST C WHERE C.COMPETITOR_ID = a.COMPETITOR_ID and c.CLIENT_ID = b.CLIENT_ID)
);

