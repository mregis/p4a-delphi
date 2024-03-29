SELECT * FROM 
(SELECT DISTINCT s.sdx_dtenvio,
    '9'|| /* Tipo de Registro */
	lpad(cast(serv.tbsdxserv_prod as varchar),4,'0') ||  /* Código de Cliente */
    repeat('0',15) || /* FILLER */
    rpad(serv.tbsdxserv_dsc, 40, ' ') || /* Nome do Cliente */
    to_char(CURRENT_DATE, 'YYYYMMDD') || /* Data Geração do Arquivo */
    lpad(cast(COUNT(DISTINCT s.sdx_numobj1) AS varchar), 6, '0') || /* Quantidade de Registros */
    repeat('0',94) || /* FILLER */
    lpad('1', 5, '0')  || /* Sequencial de arquivo */     
    lpad(cast( (row_number() over (ORDER BY s.sdx_dtenvio DESC)) as varchar),7,'0')	AS LINHA,
    row_number() over (ORDER BY s.sdx_dtenvio DESC) AS num
FROM
  public.tbsdx02 s
  INNER JOIN tbsdxserv serv ON (s.sdx_siglaobj = serv.tbsdxserv_sigla)
WHERE  s.sdx_dtcarga = '2015-01-20'
  AND s.sdx_siglaobj = 'ZH'
GROUP BY s.sdx_dtenvio, serv.tbsdxserv_prod, serv.tbsdxserv_dsc
LIMIT 1 ) z    
UNION

SELECT
  s2.sdx_dtenvio AS "DATA ENVIO",
  '9'|| /* Tipo de Registro */
  lpad(cast(serv2.tbsdxserv_prod as varchar),4,'0') ||  /* Código de Cliente */
  CAST('AD' as varchar) || /* Identificador de Cliente */
  sdx_siglaobj || /* Sigla do Objeto */
  lpad(cast(sdx_numobj as varchar),9,'0') || /* Código do Objeto */
  sdx_paisorigem || /* Código do País de Origem */
  1101 || /* Código da Operação */
  repeat(' ',16) || /* Campo Livre */
  substr(rpad(sdx_nomdest,40,' '),1,40) ||  /* Nome do destinatário */
  substr(rpad(sdx_endedest,40,' '),1,40) ||  /* Endereço do destinatário */
  substr(rpad(sdx_cidade,30,' '),1,30) ||  /* Cidade */
  sdx_uf || /* UF */
  sdx_cep || /* CEP */
  repeat('0',8) || /* Filler */
  lpad('1',5,'0') || /* Numero de Remessa de Arquivo Sequencial */ 
  lpad(cast( (row_number() over (ORDER BY s2.sdx_dtenvio DESC))+1 as varchar),7,'0') AS LINHA,
  (row_number() over (ORDER BY s2.sdx_dtenvio DESC))+1 AS num
FROM
  public.tbsdx02 s2
  INNER JOIN tbsdxserv serv2 ON (s2.sdx_siglaobj = serv2.tbsdxserv_sigla)
WHERE  s2.sdx_dtenvio = '2015-01-20'
  AND s2.sdx_siglaobj = 'ZH'
ORDER BY num
;