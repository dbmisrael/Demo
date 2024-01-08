CREATE OR REPLACE EDITIONABLE TYPE EXCELTABLECELL FORCE as object (
  cellRow   integer
, cellCol   varchar2(3)
, cellType  varchar2(10)
, cellData  anydata
, sheetIdx  integer
, cellNote  varchar2(32767)
);
/

