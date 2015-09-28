create or replace function clas_cad(integer,text,integer,text) returns setof tpm_table 
AS
$$
DECLARE
tp ALIAS FOR $1;
tb ALIAS FOR $2;
cd ALIAS FOR $3;
nm ALIAS FOR $4;
BEGIN
IF tp = 1 THEN
insert into tb values (cd,nm);
return tpm_table;
END IF;
END;
$$
LANGUAGE 'PLPGSQL';