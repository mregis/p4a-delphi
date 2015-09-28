ALTER TABLE prod_extratos OWNER TO postgres;
GRANT ALL ON TABLE prod_extratos TO postgres;
GRANT SELECT ON TABLE prod_extratos TO ads;

-- View: "prod_extratos"

-- DROP VIEW prod_extratos;

CREATE OR REPLACE VIEW prod_extratos AS 
((((((((((((( SELECT count(cga33.cg33_dtbaixa) AS "QTDE", cga33.cg33_dtbaixa AS "DATA", 1 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga33
   JOIN cga20 ON cga33.cg33_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga33.cg33_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao
UNION 
 SELECT count(cga68.cg68_dtbaixa) AS "QTDE", cga68.cg68_dtbaixa AS "DATA", 2 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga68
   JOIN cga20 ON cga68.cg68_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga68.cg68_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga75.cg75_dtbaixa) AS "QTDE", cga75.cg75_dtbaixa AS "DATA", 3 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga75
   JOIN cga20 ON cga75.cg75_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga75.cg75_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga76.cg76_dtentr) AS "QTDE", cga76.cg76_dtentr AS "DATA", 4 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga76
   FULL JOIN cga20 ON cga76.cg76_codentr::bpchar = cga20.cg20_codbaixa::bpchar
  GROUP BY cga76.cg76_dtentr, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga76.cg76_dtsai) AS "QTDE", cga76.cg76_dtsai AS "DATA", 5 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga76
   JOIN cga20 ON cga76.cg76_codbaixa = cga20.cg20_codbaixa::bpchar
  GROUP BY cga76.cg76_dtsai, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga78.cg78_dtbaixa) AS "QTDE", cga78.cg78_dtbaixa AS "DATA", 6 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga78
   JOIN cga20 ON cga78.cg78_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga78.cg78_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga100.cg100_dtbaixa) AS "QTDE", cga100.cg100_dtbaixa AS "DATA", 7 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga100
   JOIN cga20 ON cga100.cg100_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga100.cg100_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga120.cg120_dtbaixa) AS "QTDE", cga120.cg120_dtbaixa AS "DATA", 8 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga120
   JOIN cga20 ON cga120.cg120_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga120.cg120_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga130.cg130_dtbaixa) AS "QTDE", cga130.cg130_dtbaixa AS "DATA", 9 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga130
   JOIN cga20 ON cga130.cg130_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga130.cg130_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga140.cg140_dtbxa) AS "QTDE", cga140.cg140_dtbxa AS "DATA", 10 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga140
   JOIN cga20 ON cga140.cg140_codbxa = cga20.cg20_codbaixa::bpchar
  GROUP BY cga140.cg140_dtbxa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga70.cg70_dtbaixa) AS "QTDE", cga70.cg70_dtbaixa AS "DATA", 11 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga70
   JOIN cga20 ON cga70.cg70_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga70.cg70_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga69.cg69_dtbaixa) AS "QTDE", cga69.cg69_dtbaixa AS "DATA", 12 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga69
   JOIN cga20 ON cga69.cg69_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga69.cg69_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cgafatcrtcrd.cgfatcrtcrd_dtbaixa) AS "QTDE", cgafatcrtcrd.cgfatcrtcrd_dtbaixa AS "DATA", 13 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cgafatcrtcrd
   JOIN cga20 ON cgafatcrtcrd.cgfatcrtcrd_codbaixa = cga20.cg20_codbaixa::bpchar
  GROUP BY cgafatcrtcrd.cgfatcrtcrd_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga035.cg035_dtbaixa) AS "QTDE", cga035.cg035_dtbaixa AS "DATA", 14 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga035
   JOIN cga20 ON cga035.cg035_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga035.cg035_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao)
UNION 
 SELECT count(cga036.cg036_dtbaixa) AS "QTDE", cga036.cg036_dtbaixa AS "DATA", 15 AS "Tipo_Servico", cga20.cg20_codbaixa AS "CodBaixa", cga20.cg20_descricao AS "Motivo"
   FROM cga036
   JOIN cga20 ON cga036.cg036_codbaixa::text = cga20.cg20_codbaixa::text
  GROUP BY cga036.cg036_dtbaixa, 3, cga20.cg20_codbaixa, cga20.cg20_descricao
  ORDER BY 3;

ALTER TABLE prod_extratos OWNER TO postgres;
GRANT ALL ON TABLE prod_extratos TO postgres;
GRANT SELECT ON TABLE prod_extratos TO ads;
