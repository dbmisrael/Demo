CREATE OR REPLACE EDITIONABLE PROCEDURE LOAD_FILE (
pstore VARCHAR2,
pdname VARCHAR2,
pfname VARCHAR2) IS

src_file BFILE;
dst_file BLOB;
lgh_file BINARY_INTEGER;
BEGIN
src_file := bfilename('DATA_PUMP_DIR', pfname);

-- insert a NULL record to lock
INSERT INTO nn_store_images
(store_number, dir_name, file_name, iblob)
VALUES
(pstore, pdname, pfname, EMPTY_BLOB())
RETURNING iblob INTO dst_file;

-- lock record
SELECT iblob
INTO dst_file
FROM nn_store_images
WHERE store_number = pstore
AND file_name = pfname
FOR UPDATE;

-- open the file
dbms_lob.fileopen(src_file, dbms_lob.file_readonly);

-- determine length
lgh_file := dbms_lob.getlength(src_file);

-- read the file
dbms_lob.loadfromfile(dst_file, src_file, lgh_file);

-- update the blob field
UPDATE nn_store_images
SET iblob = dst_file
WHERE store_number = pstore
AND file_name = pfname;

-- close file
dbms_lob.fileclose(src_file);
END load_file;
/

