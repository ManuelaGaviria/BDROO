connect system/1234

show con_name

ALTER SESSION SET CONTAINER=CDB$ROOT;
ALTER DATABASE OPEN;

DROP TABLESPACE TS_BDROO INCLUDING CONTENTS and DATAFILES;
    
CREATE TABLESPACE TS_BDROO LOGGING
DATAFILE 'C:\Users\ASUS\Desktop\BDFinal\DF_DBOBJECTUAL.dbf' size 500M
extent management local segment space management auto;
 
alter session set "_ORACLE_SCRIPT"=true;
 
drop user US_BDROO cascade;
    
CREATE user US_BDROO profile default
identified by 1234
default tablespace TS_BDROO
temporary tablespace temp
account unlock;	 

--privilegios
grant connect, resource,dba to US_BDROO;

connect US_BDROO/1234

show user