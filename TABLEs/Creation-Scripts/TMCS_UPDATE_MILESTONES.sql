CREATE TABLE TMCS_UPDATE_MILESTONES
   (	MILESTONE_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	MILESTONE_DATE_TYPE VARCHAR2(100),
	MILESTONE1 DATE,
	MILESTONE2 DATE,
	MILESTONE3 DATE,
	MILESTONE4 DATE,
	MILESTONE5 DATE,
	MILESTONE6 DATE,
	MILESTONE7 DATE,
	MILESTONE8 DATE,
	MILESTONE9 DATE,
	MILESTONE10 DATE,
	MILESTONE11 DATE,
	MILESTONE12 DATE,
	MILESTONE13 DATE,
	MILESTONE14 DATE,
	MILESTONE15 DATE,
	MILESTONE16 DATE,
	MILESTONE17 DATE,
	MILESTONE18 DATE,
	MILESTONE19 DATE,
	MILESTONE20 DATE,
	MILESTONE21 DATE,
	MILESTONE22 DATE,
	MILESTONE23 DATE,
	MILESTONE24 DATE,
	MILESTONE25 DATE,
	MILESTONE26 DATE,
	MILESTONE27 DATE,
	MILESTONE28 DATE,
	MILESTONE29 DATE,
	MILESTONE30 DATE,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	MILESTONE1_CHK VARCHAR2(20),
	MILESTONE2_CHK VARCHAR2(20),
	MILESTONE3_CHK VARCHAR2(20),
	MILESTONE4_CHK VARCHAR2(20),
	MILESTONE5_CHK VARCHAR2(20),
	MILESTONE6_CHK VARCHAR2(20),
	MILESTONE7_CHK VARCHAR2(20),
	MILESTONE8_CHK VARCHAR2(20),
	MILESTONE9_CHK VARCHAR2(20),
	MILESTONE10_CHK VARCHAR2(20),
	MILESTONE11_CHK VARCHAR2(20),
	MILESTONE12_CHK VARCHAR2(20),
	MILESTONE13_CHK VARCHAR2(20),
	MILESTONE14_CHK VARCHAR2(20),
	MILESTONE15_CHK VARCHAR2(20),
	MILESTONE16_CHK VARCHAR2(20),
	MILESTONE17_CHK VARCHAR2(20),
	MILESTONE18_CHK VARCHAR2(20),
	MILESTONE19_CHK VARCHAR2(20),
	MILESTONE20_CHK VARCHAR2(20),
	MILESTONE21_CHK VARCHAR2(20),
	MILESTONE22_CHK VARCHAR2(20),
	MILESTONE24_CHK VARCHAR2(20),
	MILESTONE25_CHK VARCHAR2(20),
	MILESTONE26_CHK VARCHAR2(20),
	MILESTONE27_CHK VARCHAR2(20),
	MILESTONE28_CHK VARCHAR2(20),
	MILESTONE29_CHK VARCHAR2(20),
	MILESTONE30_CHK VARCHAR2(20),
	MILESTONE23_CHK VARCHAR2(20),
	TEMPLATE_ID NUMBER,
	MILESTONE1_CLR VARCHAR2(20),
	MILESTONE2_CLR VARCHAR2(20),
	MILESTONE3_CLR VARCHAR2(20),
	MILESTONE4_CLR VARCHAR2(20),
	MILESTONE5_CLR VARCHAR2(20),
	MILESTONE6_CLR VARCHAR2(20),
	MILESTONE7_CLR VARCHAR2(20),
	MILESTONE8_CLR VARCHAR2(20),
	MILESTONE9_CLR VARCHAR2(20),
	MILESTONE10_CLR VARCHAR2(20),
	MILESTONE11_CLR VARCHAR2(20),
	MILESTONE12_CLR VARCHAR2(20),
	MILESTONE13_CLR VARCHAR2(20),
	MILESTONE14_CLR VARCHAR2(20),
	MILESTONE15_CLR VARCHAR2(20),
	MILESTONE16_CLR VARCHAR2(20),
	MILESTONE17_CLR VARCHAR2(20),
	MILESTONE18_CLR VARCHAR2(20),
	MILESTONE19_CLR VARCHAR2(20),
	MILESTONE20_CLR VARCHAR2(20),
	MILESTONE21_CLR VARCHAR2(20),
	MILESTONE22_CLR VARCHAR2(20),
	MILESTONE24_CLR VARCHAR2(20),
	MILESTONE25_CLR VARCHAR2(20),
	MILESTONE26_CLR VARCHAR2(20),
	MILESTONE27_CLR VARCHAR2(20),
	MILESTONE28_CLR VARCHAR2(20),
	MILESTONE29_CLR VARCHAR2(20),
	MILESTONE30_CLR VARCHAR2(20),
	MILESTONE23_CLR VARCHAR2(20),
	ENTITY_NUMBER VARCHAR2(100),
	ENTITY_NAME VARCHAR2(100),
	ADDRESS VARCHAR2(500),
	CITY VARCHAR2(100),
	STATE VARCHAR2(100),
	ZIP_CODE VARCHAR2(100),
	DMA VARCHAR2(100),
	DM VARCHAR2(100),
	CM VARCHAR2(100),
	REDCAT_TARGET_NUMBER VARCHAR2(50),
	BK_NUMBER VARCHAR2(50),
	TARGET_DESCRIPTION VARCHAR2(500),
	OPERATOR_NAME VARCHAR2(100),
	DM_ESTIMATED_OPEN_DATE DATE,
	COUNTRY VARCHAR2(100),
	RECORD_TYPE VARCHAR2(100),
	MILESTONE31 DATE,
	MILESTONE31_CHK VARCHAR2(20),
	MILESTONE31_CLR VARCHAR2(20),
	MILESTONE32 DATE,
	MILESTONE32_CHK VARCHAR2(20),
	MILESTONE32_CLR VARCHAR2(20),
	MILESTONE33 DATE,
	MILESTONE33_CHK VARCHAR2(20),
	MILESTONE33_CLR VARCHAR2(20),
	MILESTONE34 DATE,
	MILESTONE34_CHK VARCHAR2(20),
	MILESTONE34_CLR VARCHAR2(20),
	MILESTONE35 DATE,
	MILESTONE35_CHK VARCHAR2(20),
	MILESTONE35_CLR VARCHAR2(20),
	MILESTONE36 DATE,
	MILESTONE36_CHK VARCHAR2(20),
	MILESTONE36_CLR VARCHAR2(20),
	MILESTONE37 DATE,
	MILESTONE37_CHK VARCHAR2(20),
	MILESTONE37_CLR VARCHAR2(20),
	MILESTONE38 DATE,
	MILESTONE38_CHK VARCHAR2(20),
	MILESTONE38_CLR VARCHAR2(20),
	MILESTONE39 DATE,
	MILESTONE39_CHK VARCHAR2(20),
	MILESTONE39_CLR VARCHAR2(20),
	MILESTONE40 DATE,
	MILESTONE40_CHK VARCHAR2(20),
	MILESTONE40_CLR VARCHAR2(20),
	MILESTONE41 DATE,
	MILESTONE41_CHK VARCHAR2(20),
	MILESTONE41_CLR VARCHAR2(20),
	MILESTONE42 DATE,
	MILESTONE42_CHK VARCHAR2(20),
	MILESTONE42_CLR VARCHAR2(20),
	MILESTONE43 DATE,
	MILESTONE43_CHK VARCHAR2(20),
	MILESTONE43_CLR VARCHAR2(20),
	MILESTONE44 DATE,
	MILESTONE44_CHK VARCHAR2(20),
	MILESTONE44_CLR VARCHAR2(20),
	MILESTONE45 DATE,
	MILESTONE45_CHK VARCHAR2(20),
	MILESTONE45_CLR VARCHAR2(20),
	MILESTONE46 DATE,
	MILESTONE46_CLR VARCHAR2(20),
	MILESTONE46_CHK VARCHAR2(20),
	MILESTONE47 DATE,
	MILESTONE47_CLR VARCHAR2(20),
	MILESTONE47_CHK VARCHAR2(20),
	MILESTONE48 DATE,
	MILESTONE48_CHK VARCHAR2(20),
	MILESTONE48_CLR VARCHAR2(20),
	MILESTONE49 DATE,
	MILESTONE49_CHK VARCHAR2(20),
	MILESTONE49_CLR VARCHAR2(20),
	MILESTONE50 DATE,
	MILESTONE50_CHK VARCHAR2(20),
	MILESTONE50_CLR VARCHAR2(20),
	MILESTONE51 DATE,
	MILESTONE51_CHK VARCHAR2(20),
	MILESTONE51_CLR VARCHAR2(20),
	MILESTONE52 DATE,
	MILESTONE52_CHK VARCHAR2(20),
	MILESTONE52_CLR VARCHAR2(20),
	MILESTONE53 DATE,
	MILESTONE53_CHK VARCHAR2(20),
	MILESTONE53_CLR VARCHAR2(20),
	MILESTONE54 DATE,
	MILESTONE54_CHK VARCHAR2(20),
	MILESTONE54_CLR VARCHAR2(20),
	MILESTONE55 DATE,
	MILESTONE55_CHK VARCHAR2(20),
	MILESTONE55_CLR VARCHAR2(20),
	MILESTONE56 DATE,
	MILESTONE56_CHK VARCHAR2(20),
	MILESTONE56_CLR VARCHAR2(20),
	MILESTONE57 DATE,
	MILESTONE57_CHK VARCHAR2(20),
	MILESTONE57_CLR VARCHAR2(20),
	MILESTONE58 DATE,
	MILESTONE58_CHK VARCHAR2(20),
	MILESTONE58_CLR VARCHAR2(20),
	MILESTONE59 DATE,
	MILESTONE59_CHK VARCHAR2(20),
	MILESTONE59_CLR VARCHAR2(20),
	MILESTONE60 DATE,
	MILESTONE60_CHK VARCHAR2(20),
	MILESTONE60_CLR VARCHAR2(20),
	MILESTONE61 DATE,
	MILESTONE61_CHK VARCHAR2(20),
	MILESTONE61_CLR VARCHAR2(20),
	MILESTONE62 DATE,
	MILESTONE62_CHK VARCHAR2(20),
	MILESTONE62_CLR VARCHAR2(20),
	MILESTONE63 DATE,
	MILESTONE63_CHK VARCHAR2(20),
	MILESTONE63_CLR VARCHAR2(20),
	MILESTONE64 DATE,
	MILESTONE64_CHK VARCHAR2(20),
	MILESTONE64_CLR VARCHAR2(20),
	MILESTONE65 DATE,
	MILESTONE65_CHK VARCHAR2(20),
	MILESTONE65_CLR VARCHAR2(20),
	MILESTONE66 DATE,
	MILESTONE66_CLR VARCHAR2(20),
	MILESTONE66_CHK VARCHAR2(20),
	MILESTONE67 DATE,
	MILESTONE67_CLR VARCHAR2(20),
	MILESTONE67_CHK VARCHAR2(20),
	MILESTONE68 DATE,
	MILESTONE68_CHK VARCHAR2(20),
	MILESTONE68_CLR VARCHAR2(20),
	MILESTONE69 DATE,
	MILESTONE69_CHK VARCHAR2(20),
	MILESTONE69_CLR VARCHAR2(20),
	MILESTONE70 DATE,
	MILESTONE70_CHK VARCHAR2(20),
	MILESTONE70_CLR VARCHAR2(20),
	MILESTONE71 DATE,
	MILESTONE71_CLR VARCHAR2(20),
	MILESTONE71_CHK VARCHAR2(20),
	MILESTONE72 DATE,
	MILESTONE72_CLR VARCHAR2(20),
	MILESTONE72_CHK VARCHAR2(20),
	MILESTONE73 DATE,
	MILESTONE73_CHK VARCHAR2(20),
	MILESTONE73_CLR VARCHAR2(20),
	MILESTONE74 DATE,
	MILESTONE74_CHK VARCHAR2(20),
	MILESTONE74_CLR VARCHAR2(20),
	MILESTONE75 DATE,
	MILESTONE75_CHK VARCHAR2(20),
	MILESTONE75_CLR VARCHAR2(20),
	MILESTONE76 DATE,
	MILESTONE77 DATE,
	MILESTONE78 DATE,
	MILESTONE79 DATE,
	MILESTONE80 DATE,
	MILESTONE81 DATE,
	MILESTONE82 DATE,
	MILESTONE83 DATE,
	MILESTONE84 DATE,
	MILESTONE85 DATE,
	MILESTONE86 DATE,
	MILESTONE87 DATE,
	MILESTONE88 DATE,
	MILESTONE89 DATE,
	MILESTONE90 DATE,
	MILESTONE91 DATE,
	MILESTONE92 DATE,
	MILESTONE93 DATE,
	MILESTONE94 DATE,
	MILESTONE95 DATE,
	MILESTONE96 DATE,
	MILESTONE97 DATE,
	MILESTONE98 DATE,
	MILESTONE99 DATE,
	MILESTONE100 DATE,
	MILESTONE76_CHK VARCHAR2(20),
	MILESTONE77_CHK VARCHAR2(20),
	MILESTONE78_CHK VARCHAR2(20),
	MILESTONE79_CHK VARCHAR2(20),
	MILESTONE80_CHK VARCHAR2(20),
	MILESTONE81_CHK VARCHAR2(20),
	MILESTONE82_CHK VARCHAR2(20),
	MILESTONE83_CHK VARCHAR2(20),
	MILESTONE84_CHK VARCHAR2(20),
	MILESTONE85_CHK VARCHAR2(20),
	MILESTONE86_CHK VARCHAR2(20),
	MILESTONE87_CHK VARCHAR2(20),
	MILESTONE88_CHK VARCHAR2(20),
	MILESTONE89_CHK VARCHAR2(20),
	MILESTONE90_CHK VARCHAR2(20),
	MILESTONE91_CHK VARCHAR2(20),
	MILESTONE92_CHK VARCHAR2(20),
	MILESTONE93_CHK VARCHAR2(20),
	MILESTONE94_CHK VARCHAR2(20),
	MILESTONE95_CHK VARCHAR2(20),
	MILESTONE96_CHK VARCHAR2(20),
	MILESTONE97_CHK VARCHAR2(20),
	MILESTONE98_CHK VARCHAR2(20),
	MILESTONE99_CHK VARCHAR2(20),
	MILESTONE100_CHK VARCHAR2(20),
	MILESTONE76_CLR VARCHAR2(20),
	MILESTONE77_CLR VARCHAR2(20),
	MILESTONE78_CLR VARCHAR2(20),
	MILESTONE79_CLR VARCHAR2(20),
	MILESTONE80_CLR VARCHAR2(20),
	MILESTONE81_CLR VARCHAR2(20),
	MILESTONE82_CLR VARCHAR2(20),
	MILESTONE83_CLR VARCHAR2(20),
	MILESTONE84_CLR VARCHAR2(20),
	MILESTONE85_CLR VARCHAR2(20),
	MILESTONE86_CLR VARCHAR2(20),
	MILESTONE87_CLR VARCHAR2(20),
	MILESTONE88_CLR VARCHAR2(20),
	MILESTONE89_CLR VARCHAR2(20),
	MILESTONE90_CLR VARCHAR2(20),
	MILESTONE91_CLR VARCHAR2(20),
	MILESTONE92_CLR VARCHAR2(20),
	MILESTONE93_CLR VARCHAR2(20),
	MILESTONE94_CLR VARCHAR2(20),
	MILESTONE95_CLR VARCHAR2(20),
	MILESTONE96_CLR VARCHAR2(20),
	MILESTONE97_CLR VARCHAR2(20),
	MILESTONE98_CLR VARCHAR2(20),
	MILESTONE99_CLR VARCHAR2(20),
	MILESTONE100_CLR VARCHAR2(20),
	DECISION VARCHAR2(100),
	 PRIMARY KEY (MILESTONE_ID)
  USING INDEX  ENABLE
   ) ;

