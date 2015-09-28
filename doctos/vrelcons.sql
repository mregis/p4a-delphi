-- View: "relcons"

--DROP VIEW relcons;

CREATE OR REPLACE VIEW relcons AS 
(((((((((((((( SELECT count(cga33.cg33_dtbaixa) AS "QTDE", cga33.cg33_dtbaixa AS "DATA", 0 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga33
   JOIN cga_acesso ON cga33.cg33_codusu = cga_acesso.codigo
  GROUP BY cga33.cg33_dtbaixa, 3, cga_acesso.nome
UNION 
 SELECT count(cga68.cg68_dtbaixa) AS "QTDE", cga68.cg68_dtbaixa AS "DATA", 1 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga68
   JOIN cga_acesso ON cga68.cg68_codusu = cga_acesso.codigo
  GROUP BY cga68.cg68_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga75.cg75_dtbaixa) AS "QTDE", cga75.cg75_dtbaixa AS "DATA", 2 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga75
   JOIN cga_acesso ON cga75.cg75_codusu = cga_acesso.codigo
  GROUP BY cga75.cg75_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga100.cg100_dtbaixa) AS "QTDE", cga100.cg100_dtbaixa AS "DATA", 3 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga100
   JOIN cga_acesso ON cga100.cg100_codusu::text = cga_acesso.codigo::text
  GROUP BY cga100.cg100_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga120.cg120_dtbaixa) AS "QTDE", cga120.cg120_dtbaixa AS "DATA", 4 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga120
   JOIN cga_acesso ON cga120.cg120_codusu = cga_acesso.codigo
  GROUP BY cga120.cg120_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga130.cg130_dtbaixa) AS "QTDE", cga130.cg130_dtbaixa AS "DATA", 5 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga130
   JOIN cga_acesso ON cga130.cg130_codusu = cga_acesso.codigo
  GROUP BY cga130.cg130_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga70.cg70_dtbaixa) AS "QTDE", cga70.cg70_dtbaixa AS "DATA", 6 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga70
   JOIN cga_acesso ON cga70.cg70_codusu = cga_acesso.codigo
  GROUP BY cga70.cg70_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga69.cg69_dtbaixa) AS "QTDE", cga69.cg69_dtbaixa AS "DATA", 7 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga69
   JOIN cga_acesso ON cga69.cg69_codusu::text = cga_acesso.nome::text
  GROUP BY cga69.cg69_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga76.cg76_dtentr) AS "QTDE", cga76.cg76_dtentr AS "DATA", 8 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga76
   JOIN cga_acesso ON cga76.cg76_codusu_dig = cga_acesso.codigo
  GROUP BY cga76.cg76_dtentr, 3, cga_acesso.nome)
UNION 
 SELECT count(cga76.cg76_dtsai) AS "QTDE", cga76.cg76_dtsai AS "DATA", 9 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga76
   JOIN cga_acesso ON cga76.cg76_codusu = cga_acesso.codigo
  GROUP BY cga76.cg76_dtsai, 3, cga_acesso.nome)
UNION 
 SELECT count(cga67.cg67_dtbaixa) AS "QTDE", cga67.cg67_dtbaixa AS "DATA", 10 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga67
   JOIN cga_acesso ON cga67.cg67_codusu = cga_acesso.codigo
  GROUP BY cga67.cg67_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga140.cg140_dtcad) AS "QTDE", cga140.cg140_dtcad AS "DATA", 11 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga140
   JOIN cga_acesso ON cga140.cg140_codusu = cga_acesso.codigo
  GROUP BY cga140.cg140_dtcad, 3, cga_acesso.nome)
UNION 
 SELECT count(cga140.cg140_dtbxa) AS "QTDE", cga140.cg140_dtbxa AS "DATA", 12 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga140
   JOIN cga_acesso ON cga140.cg140_usubxa = cga_acesso.codigo
  GROUP BY cga140.cg140_dtbxa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga145.cg145_dtsai) AS "QTDE", cga145.cg145_dtsai AS "DATA", 13 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga145
   FULL JOIN cga_acesso ON cga145.cg145_codususai = cga_acesso.codigo
  GROUP BY cga145.cg145_dtsai, 3, cga_acesso.nome)
UNION 
 SELECT count(cgafatcrtcrd.cgfatcrtcrd_dtbaixa) AS "QTDE", cgafatcrtcrd.cgfatcrtcrd_dtbaixa AS "DATA", 14 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cgafatcrtcrd
   JOIN cga_acesso ON cgafatcrtcrd.cgfatcrtcrd_codusu = cga_acesso.codigo
  GROUP BY cgafatcrtcrd.cgfatcrtcrd_dtbaixa, 3, cga_acesso.nome)
UNION 
 SELECT count(cga78.cg78_dtbaixa) AS "QTDE", cga78.cg78_dtbaixa AS "DATA", 15 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga78
   JOIN cga_acesso ON cga78.cg78_codusu = cga_acesso.codigo
  GROUP BY cga78.cg78_dtbaixa, 3, cga_acesso.nome
UNION 
 SELECT count(cga035.cg035_dtbaixa) AS "QTDE", cga035.cg035_dtbaixa AS "DATA", 16 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga035
   JOIN cga_acesso ON cga035.cg035_codusu = cga_acesso.codigo
  GROUP BY cga035.cg035_dtbaixa, 3, cga_acesso.nome
  UNION 
 SELECT count(cga036.cg036_dtbaixa) AS "QTDE", cga036.cg036_dtbaixa AS "DATA", 17 AS "Tipo_Servico", cga_acesso.nome AS "Usuario"
   FROM cga036
   JOIN cga_acesso ON cga036.cg036_codusu = cga_acesso.codigo
  GROUP BY cga036.cg036_dtbaixa, 3, cga_acesso.nome
  ORDER BY 3;

ALTER TABLE relcons OWNER TO postgres;
GRANT ALL ON TABLE relcons TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE relcons TO ads;
select * from relcons where ("DATA" = '03/14/2008')