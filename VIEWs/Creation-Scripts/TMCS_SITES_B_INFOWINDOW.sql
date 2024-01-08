CREATE OR REPLACE FORCE EDITIONABLE VIEW TMCS_SITES_B_INFOWINDOW (SITE_ID, SITE_NAME, C_EXT_ATTR35, C_EXT_ATTR05, BRAND, ADDRESS, CITY, STATE, ZIP_CODE, SITE_TYPE, DRIVE_THRU, LATITUDE, LONGITUDE, N_EXT_ATTR02, DMA, REAL_ESTATE_MANAGER, CONSTRUCTION_MANAGER, C_EXT_ATTR12, C_EXT_ATTR13, C_EXT_ATTR15, SITE_STATUS, D_EXT_ATTR14, FISCAL_YEAR, FISCAL_QUARTER, D_EXT_ATTR01, DESCRIPTION, N_EXT_ATTR1, N_EXT_ATTR2, N_EXT_ATTR3, N_EXT_ATTR16, N_EXT_ATTR17, N_EXT_ATTR18, GEOMETRY) AS
  SELECT a.site_id,
          a.site_name,
          a.C_Ext_Attr35,
          a.C_EXT_ATTR05,
          (SELECT brand_name
             FROM tmcs_client_brands
            WHERE client_id = 1 AND client_brand_id = a.Brand_ID)
             brand_name,
          a.ADDRESS,
          a.CITY,
          a.STATE,
          a.ZIP_CODE,
          (SELECT name
             FROM tmcs.tmcs_lookup_values
            WHERE lookup_id = 1027 AND lookup_code = a.site_type)
             site_type,
          (SELECT name
             FROM tmcs.tmcs_lookup_values
            WHERE lookup_id = 1045 AND lookup_code = a.C_EXT_ATTR27)
             drive_thru,
          ROUND (a.latitude, 6) latitude,
          ROUND (a.LONGITUDE, 6) longitude,
          a.N_EXT_ATTR02,
          a.DMA,
          a.REAL_ESTATE_MANAGER,
          a.CONSTRUCTION_MANAGER,
          a.C_EXT_ATTR12,
          a.C_EXT_ATTR13,
          a.C_EXT_ATTR15,
          (SELECT name
             FROM tmcs.tmcs_lookup_values
            WHERE lookup_id = 1244 AND lookup_code = a.C_EXT_ATTR19)
             site_status,
          a.D_EXT_ATTR14,
          ROUND (a.N_EXT_ATTR17, 0) N_EXT_ATTR17,
          ROUND (a.N_EXT_ATTR18, 0) N_EXT_ATTR18,
          a.D_EXT_ATTR01,
          b.Description,
          ROUND (b.N_EXT_ATTR1, 0) N_EXT_ATTR1,
          ROUND (b.N_EXT_ATTR2, 0) N_EXT_ATTR2,
          ROUND (b.N_EXT_ATTR3, 0) N_EXT_ATTR3,
          ROUND (b.N_EXT_ATTR16, 0) N_EXT_ATTR16,
          ROUND (b.N_EXT_ATTR17, 0) N_EXT_ATTR17,
          ROUND (b.N_EXT_ATTR18, 0) N_EXT_ATTR18,
          b.geometry
     FROM tmcs.tmcs_sites_B a,
          tmcs.TMCS_TARGETS_B c,
          tmcs.tmcs_tradeareas_sites b
    WHERE a.client_ID = 1 and a.site_id = b.site_id AND c.target_id = a.target_id
          AND (b.current_status = 'TRUE'
               OR (a.STATUS = 'IN' AND b.current_status = 'FALSE'
                   AND b.LAST_UPDATE_DATE =
                          (SELECT MAX (d.LAST_UPDATE_DATE)
                             FROM TMCS_TRADEAREAS_SITES d
                            WHERE d.SITE_ID = b.SITE_ID
                                  AND CURRENT_STATUS = 'FALSE')));

