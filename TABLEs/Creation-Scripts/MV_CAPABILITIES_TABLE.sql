CREATE TABLE MV_CAPABILITIES_TABLE
   (	STATEMENT_ID VARCHAR2(30),
	MVOWNER VARCHAR2(30),
	MVNAME VARCHAR2(30),
	CAPABILITY_NAME VARCHAR2(30),
	POSSIBLE CHAR(1),
	RELATED_TEXT VARCHAR2(2000),
	RELATED_NUM NUMBER,
	MSGNO NUMBER(*,0),
	MSGTXT VARCHAR2(2000),
	SEQ NUMBER
   ) ;

