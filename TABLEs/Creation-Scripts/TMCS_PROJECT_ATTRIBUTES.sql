CREATE TABLE TMCS_PROJECT_ATTRIBUTES
   (	PROJ_ATTR_ID NUMBER,
	PROJECT_ID NUMBER,
	C_EXT_ATTR1 VARCHAR2(2000),
	C_EXT_ATTR2 VARCHAR2(2000),
	C_EXT_ATTR3 VARCHAR2(2000),
	C_EXT_ATTR4 VARCHAR2(2000),
	C_EXT_ATTR5 VARCHAR2(2000),
	C_EXT_ATTR6 VARCHAR2(2000),
	C_EXT_ATTR7 VARCHAR2(2000),
	C_EXT_ATTR8 VARCHAR2(2000),
	C_EXT_ATTR9 VARCHAR2(2000),
	C_EXT_ATTR10 VARCHAR2(2000),
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0) NOT NULL ENABLE,
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	C_EXT_ATTR11 VARCHAR2(2000),
	C_EXT_ATTR12 VARCHAR2(2000),
	C_EXT_ATTR13 VARCHAR2(2000),
	C_EXT_ATTR14 VARCHAR2(2000),
	C_EXT_ATTR15 VARCHAR2(2000),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	N_EXT_ATTR6 NUMBER,
	N_EXT_ATTR7 NUMBER,
	N_EXT_ATTR8 NUMBER,
	N_EXT_ATTR9 NUMBER,
	N_EXT_ATTR10 NUMBER,
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	C_EXT_ATTR16 VARCHAR2(2000),
	C_EXT_ATTR17 VARCHAR2(2000),
	C_EXT_ATTR18 VARCHAR2(2000),
	C_EXT_ATTR19 VARCHAR2(2000),
	C_EXT_ATTR20 VARCHAR2(2000),
	C_EXT_ATTR21 VARCHAR2(2000),
	C_EXT_ATTR22 VARCHAR2(2000),
	C_EXT_ATTR23 VARCHAR2(2000),
	C_EXT_ATTR24 VARCHAR2(2000),
	C_EXT_ATTR25 VARCHAR2(2000),
	C_EXT_ATTR26 VARCHAR2(2000),
	C_EXT_ATTR27 VARCHAR2(2000),
	C_EXT_ATTR28 VARCHAR2(2000),
	C_EXT_ATTR29 VARCHAR2(2000),
	C_EXT_ATTR30 VARCHAR2(2000),
	D_EXT_ATTR6 DATE,
	D_EXT_ATTR7 DATE,
	D_EXT_ATTR8 DATE,
	D_EXT_ATTR9 DATE,
	D_EXT_ATTR10 DATE,
	N_EXT_ATTR11 NUMBER,
	N_EXT_ATTR12 NUMBER,
	N_EXT_ATTR13 NUMBER,
	N_EXT_ATTR14 NUMBER,
	N_EXT_ATTR15 NUMBER,
	C_EXT_LOV1 VARCHAR2(200),
	C_EXT_LOV2 VARCHAR2(200),
	C_EXT_LOV3 VARCHAR2(200),
	C_EXT_LOV4 VARCHAR2(200),
	C_EXT_LOV5 VARCHAR2(200),
	C_EXT_LOV6 VARCHAR2(200),
	C_EXT_LOV7 VARCHAR2(200),
	C_EXT_LOV8 VARCHAR2(200),
	C_EXT_LOV9 VARCHAR2(200),
	D_EXT_ATTR11 DATE,
	D_EXT_ATTR12 DATE,
	D_EXT_ATTR13 DATE,
	D_EXT_ATTR14 DATE,
	D_EXT_ATTR15 DATE,
	D_EXT_ATTR16 DATE,
	D_EXT_ATTR17 DATE,
	D_EXT_ATTR18 DATE,
	D_EXT_ATTR19 DATE,
	D_EXT_ATTR20 DATE,
	N_EXT_ATTR16 NUMBER,
	N_EXT_ATTR17 NUMBER,
	N_EXT_ATTR18 NUMBER,
	N_EXT_ATTR19 NUMBER,
	N_EXT_ATTR20 NUMBER,
	C_EXT_LOV10 VARCHAR2(200),
	C_EXT_LOV11 VARCHAR2(200),
	C_EXT_LOV12 VARCHAR2(200),
	C_EXT_LOV13 VARCHAR2(200),
	C_EXT_LOV14 VARCHAR2(200),
	C_EXT_LOV15 VARCHAR2(200),
	COMMENTS VARCHAR2(2000),
	N_EXT_ATTR21 NUMBER,
	N_EXT_ATTR22 NUMBER,
	N_EXT_ATTR23 NUMBER,
	N_EXT_ATTR24 NUMBER,
	N_EXT_ATTR25 NUMBER,
	RISK VARCHAR2(50),
	C_EXT_LOV16 VARCHAR2(200),
	C_EXT_LOV17 VARCHAR2(200),
	C_EXT_LOV18 VARCHAR2(200),
	C_EXT_LOV19 VARCHAR2(200),
	C_EXT_LOV20 VARCHAR2(200),
	C_EXT_LOV21 VARCHAR2(200),
	C_EXT_LOV22 VARCHAR2(200),
	C_EXT_LOV23 VARCHAR2(200),
	C_EXT_LOV24 VARCHAR2(200),
	C_EXT_LOV25 VARCHAR2(200),
	D_EXT_ATTR21 DATE,
	D_EXT_ATTR22 DATE,
	D_EXT_ATTR23 DATE,
	D_EXT_ATTR24 DATE,
	D_EXT_ATTR25 DATE,
	D_EXT_ATTR26 DATE,
	D_EXT_ATTR27 DATE,
	D_EXT_ATTR28 DATE,
	D_EXT_ATTR29 DATE,
	D_EXT_ATTR30 DATE,
	C_EXT_LOV26 VARCHAR2(200),
	C_EXT_LOV27 VARCHAR2(200),
	C_EXT_LOV28 VARCHAR2(200),
	C_EXT_LOV29 VARCHAR2(200),
	C_EXT_LOV30 VARCHAR2(200),
	C_EXT_LOV31 VARCHAR2(50),
	C_EXT_LOV32 VARCHAR2(50),
	C_EXT_LOV33 VARCHAR2(50),
	C_EXT_LOV34 VARCHAR2(50),
	C_EXT_LOV35 VARCHAR2(50),
	C_EXT_LOV36 VARCHAR2(50),
	C_EXT_ATTR31 VARCHAR2(2000),
	C_EXT_ATTR32 VARCHAR2(2000),
	C_EXT_ATTR33 VARCHAR2(2000),
	C_EXT_ATTR34 VARCHAR2(4000),
	C_EXT_ATTR35 VARCHAR2(4000),
	C_EXT_ATTR36 VARCHAR2(4000),
	C_EXT_ATTR37 VARCHAR2(2000),
	C_EXT_ATTR38 VARCHAR2(2000),
	C_EXT_ATTR39 VARCHAR2(4000),
	C_EXT_ATTR40 VARCHAR2(2000),
	C_EXT_ATTR41 VARCHAR2(4000),
	C_EXT_ATTR42 VARCHAR2(4000),
	C_EXT_ATTR43 VARCHAR2(4000),
	C_EXT_ATTR44 VARCHAR2(2000),
	C_EXT_ATTR45 VARCHAR2(2000),
	C_EXT_ATTR46 VARCHAR2(2000),
	C_EXT_ATTR47 VARCHAR2(2000),
	C_EXT_ATTR48 VARCHAR2(2000),
	C_EXT_ATTR49 VARCHAR2(2000),
	C_EXT_ATTR50 VARCHAR2(2000),
	C_EXT_ATTR51 VARCHAR2(2000),
	C_EXT_ATTR52 VARCHAR2(2000),
	C_EXT_ATTR53 VARCHAR2(2000),
	C_EXT_ATTR54 VARCHAR2(2000),
	C_EXT_ATTR55 VARCHAR2(2000),
	C_EXT_ATTR56 VARCHAR2(2000),
	C_EXT_ATTR57 VARCHAR2(2000),
	C_EXT_ATTR58 VARCHAR2(2000),
	C_EXT_ATTR59 VARCHAR2(2000),
	C_EXT_ATTR60 VARCHAR2(2000),
	C_EXT_ATTR61 VARCHAR2(2000),
	C_EXT_LOV37 VARCHAR2(100),
	C_EXT_LOV38 VARCHAR2(100),
	C_EXT_LOV39 VARCHAR2(100),
	C_EXT_LOV40 VARCHAR2(100),
	C_EXT_LOV41 VARCHAR2(100),
	C_EXT_LOV42 VARCHAR2(100),
	C_EXT_LOV43 VARCHAR2(100),
	C_EXT_LOV44 VARCHAR2(100),
	C_EXT_LOV45 VARCHAR2(100),
	C_EXT_LOV46 VARCHAR2(100),
	C_EXT_LOV47 VARCHAR2(100),
	C_EXT_LOV48 VARCHAR2(100),
	C_EXT_LOV49 VARCHAR2(100),
	C_EXT_LOV50 VARCHAR2(100),
	C_EXT_LOV51 VARCHAR2(100),
	C_EXT_LOV52 VARCHAR2(100),
	C_EXT_LOV53 VARCHAR2(100),
	C_EXT_LOV54 VARCHAR2(100),
	C_EXT_LOV55 VARCHAR2(100),
	C_EXT_LOV56 VARCHAR2(100),
	C_EXT_LOV57 VARCHAR2(100),
	C_EXT_LOV58 VARCHAR2(100),
	C_EXT_LOV59 VARCHAR2(100),
	C_EXT_LOV60 VARCHAR2(100),
	C_EXT_LOV61 VARCHAR2(100),
	N_EXT_ATTR26 NUMBER,
	N_EXT_ATTR27 NUMBER,
	N_EXT_ATTR28 NUMBER,
	N_EXT_ATTR29 NUMBER,
	N_EXT_ATTR30 NUMBER,
	N_EXT_ATTR31 NUMBER,
	N_EXT_ATTR32 NUMBER,
	N_EXT_ATTR33 NUMBER,
	N_EXT_ATTR34 NUMBER,
	N_EXT_ATTR35 NUMBER,
	N_EXT_ATTR36 NUMBER,
	N_EXT_ATTR37 NUMBER,
	N_EXT_ATTR38 NUMBER,
	N_EXT_ATTR39 NUMBER,
	N_EXT_ATTR40 NUMBER,
	N_EXT_ATTR41 NUMBER,
	N_EXT_ATTR42 NUMBER,
	N_EXT_ATTR43 NUMBER,
	N_EXT_ATTR44 NUMBER,
	N_EXT_ATTR45 NUMBER,
	N_EXT_ATTR46 NUMBER,
	N_EXT_ATTR47 NUMBER,
	N_EXT_ATTR48 NUMBER,
	N_EXT_ATTR49 NUMBER,
	N_EXT_ATTR50 NUMBER,
	C_EXT_LOV62 VARCHAR2(200),
	C_EXT_LOV63 VARCHAR2(200),
	C_EXT_LOV64 VARCHAR2(200),
	C_EXT_LOV65 VARCHAR2(200),
	C_EXT_LOV66 VARCHAR2(200),
	C_EXT_LOV67 VARCHAR2(200),
	C_EXT_LOV68 VARCHAR2(200),
	C_EXT_LOV69 VARCHAR2(200),
	C_EXT_LOV70 VARCHAR2(200),
	N_EXT_ATTR51 NUMBER,
	N_EXT_ATTR52 NUMBER,
	N_EXT_ATTR53 NUMBER,
	N_EXT_ATTR54 NUMBER,
	N_EXT_ATTR55 NUMBER,
	C_EXT_ATTR62 VARCHAR2(2000),
	C_EXT_ATTR63 VARCHAR2(2000),
	C_EXT_ATTR64 VARCHAR2(2000),
	C_EXT_ATTR65 VARCHAR2(2000),
	C_EXT_LOV71 VARCHAR2(200),
	C_EXT_LOV72 VARCHAR2(200),
	D_EXT_ATTR31 DATE,
	D_EXT_ATTR32 DATE,
	D_EXT_ATTR33 DATE,
	D_EXT_ATTR34 DATE,
	D_EXT_ATTR35 DATE,
	D_EXT_ATTR36 DATE,
	D_EXT_ATTR37 DATE,
	D_EXT_ATTR38 DATE,
	D_EXT_ATTR39 DATE,
	D_EXT_ATTR40 DATE,
	D_EXT_ATTR41 DATE,
	D_EXT_ATTR42 DATE,
	D_EXT_ATTR43 DATE,
	D_EXT_ATTR44 DATE,
	D_EXT_ATTR45 DATE,
	N_EXT_ATTR56 NUMBER,
	N_EXT_ATTR57 NUMBER,
	N_EXT_ATTR58 NUMBER,
	N_EXT_ATTR59 NUMBER,
	N_EXT_ATTR60 NUMBER,
	N_EXT_ATTR61 NUMBER,
	N_EXT_ATTR62 NUMBER,
	N_EXT_ATTR63 NUMBER,
	N_EXT_ATTR64 NUMBER,
	N_EXT_ATTR65 NUMBER,
	C_EXT_LOV73 VARCHAR2(200),
	C_EXT_LOV74 VARCHAR2(200),
	C_EXT_LOV75 VARCHAR2(200),
	C_EXT_LOV76 VARCHAR2(200),
	C_EXT_LOV77 VARCHAR2(200),
	C_EXT_LOV78 VARCHAR2(200),
	C_EXT_LOV79 VARCHAR2(200),
	C_EXT_LOV80 VARCHAR2(200),
	C_EXT_LOV81 VARCHAR2(200),
	C_EXT_LOV82 VARCHAR2(200),
	C_EXT_LOV83 VARCHAR2(200),
	C_EXT_LOV84 VARCHAR2(200),
	C_EXT_LOV85 VARCHAR2(200),
	C_EXT_LOV86 VARCHAR2(200),
	C_EXT_LOV87 VARCHAR2(200),
	C_EXT_LOV88 VARCHAR2(200),
	C_EXT_LOV89 VARCHAR2(200),
	C_EXT_LOV90 VARCHAR2(200),
	C_EXT_ATTR66 VARCHAR2(2000),
	C_EXT_ATTR67 VARCHAR2(2000),
	C_EXT_ATTR68 VARCHAR2(2000),
	C_EXT_ATTR69 VARCHAR2(2000),
	C_EXT_ATTR70 VARCHAR2(2000),
	C_EXT_ATTR71 VARCHAR2(2000),
	C_EXT_ATTR72 VARCHAR2(2000),
	C_EXT_ATTR73 VARCHAR2(2000),
	C_EXT_ATTR74 VARCHAR2(2000),
	C_EXT_ATTR75 VARCHAR2(2000),
	C_EXT_ATTR76 VARCHAR2(2000),
	C_EXT_ATTR77 VARCHAR2(2000),
	C_EXT_ATTR78 VARCHAR2(2000),
	C_EXT_ATTR79 VARCHAR2(2000),
	C_EXT_ATTR80 VARCHAR2(2000),
	C_EXT_ATTR81 VARCHAR2(2000),
	C_EXT_ATTR82 VARCHAR2(2000),
	C_EXT_ATTR83 VARCHAR2(2000),
	C_EXT_ATTR84 VARCHAR2(2000),
	C_EXT_ATTR85 VARCHAR2(2000),
	C_EXT_ATTR86 VARCHAR2(2000),
	C_EXT_ATTR87 VARCHAR2(2000),
	C_EXT_ATTR88 VARCHAR2(2000),
	C_EXT_ATTR89 VARCHAR2(2000),
	C_EXT_ATTR90 VARCHAR2(2000),
	C_EXT_ATTR91 VARCHAR2(2000),
	C_EXT_ATTR92 VARCHAR2(2000),
	C_EXT_ATTR93 VARCHAR2(2000),
	C_EXT_ATTR94 VARCHAR2(2000),
	C_EXT_ATTR95 VARCHAR2(2000),
	C_EXT_ATTR96 VARCHAR2(2000),
	C_EXT_ATTR97 VARCHAR2(2000),
	C_EXT_ATTR98 VARCHAR2(2000),
	C_EXT_ATTR99 VARCHAR2(2000),
	C_EXT_ATTR100 VARCHAR2(2000),
	C_EXT_ATTR101 VARCHAR2(2000),
	C_EXT_ATTR102 VARCHAR2(2000),
	C_EXT_ATTR103 VARCHAR2(2000),
	C_EXT_ATTR104 VARCHAR2(2000),
	C_EXT_ATTR105 VARCHAR2(2000),
	C_EXT_ATTR106 VARCHAR2(2000),
	C_EXT_ATTR107 VARCHAR2(2000),
	C_EXT_ATTR108 VARCHAR2(2000),
	C_EXT_ATTR109 VARCHAR2(2000),
	C_EXT_ATTR110 VARCHAR2(2000),
	C_EXT_ATTR111 VARCHAR2(2000),
	C_EXT_ATTR112 VARCHAR2(2000),
	C_EXT_ATTR113 VARCHAR2(2000),
	C_EXT_ATTR114 VARCHAR2(2000),
	C_EXT_ATTR115 VARCHAR2(2000),
	C_EXT_ATTR116 VARCHAR2(2000),
	C_EXT_ATTR117 VARCHAR2(2000),
	C_EXT_ATTR118 VARCHAR2(2000),
	C_EXT_ATTR119 VARCHAR2(2000),
	C_EXT_ATTR120 VARCHAR2(2000),
	C_EXT_ATTR121 VARCHAR2(2000),
	C_EXT_ATTR122 VARCHAR2(2000),
	C_EXT_ATTR123 VARCHAR2(2000),
	C_EXT_ATTR124 VARCHAR2(2000),
	C_EXT_ATTR125 VARCHAR2(2000),
	C_EXT_ATTR126 VARCHAR2(2000),
	C_EXT_ATTR127 VARCHAR2(2000),
	C_EXT_ATTR128 VARCHAR2(2000),
	C_EXT_ATTR129 VARCHAR2(2000),
	C_EXT_ATTR130 VARCHAR2(2000),
	C_EXT_ATTR131 VARCHAR2(2000),
	C_EXT_ATTR132 VARCHAR2(2000),
	C_EXT_ATTR133 VARCHAR2(2000),
	C_EXT_ATTR134 VARCHAR2(2000),
	C_EXT_ATTR135 VARCHAR2(2000),
	C_EXT_ATTR136 VARCHAR2(2000),
	C_EXT_ATTR137 VARCHAR2(2000),
	C_EXT_ATTR138 VARCHAR2(2000),
	C_EXT_ATTR139 VARCHAR2(2000),
	C_EXT_ATTR140 VARCHAR2(2000),
	C_EXT_ATTR141 VARCHAR2(2000),
	C_EXT_ATTR142 VARCHAR2(2000),
	C_EXT_ATTR143 VARCHAR2(2000),
	C_EXT_ATTR144 VARCHAR2(2000),
	C_EXT_ATTR145 VARCHAR2(2000),
	C_EXT_ATTR146 VARCHAR2(2000),
	C_EXT_ATTR147 VARCHAR2(2000),
	C_EXT_ATTR148 VARCHAR2(2000),
	C_EXT_ATTR149 VARCHAR2(2000),
	C_EXT_ATTR150 VARCHAR2(2000),
	C_EXT_ATTR161 VARCHAR2(2000),
	C_EXT_ATTR162 VARCHAR2(2000),
	C_EXT_ATTR163 VARCHAR2(2000),
	C_EXT_ATTR164 VARCHAR2(2000),
	C_EXT_ATTR165 VARCHAR2(2000),
	C_EXT_ATTR166 VARCHAR2(2000),
	C_EXT_ATTR167 VARCHAR2(2000),
	C_EXT_ATTR168 VARCHAR2(2000),
	C_EXT_ATTR169 VARCHAR2(2000),
	C_EXT_ATTR170 VARCHAR2(2000),
	C_EXT_ATTR171 VARCHAR2(2000),
	C_EXT_ATTR172 VARCHAR2(2000),
	C_EXT_ATTR173 VARCHAR2(2000),
	C_EXT_ATTR174 VARCHAR2(2000),
	C_EXT_ATTR175 VARCHAR2(2000),
	C_EXT_ATTR176 VARCHAR2(2000),
	C_EXT_ATTR177 VARCHAR2(2000),
	C_EXT_ATTR178 VARCHAR2(2000),
	C_EXT_ATTR179 VARCHAR2(2000),
	C_EXT_ATTR180 VARCHAR2(2000),
	C_EXT_ATTR181 VARCHAR2(2000),
	C_EXT_ATTR182 VARCHAR2(2000),
	C_EXT_ATTR183 VARCHAR2(2000),
	C_EXT_ATTR184 VARCHAR2(2000),
	C_EXT_ATTR185 VARCHAR2(2000),
	C_EXT_ATTR186 VARCHAR2(2000),
	C_EXT_ATTR187 VARCHAR2(2000),
	C_EXT_ATTR188 VARCHAR2(2000),
	C_EXT_ATTR189 VARCHAR2(2000),
	C_EXT_ATTR190 VARCHAR2(2000),
	MASTER_PROJECT_ID NUMBER,
	T_EXT_ATTR1 VARCHAR2(500),
	T_EXT_ATTR2 VARCHAR2(500),
	T_EXT_ATTR3 VARCHAR2(500),
	T_EXT_ATTR4 VARCHAR2(500),
	T_EXT_ATTR5 VARCHAR2(500),
	T_EXT_ATTR6 VARCHAR2(500),
	T_EXT_ATTR7 VARCHAR2(500),
	T_EXT_ATTR8 VARCHAR2(500),
	T_EXT_ATTR9 VARCHAR2(500),
	T_EXT_ATTR10 VARCHAR2(500),
	C_EXT_LOV91 VARCHAR2(500),
	C_EXT_LOV92 VARCHAR2(500),
	C_EXT_LOV93 VARCHAR2(500),
	C_EXT_LOV94 VARCHAR2(500),
	C_EXT_LOV95 VARCHAR2(500),
	C_EXT_LOV96 VARCHAR2(500),
	C_EXT_LOV97 VARCHAR2(500),
	C_EXT_LOV98 VARCHAR2(500),
	C_EXT_LOV99 VARCHAR2(500),
	C_EXT_LOV100 VARCHAR2(500),
	C_EXT_LOV101 VARCHAR2(500),
	C_EXT_LOV102 VARCHAR2(500),
	C_EXT_LOV103 VARCHAR2(500),
	C_EXT_LOV104 VARCHAR2(500),
	C_EXT_LOV105 VARCHAR2(500),
	C_EXT_LOV106 VARCHAR2(500),
	C_EXT_LOV107 VARCHAR2(500),
	C_EXT_LOV108 VARCHAR2(500),
	C_EXT_LOV109 VARCHAR2(500),
	C_EXT_LOV110 VARCHAR2(500),
	D_EXT_ATTR46 DATE,
	D_EXT_ATTR47 DATE,
	D_EXT_ATTR48 DATE,
	D_EXT_ATTR49 DATE,
	D_EXT_ATTR50 DATE,
	D_EXT_ATTR51 DATE,
	D_EXT_ATTR52 DATE,
	D_EXT_ATTR53 DATE,
	D_EXT_ATTR54 DATE,
	D_EXT_ATTR55 DATE,
	D_EXT_ATTR56 DATE,
	D_EXT_ATTR57 DATE,
	D_EXT_ATTR58 DATE,
	D_EXT_ATTR59 DATE,
	D_EXT_ATTR60 DATE,
	C_EXT_LOV111 VARCHAR2(500),
	C_EXT_LOV112 VARCHAR2(500),
	C_EXT_LOV113 VARCHAR2(500),
	C_EXT_LOV114 VARCHAR2(500),
	C_EXT_LOV115 VARCHAR2(500),
	C_EXT_LOV116 VARCHAR2(500),
	C_EXT_LOV117 VARCHAR2(500),
	C_EXT_LOV118 VARCHAR2(500),
	C_EXT_LOV119 VARCHAR2(500),
	C_EXT_LOV120 VARCHAR2(500),
	C_EXT_LOV121 VARCHAR2(500),
	C_EXT_LOV122 VARCHAR2(500),
	C_EXT_LOV123 VARCHAR2(500),
	C_EXT_LOV124 VARCHAR2(500),
	C_EXT_LOV125 VARCHAR2(500),
	C_EXT_LOV126 VARCHAR2(500),
	C_EXT_LOV127 VARCHAR2(500),
	C_EXT_LOV128 VARCHAR2(500),
	C_EXT_LOV129 VARCHAR2(500),
	C_EXT_LOV130 VARCHAR2(500),
	C_EXT_LOV131 VARCHAR2(500),
	C_EXT_LOV132 VARCHAR2(500),
	C_EXT_LOV133 VARCHAR2(500),
	C_EXT_LOV134 VARCHAR2(500),
	C_EXT_LOV135 VARCHAR2(500),
	C_EXT_LOV136 VARCHAR2(500),
	C_EXT_LOV137 VARCHAR2(500),
	C_EXT_LOV138 VARCHAR2(500),
	C_EXT_LOV139 VARCHAR2(500),
	C_EXT_LOV140 VARCHAR2(500),
	C_EXT_LOV141 VARCHAR2(500),
	C_EXT_LOV142 VARCHAR2(500),
	C_EXT_LOV143 VARCHAR2(500),
	C_EXT_LOV144 VARCHAR2(500),
	C_EXT_LOV145 VARCHAR2(500),
	C_EXT_LOV146 VARCHAR2(500),
	C_EXT_LOV147 VARCHAR2(500),
	C_EXT_LOV148 VARCHAR2(500),
	C_EXT_LOV149 VARCHAR2(500),
	C_EXT_LOV150 VARCHAR2(500),
	N_EXT_ATTR66 NUMBER,
	N_EXT_ATTR67 NUMBER,
	N_EXT_ATTR68 NUMBER,
	N_EXT_ATTR69 NUMBER,
	N_EXT_ATTR70 NUMBER,
	N_EXT_ATTR71 NUMBER,
	N_EXT_ATTR72 NUMBER,
	N_EXT_ATTR73 NUMBER,
	N_EXT_ATTR74 NUMBER,
	N_EXT_ATTR75 NUMBER,
	N_EXT_ATTR76 NUMBER,
	N_EXT_ATTR77 NUMBER,
	N_EXT_ATTR78 NUMBER,
	N_EXT_ATTR79 NUMBER,
	N_EXT_ATTR80 NUMBER,
	 PRIMARY KEY (PROJ_ATTR_ID)
  USING INDEX  ENABLE
   ) ;
CREATE INDEX TMCS_PROJECT_ATTRIBUTES_INDX1 ON TMCS_PROJECT_ATTRIBUTES (ENTITY_ID)
  ;

