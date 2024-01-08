CREATE TABLE TMCS_SURVEY_QUESTION_ANSWERS
   (	QUESTION_ANSWER_ID NUMBER(*,0),
	QUESTION_ID NUMBER(*,0),
	QUESTION_ANSWER_TAG VARCHAR2(255),
	QUESTION_ANSWER_KEY VARCHAR2(255),
	QUESTION_ANSWER_VALUE VARCHAR2(255),
	ANSWER_SELECTED CHAR(1),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0),
	ANSWER1 VARCHAR2(1000),
	ANSWER2 VARCHAR2(1000),
	ANSWER3 VARCHAR2(1000),
	ANSWER4 VARCHAR2(1000),
	ANSWER5 VARCHAR2(1000),
	ANSWER6 VARCHAR2(1000),
	ANSWER7 VARCHAR2(1000),
	ANSWER8 VARCHAR2(1000),
	ANSWER9 VARCHAR2(1000),
	ANSWER10A VARCHAR2(1000),
	ANSWER10B VARCHAR2(1000),
	ANSWER11 VARCHAR2(1000),
	ANSWER12 VARCHAR2(1000),
	ANSWER13 VARCHAR2(1000),
	ANSWER14 VARCHAR2(1000),
	ANSWER15 VARCHAR2(1000),
	ANSWER16 VARCHAR2(1000),
	ANSWER17 VARCHAR2(1000),
	ANSWER18 VARCHAR2(1000),
	ANSWER19 VARCHAR2(1000),
	ANSWER20 VARCHAR2(1000),
	ANSWER21 VARCHAR2(1000),
	ANSWER22 VARCHAR2(1000),
	ANSWER23 VARCHAR2(1000),
	ANSWER24 VARCHAR2(1000),
	ANSWER25 VARCHAR2(1000),
	ANSWER26 VARCHAR2(1000),
	ANSWER27 VARCHAR2(1000),
	ANSWER28 VARCHAR2(1000),
	ANSWER29 VARCHAR2(1000),
	ANSWER30 VARCHAR2(1000),
	ANSWER31 VARCHAR2(1000),
	ANSWER32 VARCHAR2(1000),
	ANSWER33 VARCHAR2(1000),
	ANSWER34 VARCHAR2(1000),
	ANSWER35 VARCHAR2(1000),
	ANSWER36 VARCHAR2(1000),
	ANSWER37 VARCHAR2(1000),
	ANSWER38 VARCHAR2(1000),
	ANSWER39A VARCHAR2(1000),
	ANSWER39B VARCHAR2(1000),
	ANSWER40 VARCHAR2(1000),
	ANSWER41 VARCHAR2(1000),
	ANSWER42 VARCHAR2(1000),
	ANSWER43 VARCHAR2(1000),
	ANSWER44 VARCHAR2(1000),
	ANSWER45 VARCHAR2(1000),
	ANSWER46 VARCHAR2(1000),
	ANSWER47 VARCHAR2(1000),
	ANSWER48 VARCHAR2(1000),
	ANSWER49 VARCHAR2(1000),
	ANSWER50 VARCHAR2(1000),
	ANSWER51 VARCHAR2(1000),
	ANSWER52 VARCHAR2(1000),
	ANSWER53 VARCHAR2(1000),
	ANSWER54 VARCHAR2(1000),
	ANSWER55 VARCHAR2(1000),
	ANSWER56 VARCHAR2(1000),
	ANSWER57 VARCHAR2(1000),
	ANSWER58 VARCHAR2(1000),
	ANSWER59 VARCHAR2(1000),
	ANSWER60 VARCHAR2(1000),
	ANSWER61 VARCHAR2(1000),
	ANSWER4B VARCHAR2(1000),
	ANSWER6B VARCHAR2(1000),
	ANSWER7B VARCHAR2(1000),
	ANSWER8B VARCHAR2(1000),
	ANSWER9B VARCHAR2(1000),
	ANSWER10AB VARCHAR2(1000),
	ANSWER10AC VARCHAR2(1000),
	ANSWER10AD VARCHAR2(1000),
	ANSWER10AE VARCHAR2(1000),
	ANSWER10AF VARCHAR2(1000),
	ANSWER10BB VARCHAR2(1000),
	ENTITY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	ANSWER15B VARCHAR2(1000),
	ANSWER3AA VARCHAR2(1000),
	ANSWER3AB VARCHAR2(1000),
	ANSWER3BA VARCHAR2(1000),
	ANSWER3BB VARCHAR2(1000),
	ANSWER3CA VARCHAR2(1000),
	ANSWER3CB VARCHAR2(1000),
	ANSWER24B VARCHAR2(1000),
	ANSWER25B VARCHAR2(1000),
	ANSWER26B VARCHAR2(1000),
	ANSWER36B VARCHAR2(1000),
	ANSWER32B VARCHAR2(1000),
	ANSWER37B VARCHAR2(1000),
	ANSWER39AB VARCHAR2(1000),
	ANSWER41B VARCHAR2(1000),
	ANSWER42B VARCHAR2(1000),
	ANSWER43B VARCHAR2(1000),
	ANSWER47B VARCHAR2(1000),
	ANSWER49B VARCHAR2(1000),
	ANSWER49C VARCHAR2(1000),
	ANSWER43AB VARCHAR2(1000),
	ANSWER43AC VARCHAR2(1000),
	ANSWER43BB VARCHAR2(1000),
	ANSWER43BC VARCHAR2(1000),
	ANSWER42AB VARCHAR2(1000),
	ANSWER42AC VARCHAR2(1000),
	ANSWER42BB VARCHAR2(1000),
	ANSWER42BC VARCHAR2(1000),
	ANSWER32AB VARCHAR2(1000),
	ANSWER32BB VARCHAR2(1000),
	ANSWER15AB VARCHAR2(1000),
	ANSWER15AC VARCHAR2(1000),
	ANSWER15BB VARCHAR2(1000),
	ANSWER15BC VARCHAR2(1000),
	ANSWER14B VARCHAR2(1000),
	ANSWER14C VARCHAR2(1000),
	ANSWER13B VARCHAR2(1000),
	ANSWER13C VARCHAR2(1000),
	PHOTOS BLOB,
	COMMENTS CLOB,
	ANSWER3A VARCHAR2(1000),
	ANSWER3B VARCHAR2(1000),
	ANSWER3C VARCHAR2(1000),
	ANSWER3AC VARCHAR2(1000),
	ANSWER3BC VARCHAR2(1000),
	ANSWER3CC VARCHAR2(1000),
	ANSWER38A VARCHAR2(1000),
	ANSWER54A VARCHAR2(1000),
	ANSWER36SA VARCHAR2(1),
	ANSWER36SB VARCHAR2(1),
	ANSWER36SC VARCHAR2(1),
	ANSWER54SA VARCHAR2(1),
	ANSWER54SB VARCHAR2(1),
	ANSWER54SC VARCHAR2(1),
	ANSWER54SD VARCHAR2(1),
	ANSWER54SE VARCHAR2(1),
	ANSWER54SF VARCHAR2(1),
	ANSWER54SG VARCHAR2(1),
	ANSWER54SH VARCHAR2(1),
	ANSWER54SI VARCHAR2(1),
	ANSWER54SJ VARCHAR2(1),
	ANSWER54SK VARCHAR2(1),
	ANSWER54SL VARCHAR2(1),
	ANSWER54SM VARCHAR2(1),
	ANSWER11A VARCHAR2(20),
	ANSWER11B VARCHAR2(20),
	ANSWER11C VARCHAR2(20),
	ANSWER11D VARCHAR2(20),
	ANSWER11E VARCHAR2(20),
	ANSWER11F VARCHAR2(20),
	ANSWER11G VARCHAR2(20),
	ANSWER11H VARCHAR2(20),
	ANSWER61SA VARCHAR2(1),
	ANSWER61SB VARCHAR2(1),
	ANSWER61SC VARCHAR2(1),
	ANSWER61SD VARCHAR2(1),
	ANSWER61SE VARCHAR2(1),
	ANSWER61SF VARCHAR2(1),
	ANSWER61A VARCHAR2(300),
	ANSWER61B VARCHAR2(300),
	 PRIMARY KEY (QUESTION_ANSWER_ID)
  USING INDEX  ENABLE
   ) ;
