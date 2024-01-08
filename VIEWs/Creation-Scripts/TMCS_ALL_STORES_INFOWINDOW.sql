CREATE OR REPLACE FORCE EDITIONABLE VIEW TMCS_ALL_STORES_INFOWINDOW (STORE_ID, STORE_NUMBER, STORE_NAME, ADDRESS, CITY, STATE, COUNTY, NEIGHBORHOOD, COUNTRY, ZIP, FULL_ADDRESS, LONGITUDE, LATITUDE, STATUS, MARKET_NAME, GEOMETRY, CY_ANNUAL_SALES, SIS_TYPE_CODE, LOCATION_TYPE_CODE, STORE_SIZE, TOTAL_ANNUAL_RENT, BASE_RENT_PER_SIZE, OPEN_DATE, CLOSE_DATE, LEASE_EXP_DATE, LEASE_OPTION, CY_TRL_12_MO_SALES, PY_TRL_12_MO_SALES, PCT_DIFF_SALES, CY_EBITDA, PY_EBITDA, PCT_DIFF_EBITDA, PERIOD_ENDING, C_EXT_ATTR1, C_EXT_ATTR2, C_EXT_ATTR3, C_EXT_ATTR4, C_EXT_ATTR5, C_EXT_ATTR6, C_EXT_ATTR7, C_EXT_ATTR8, C_EXT_ATTR9, C_EXT_ATTR10, C_EXT_ATTR11, C_EXT_ATTR12, C_EXT_ATTR13, C_EXT_ATTR14, C_EXT_ATTR15, N_EXT_ATTR1, N_EXT_ATTR2, N_EXT_ATTR3, N_EXT_ATTR4, N_EXT_ATTR5, N_EXT_ATTR6, N_EXT_ATTR7, N_EXT_ATTR8, N_EXT_ATTR9, N_EXT_ATTR10, N_EXT_ATTR11, N_EXT_ATTR12, N_EXT_ATTR13, N_EXT_ATTR14, N_EXT_ATTR15, D_EXT_ATTR1, D_EXT_ATTR2, D_EXT_ATTR3, D_EXT_ATTR4, D_EXT_ATTR5, D_EXT_ATTR6, D_EXT_ATTR7, D_EXT_ATTR8, D_EXT_ATTR9, D_EXT_ATTR10, D_EXT_ATTR11, D_EXT_ATTR12, D_EXT_ATTR13, D_EXT_ATTR14, D_EXT_ATTR15, CBSA_CLASS, STORE_CLASS, ORG_ID, CLIENT_ID, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_LOGIN, OBJECT_VERSION_NUMBER, C_EXT_ATTR16, C_EXT_ATTR17, C_EXT_ATTR18, C_EXT_ATTR19, C_EXT_ATTR20, C_EXT_ATTR21, C_EXT_ATTR22, C_EXT_ATTR23, C_EXT_ATTR24, C_EXT_ATTR25, C_EXT_ATTR26, C_EXT_ATTR27, C_EXT_ATTR28, C_EXT_ATTR29, C_EXT_ATTR30, N_EXT_ATTR16, BRAND_ID, N_EXT_ATTR17, N_EXT_ATTR18, N_EXT_ATTR19, N_EXT_ATTR20, N_EXT_ATTR21, N_EXT_ATTR22, N_EXT_ATTR23, N_EXT_ATTR24, N_EXT_ATTR25, C_EXT_ATTR31, C_EXT_ATTR32, C_EXT_ATTR33, C_EXT_ATTR34, C_EXT_ATTR35, C_EXT_ATTR36, C_EXT_ATTR37, C_EXT_ATTR38, C_EXT_ATTR39, C_EXT_ATTR40, C_EXT_ATTR41, C_EXT_ATTR42, C_EXT_ATTR43, C_EXT_ATTR44, ADDRESS2, OUTBOUND_INTEG_FLAG, N_EXT_ATTR26, N_EXT_ATTR27, N_EXT_ATTR28, N_EXT_ATTR29, N_EXT_ATTR30, C_EXT_ATTR45, MI_PRINX, SITE_ID, DEMO_SCORE, SITE_SCORE, C_EXT_ATTR46, C_EXT_ATTR47, DESCRIPTION, TA_N_EXT_ATTR1, TA_N_EXT_ATTR2, TA_N_EXT_ATTR3, TA_N_EXT_ATTR4, TA_N_EXT_ATTR5, TA_N_EXT_ATTR6, TA_N_EXT_ATTR7, TA_N_EXT_ATTR8, TA_N_EXT_ATTR9, TA_N_EXT_ATTR10, TA_N_EXT_ATTR11, TA_N_EXT_ATTR12, TA_N_EXT_ATTR13, TA_N_EXT_ATTR14, TA_N_EXT_ATTR15, TA_N_EXT_ATTR16, TA_N_EXT_ATTR17, TA_N_EXT_ATTR18, TA_N_EXT_ATTR19, TA_N_EXT_ATTR20) AS
  SELECT A.STORE_ID,
          A.STORE_NUMBER,
          A.STORE_NAME,
          A.ADDRESS,
          A.CITY,
          A.STATE,
          A.COUNTY,
          A.NEIGHBORHOOD,
          A.COUNTRY,
          A.ZIP,
          A.FULL_ADDRESS,
          A.LONGITUDE,
          A.LATITUDE,
          A.STATUS,
          A.MARKET_NAME,
          A.GEOMETRY,
          A.CY_ANNUAL_SALES,
          A.SIS_TYPE_CODE,
          A.LOCATION_TYPE_CODE,
          A.STORE_SIZE,
          A.TOTAL_ANNUAL_RENT,
          A.BASE_RENT_PER_SIZE,
          A.OPEN_DATE,
          A.CLOSE_DATE,
          A.LEASE_EXP_DATE,
          A.LEASE_OPTION,
          A.CY_TRL_12_MO_SALES,
          A.PY_TRL_12_MO_SALES,
          A.PCT_DIFF_SALES,
          A.CY_EBITDA,
          A.PY_EBITDA,
          A.PCT_DIFF_EBITDA,
          A.PERIOD_ENDING,
          A.C_EXT_ATTR1,
          A.C_EXT_ATTR2,
          A.C_EXT_ATTR3,
          A.C_EXT_ATTR4,
          A.C_EXT_ATTR5,
          A.C_EXT_ATTR6,
          A.C_EXT_ATTR7,
          A.C_EXT_ATTR8,
          A.C_EXT_ATTR9,
          A.C_EXT_ATTR10,
          A.C_EXT_ATTR11,
          A.C_EXT_ATTR12,
          A.C_EXT_ATTR13,
          A.C_EXT_ATTR14,
          A.C_EXT_ATTR15,
          A.N_EXT_ATTR1,
          A.N_EXT_ATTR2,
          A.N_EXT_ATTR3,
          A.N_EXT_ATTR4,
          A.N_EXT_ATTR5,
          A.N_EXT_ATTR6,
          A.N_EXT_ATTR7,
          A.N_EXT_ATTR8,
          A.N_EXT_ATTR9,
          A.N_EXT_ATTR10,
          A.N_EXT_ATTR11,
          A.N_EXT_ATTR12,
          A.N_EXT_ATTR13,
          A.N_EXT_ATTR14,
          A.N_EXT_ATTR15,
          A.D_EXT_ATTR1,
          A.D_EXT_ATTR2,
          A.D_EXT_ATTR3,
          A.D_EXT_ATTR4,
          A.D_EXT_ATTR5,
          A.D_EXT_ATTR6,
          A.D_EXT_ATTR7,
          A.D_EXT_ATTR8,
          A.D_EXT_ATTR9,
          A.D_EXT_ATTR10,
          A.D_EXT_ATTR11,
          A.D_EXT_ATTR12,
          A.D_EXT_ATTR13,
          A.D_EXT_ATTR14,
          A.D_EXT_ATTR15,
          A.CBSA_CLASS,
          A.STORE_CLASS,
          A.ORG_ID,
          A.CLIENT_ID,
          A.CREATION_DATE,
          A.CREATED_BY,
          A.LAST_UPDATE_DATE,
          A.LAST_UPDATED_BY,
          A.LAST_UPDATE_LOGIN,
          A.OBJECT_VERSION_NUMBER,
          A.C_EXT_ATTR16,
          A.C_EXT_ATTR17,
          A.C_EXT_ATTR18,
          A.C_EXT_ATTR19,
          A.C_EXT_ATTR20,
          A.C_EXT_ATTR21,
          A.C_EXT_ATTR22,
          A.C_EXT_ATTR23,
          A.C_EXT_ATTR24,
          A.C_EXT_ATTR25,
          A.C_EXT_ATTR26,
          A.C_EXT_ATTR27,
          A.C_EXT_ATTR28,
          A.C_EXT_ATTR29,
          A.C_EXT_ATTR30,
          A.N_EXT_ATTR16,
          A.BRAND_ID,
          A.N_EXT_ATTR17,
          A.N_EXT_ATTR18,
          A.N_EXT_ATTR19,
          A.N_EXT_ATTR20,
          A.N_EXT_ATTR21,
          A.N_EXT_ATTR22,
          A.N_EXT_ATTR23,
          A.N_EXT_ATTR24,
          A.N_EXT_ATTR25,
          A.C_EXT_ATTR31,
          A.C_EXT_ATTR32,
          A.C_EXT_ATTR33,
          A.C_EXT_ATTR34,
          A.C_EXT_ATTR35,
          A.C_EXT_ATTR36,
          A.C_EXT_ATTR37,
          A.C_EXT_ATTR38,
          A.C_EXT_ATTR39,
          A.C_EXT_ATTR40,
          A.C_EXT_ATTR41,
          A.C_EXT_ATTR42,
          A.C_EXT_ATTR43,
          A.C_EXT_ATTR44,
          A.ADDRESS2,
          A.OUTBOUND_INTEG_FLAG,
          A.N_EXT_ATTR26,
          A.N_EXT_ATTR27,
          A.N_EXT_ATTR28,
          A.N_EXT_ATTR29,
          A.N_EXT_ATTR30,
          A.C_EXT_ATTR45,
          A.MI_PRINX,
          A.SITE_ID,
          A.DEMO_SCORE,
          A.SITE_SCORE,
          A.C_EXT_ATTR46,
          A.C_EXT_ATTR47,
          B.DESCRIPTION AS DESCRIPTION,
          B.N_EXT_ATTR1 AS TA_N_EXT_ATTR1,
          B.N_EXT_ATTR2 AS TA_N_EXT_ATTR2,
          B.N_EXT_ATTR3 AS TA_N_EXT_ATTR3,
          B.N_EXT_ATTR4 AS TA_N_EXT_ATTR4,
          B.N_EXT_ATTR5 AS TA_N_EXT_ATTR5,
          B.N_EXT_ATTR6 AS TA_N_EXT_ATTR6,
          B.N_EXT_ATTR7 AS TA_N_EXT_ATTR7,
          B.N_EXT_ATTR8 AS TA_N_EXT_ATTR8,
          B.N_EXT_ATTR9 AS TA_N_EXT_ATTR9,
          B.N_EXT_ATTR10 AS TA_N_EXT_ATTR10,
          B.N_EXT_ATTR11 AS TA_N_EXT_ATTR11,
          B.N_EXT_ATTR12 AS TA_N_EXT_ATTR12,
          B.N_EXT_ATTR13 AS TA_N_EXT_ATTR13,
          B.N_EXT_ATTR14 AS TA_N_EXT_ATTR14,
          B.N_EXT_ATTR15 AS TA_N_EXT_ATTR15,
          B.N_EXT_ATTR16 AS TA_N_EXT_ATTR16,
          B.N_EXT_ATTR17 AS TA_N_EXT_ATTR17,
          B.N_EXT_ATTR18 AS TA_N_EXT_ATTR18,
          B.N_EXT_ATTR19 AS TA_N_EXT_ATTR19,
          B.N_EXT_ATTR20 AS TA_N_EXT_ATTR20
     FROM TMCS_ALL_STORES_TA B, TMCS_ALL_STORES A
    WHERE A.STORE_ID = B.STORE_ID
    and A.client_id =1;
