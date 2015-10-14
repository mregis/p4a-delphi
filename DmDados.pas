Unit DmDados;

interface

uses
  SysUtils,Windows, Messages, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZConnection, RLXLSFilter, RLPDFFilter, RLHTMLFilter, RLFilters,
  RLRichFilter, RpDefine, RpRave, RpCon, RpConDS, RpRender, RpRenderPDF, RpBase,
  RpSystem;

type
  TDm = class(TDataModule)
    Ads: TZConnection;
    SqlAux1: TZQuery;
    SqlCga06: TZQuery;
    SqlCga33: TZQuery;
    SqlCga20: TZQuery;
    DtsCga20: TDataSource;
    sqlcga_acesso: TZQuery;
    Dtscga_acesso: TDataSource;
    SqlCga75: TZQuery;
    DtsCga75: TDataSource;
    SqlCga75cg75_remes: TStringField;
    SqlCga75cg75_dup: TIntegerField;
    SqlCga75cg75_dtext: TDateField;
    SqlCga75cg75_dtbaixa: TDateField;
    SqlCga75cg75_codbaixa: TStringField;
    SqlCga75cg75_dtret: TDateField;
    SqlCga75cg75_caixa: TLargeintField;
    SqlCga75cg75_codusu: TIntegerField;
    SqlCga75cg75_codag: TStringField;
    SqlCga75cg75_conta: TStringField;
    SqlCga75cg75_tipo: TStringField;
    SqlCga33cg33_remes: TStringField;
    SqlCga33cg33_dup: TIntegerField;
    SqlCga33cg33_dtext: TDateField;
    SqlCga33cg33_dtbaixa: TDateField;
    SqlCga33cg33_codbaixa: TStringField;
    SqlCga33cg33_dtret: TDateField;
    SqlCga33cg33_caixa: TLargeintField;
    SqlCga33cg33_codusu: TIntegerField;
    SqlCga33cg33_codag: TStringField;
    SqlCga33cg33_dataenv: TDateField;
    SqlCga10: TZQuery;
    SqlCga11: TZQuery;
    SqlCga11cg11_descricao: TStringField;
    SqlCga11cg11_sigla: TStringField;
    SqlCga11cg11_cod: TIntegerField;
    DtsCga10: TDataSource;
    DtsCga11: TDataSource;
    Cep: TZConnection;
    SqlCep: TZQuery;
    SqlCeplogradouro: TStringField;
    SqlCepbairro: TStringField;
    SqlCeplocalidade: TStringField;
    SqlCepuf: TStringField;
    SqlCga10cg10_codcli: TIntegerField;
    SqlCga10cg10_codveiculo: TIntegerField;
    SqlCga10cg10_pnome: TStringField;
    SqlCga10cg10_snome: TStringField;
    SqlCga10cg10_endereco: TStringField;
    SqlCga10cg10_bairro: TStringField;
    SqlCga10cg10_cidade: TStringField;
    SqlCga10cg10_uf: TStringField;
    SqlCga10cg10_cep: TStringField;
    SqlCga10cg10_pais: TStringField;
    SqlCga10cg10_sexo: TStringField;
    SqlCga10cg10_codusu: TIntegerField;
    SqlCga10cg10_dtdig: TDateField;
    SqlCga10cg10_caixa: TLargeintField;
    SqlCga42: TZQuery;
    SqlAgBrad: TZQuery;
    SqlCga40: TZQuery;
    DtsCga42: TDataSource;
    DtsAgBrad: TDataSource;
    DtsCga40: TDataSource;
    SqlCga42cg42_ncont: TStringField;
    SqlCga42cg42_codsuc: TStringField;
    SqlCga42cg42_qtdtb: TLargeintField;
    SqlCga42cg42_qtdig: TLargeintField;
    SqlCga42cg42_erros: TLargeintField;
    SqlCga42column: TFloatField;
    SqlCga40cg40_remes: TIntegerField;
    SqlCga40cg40_nome: TStringField;
    SqlCga40cg40_ende: TStringField;
    SqlCga40cg40_compl: TStringField;
    SqlCga40cg40_num: TStringField;
    SqlCga40cg40_bairro: TStringField;
    SqlCga40cg40_cid: TStringField;
    SqlCga40cg40_uf: TStringField;
    SqlCga40cg40_cep: TStringField;
    SqlCga40cg40_data: TDateField;
    SqlCga40cg40_codusu: TIntegerField;
    SqlCga40cg40_ncont: TStringField;
    SqlCga40cg40_nsuc: TStringField;
    SqlCga40cg40_coderro: TLargeintField;
    SqlCga40cg40_ordimp: TLargeintField;
    SqlCga44: TZQuery;
    DtsCga44: TDataSource;
    SqlCga44cg40_nome: TStringField;
    SqlCga44cg40_ende: TStringField;
    SqlCga44cg40_compl: TStringField;
    SqlCga44cg40_num: TStringField;
    SqlCga44cg40_bairro: TStringField;
    SqlCga44cg40_cid: TStringField;
    SqlCga44cg40_uf: TStringField;
    SqlCga44cg40_cep: TStringField;
    SqlCga44cg40_nsuc: TStringField;
    SqlCga44cg40_remes: TIntegerField;
    SqlAux2: TZQuery;
    SqlCga10cg10_internet: TStringField;
    SqlCga10cg10_outros: TStringField;
    SqlCga10cg10_email: TStringField;
    RLRichFilter1: TRLRichFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLPDFFilter1: TRLPDFFilter;
    RLXLSFilter1: TRLXLSFilter;
    SqlRel: TZQuery;
    DtsRel: TDataSource;
    sqlcga_acessonome: TStringField;
    sqlcga_acessonivel: TIntegerField;
    sqlcga_acessosenha: TStringField;
    sqlcga_acessocodigo: TIntegerField;
    SqlCga14: TZQuery;
    DtsCga14: TDataSource;
    SqlCga14cg14_codag: TStringField;
    SqlCga14cg14_nome: TStringField;
    SqlCga14cg14_uf: TStringField;
    SqlCga07: TZQuery;
    DtsCga07: TDataSource;
    SqlCga07cg07_edicao: TStringField;
    SqlCga07cg07_codedicao: TIntegerField;
    SqlCga07cg07_dtedicao: TDateField;
    SqlCga107: TZQuery;
    SqlCga105: TZQuery;
    DtsCga105: TDataSource;
    dtsCga107: TDataSource;
    SqlCga105numedi: TIntegerField;
    SqlCga105dtedi: TDateField;
    sqlhora: TZQuery;
    SqlRelCartao: TZQuery;
    SqlRelCartaonome: TStringField;
    SqlRelCartaocodigo: TIntegerField;
    SqlRelCartaocg50_data: TDateField;
    SqlRelCartaocg50_horaini: TTimeField;
    SqlRelCartaocg50_horafin: TTimeField;
    SqlRelCartaocolumn: TStringField;
    DstSqlRelCartao: TDataSource;
    SqlCga108: TZQuery;
    dtsCga108: TDataSource;
    SqlCga108codfilial: TFloatField;
    SqlCga108cepini: TStringField;
    SqlCga108cepfim: TStringField;
    SqlCga109: TZQuery;
    DtsCga109: TDataSource;
    SqlCga106: TZQuery;
    DtsCga106: TDataSource;
    DtsCgaLojadivi: TDataSource;
    SqlCgaLojaDivi: TZQuery;
    DtsCgaMakro: TDataSource;
    SqlCgaMakro: TZQuery;
    SqlCgaLojaDivicodloja: TFloatField;
    SqlCgaLojaDivicoddiv: TStringField;
    SqlCgaLojaDiviendereco: TStringField;
    SqlCgaLojaDivicidade: TStringField;
    SqlCgaLojaDiviuf: TStringField;
    SqlCgaLojaDivicodloja_1: TFloatField;
    SqlCgaLojaDividescricao: TStringField;
    SqlCga107nomefilial: TStringField;
    SqlCga107codfilial: TFloatField;
    SqlCgaMakromkcod: TStringField;
    SqlCgaMakromkempresa: TStringField;
    SqlCgaMakromkendereco: TStringField;
    SqlCgaMakromkcomplemento: TStringField;
    SqlCgaMakromkcep: TStringField;
    SqlCgaMakromkcep1: TStringField;
    SqlCgaMakromkcodfilial: TFloatField;
    SqlCgaMakromkcoddiv: TStringField;
    SqlCgaMakromkcodloja: TFloatField;
    SqlCgaMakromkedicao: TFloatField;
    SqlCga109codloja: TFloatField;
    SqlCga109descricao: TStringField;
    SqlCga106codloja: TFloatField;
    SqlCga106coddiv: TStringField;
    SqlCga106endereco: TStringField;
    SqlCga106cidade: TStringField;
    SqlCga106uf: TStringField;
    Sqlcga111check: TZQuery;
    DtSCga111check: TDataSource;
    Sqlcga111checkchloja: TFloatField;
    Sqlcga111checkchdivisao: TStringField;
    Sqlcga111checkchedicao: TIntegerField;
    sqlcadcli: TZQuery;
    DtsCadcli: TDataSource;
    sqlcadclinome: TStringField;
    sqlcadcliendereco: TStringField;
    sqlcadclicidade: TStringField;
    sqlcadclicep: TStringField;
    sqlcadcliestado: TStringField;
    sqlcadclicodcli: TIntegerField;
    sqlcadclibairro: TStringField;
    SqlCadcliPrint: TZQuery;
    DtscadcliPrint: TDataSource;
    SqlCadcliPrintnome: TStringField;
    SqlCadcliPrintendereco: TStringField;
    SqlCadcliPrintcidade: TStringField;
    SqlCadcliPrintcep: TStringField;
    SqlCadcliPrintestado: TStringField;
    SqlCadcliPrintcodcli: TIntegerField;
    SqlCadcliPrintbairro: TStringField;
    sqlhoratimetz: TStringField;
    sqlhoradate: TDateField;
    SqlCga20cg20_codbaixa: TStringField;
    SqlCga20cg20_descricao: TStringField;
    SqlCga20cg20_codbrad: TStringField;
    SqlCga120: TZQuery;
    DtSCga120: TDataSource;
    SqlCga120cg120_remes: TStringField;
    SqlCga120cg120_dup: TIntegerField;
    SqlCga120cg120_dtext: TDateField;
    SqlCga120cg120_dtbaixa: TDateField;
    SqlCga120cg120_codbaixa: TStringField;
    SqlCga120cg120_dtret: TDateField;
    SqlCga120cg120_caixa: TLargeintField;
    SqlCga120cg120_codusu: TIntegerField;
    SqlCga120cg120_dtenv: TDateField;
    SqlCga130: TZQuery;
    DtSCga130: TDataSource;
    SqlCga130cg130_remes: TStringField;
    SqlCga130cg130_dup: TIntegerField;
    SqlCga130cg130_dtext: TDateField;
    SqlCga130cg130_dtbaixa: TDateField;
    SqlCga130cg130_codbaixa: TStringField;
    SqlCga130cg130_dtret: TDateField;
    SqlCga130cg130_caixa: TLargeintField;
    SqlCga130cg130_codusu: TIntegerField;
    SqlCga130cg130_dtenv: TDateField;
    ZROQToken: TZReadOnlyQuery;
    DtSToken: TDataSource;
    ZROQTokenToken: TStringField;
    ZROQTokenAgncia: TStringField;
    ZROQTokenDTB: TStringField;
    ZROQTokenData: TDateField;
    ZROQTokenLote: TStringField;
    ZROQTokenUsurio: TStringField;
    ZROQTokExc: TZReadOnlyQuery;
    DtSTokExc: TDataSource;
    ZROQTokExcAgencia: TStringField;
    ZROQTokExcDTB: TStringField;
    ZROQTokExcInicial: TMemoField;
    ZROQTokExcFinal: TMemoField;
    ZROQTokExcQtde: TLargeintField;
    SqlSdx1: TZQuery;
    SqlSdx2: TZQuery;
    DtsSdx2: TDataSource;
    SqlSdxEct: TZQuery;
    SqlSdxEcttbsdxect_num: TStringField;
    SqlSdxEcttbsdx_use: TStringField;
    DTSsdxEtc: TDataSource;
    SqlSdx2sdx_codcli: TFloatField;
    SqlSdx2sdx_idcli: TStringField;
    SqlSdx2sdx_siglaobj: TStringField;
    SqlSdx2sdx_numobj: TFloatField;
    SqlSdx2sdx_paisorigem: TStringField;
    SqlSdx2sdx_codoperacao: TStringField;
    SqlSdx2sdx_numobj3: TStringField;
    SqlSdx2sdx_nomdest: TStringField;
    SqlSdx2sdx_endedest: TStringField;
    SqlSdx2sdx_cidade: TStringField;
    SqlSdx2sdx_uf: TStringField;
    SqlSdx2sdx_cep: TStringField;
    SqlSdx2sdx_numseqarq: TFloatField;
    SqlSdx2sdx_numseqreg: TFloatField;
    SqlSdx2sdx_dtcarga: TDateField;
    SqlSdx2sdx_seqcarga: TIntegerField;
    SqlSdx2sdx_numobj2: TStringField;
    SqlSdx2sdx_cepnet: TStringField;
    SqlSdx2sdx_numobj1: TStringField;
    SqlSdx2sdx_numobj4: TStringField;
    SqlSdx2sdx_numobj5: TStringField;
    ZROQTokenLido: TZReadOnlyQuery;
    ZROQTokenLidoToken: TStringField;
    ZROQTokenLidoCaixa: TLargeintField;
    ZROQTokenLidoLido: TDateField;
    ZROQTokenLidoAgncia: TStringField;
    ZROQTokenLidoDTB: TStringField;
    ZROQTokenLidoData: TDateField;
    ZROQTokenLidoLote: TStringField;
    ZROQTokenLidoUsurio: TStringField;
    DtSTokenLido: TDataSource;
    SqlCga78: TZQuery;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    DateField1: TDateField;
    DateField2: TDateField;
    StringField2: TStringField;
    DateField3: TDateField;
    LargeintField1: TLargeintField;
    IntegerField2: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DtSCga78: TDataSource;
    ZRResumo: TZReadOnlyQuery;
    DtSResumo: TDataSource;
    ZRResumomotivo: TStringField;
    ZRResumotipo_serv_01: TFloatField;
    ZRResumotipo_serv_02: TFloatField;
    ZRResumotipo_serv_03: TFloatField;
    ZRResumotipo_serv_04: TFloatField;
    ZRResumotipo_serv_05: TFloatField;
    ZRResumotipo_serv_06: TFloatField;
    ZRResumotipo_serv_07: TFloatField;
    ZRResumotipo_serv_08: TFloatField;
    ZRResumotipo_serv_09: TFloatField;
    ZRResumotipo_serv_10: TFloatField;
    ZRResumotipo_serv_11: TFloatField;
    ZRResumotipo_serv_12: TFloatField;
    ZRResumotipo_serv_13: TFloatField;
    SqlServNLido: TZQuery;
    DtSServNLido: TDataSource;
    DtSServico: TDataSource;
    SqlServico: TZQuery;
    DtSqlAux2: TDataSource;
    SqlTotNLido: TZQuery;
    DtSTotNLido: TDataSource;
    SqlTotNLidoQtde: TFloatField;
    SqlTotNLidoData: TDateField;
    SqlTotNLidoTipo: TIntegerField;
    SqlTotNLidoServio: TStringField;
    ZRResumotipo_serv_14: TFloatField;
    ZRResumotipo_serv_15: TFloatField;
    ZOQListaToken: TZReadOnlyQuery;
    DtSListaToken: TDataSource;
    ZOQListaTokencg76_dtsai: TDateField;
    ZOQListaTokencg76_ag: TStringField;
    ZOQListaTokencg76_remes: TStringField;
    ZOQListaTokencg76_dtb: TStringField;
    ZOQListaTokencg76_numlote: TStringField;
    ZOQListaTokencg20_descricao: TStringField;
    ZOQListaTokencg76_tipocli: TIntegerField;
    SqlSdx3: TZQuery;
    DtsSdx3: TDataSource;
    RvRelatorios: TRvProject;
    RvRenderPDF1: TRvRenderPDF;
    SqlSdxServ: TZQuery;
    DtSSdxServ: TDataSource;
    SqlTbBradDeptos: TZQuery;
    DtSTbBradDeptos: TDataSource;
    SqlTbBradDeptosjuncao: TIntegerField;
    SqlTbBradDeptosdepto: TStringField;
    SqlTbBradDeptoscnpj: TStringField;
    SqlTbBradDeptosender: TStringField;
    SqlTbBradDeptosbairro: TStringField;
    SqlTbBradDeptoscep: TStringField;
    SqlTbBradDeptoscidade: TStringField;
    SqlTbBradDeptosuf: TStringField;
    SqlTbBradDeptostel: TStringField;
    SqlTbBradDeptosramal: TStringField;
    SqlTbBradDeptosfax: TStringField;
    SqlTbBradDeptosregiao: TStringField;
    SqlTbBradDeptosempresa: TStringField;
    SqlSdx4: TZQuery;
    DtSSdx4: TDataSource;
    SqlSdx4sdx_tpreg: TFloatField;
    SqlSdx4sdx_codcli: TFloatField;
    SqlSdx4sdx_idcli: TStringField;
    SqlSdx4sdx_siglaobj: TStringField;
    SqlSdx4sdx_numobj: TFloatField;
    SqlSdx4sdx_paisorigem: TStringField;
    SqlSdx4sdx_codoperacao: TStringField;
    SqlSdx4sdx_numobj4: TStringField;
    SqlSdx4sdx_nomdest: TStringField;
    SqlSdx4sdx_endedest: TStringField;
    SqlSdx4sdx_cidade: TStringField;
    SqlSdx4sdx_uf: TStringField;
    SqlSdx4sdx_cep: TStringField;
    SqlSdx4sdx_numseqarq: TFloatField;
    SqlSdx4sdx_numseqreg: TStringField;
    SqlSdx4sdx_dtcarga: TDateField;
    SqlSdx4sdx_seqcarga: TLargeintField;
    SqlSdx4sdx_numobj2: TStringField;
    SqlSdx4sdx_cepnet: TStringField;
    SqlSdx4sdx_numobj1: TStringField;
    SqlSdx4sdx_codusu: TIntegerField;
    SqlSdx4sdx_valor: TFloatField;
    SqlSdx4sdx_peso: TFloatField;
    SqlSdx4sdx_numobj3: TStringField;
    SqlSdx4sdx_numobj5: TStringField;
    SqlSdx4sdx_qtde: TIntegerField;
    SqlSdx4sdx_tvalor: TFloatField;
    SqlSdx4sdx_valdec: TFloatField;
    SqlSdx3sdx_codcli: TFloatField;
    SqlSdx3sdx_siglaobj: TStringField;
    SqlSdx3sdx_numobj: TFloatField;
    SqlSdx3sdx_paisorigem: TStringField;
    SqlSdx3sdx_codoperacao: TStringField;
    SqlSdx3sdx_numobj4: TStringField;
    SqlSdx3sdx_nomdest: TStringField;
    SqlSdx3sdx_endedest: TStringField;
    SqlSdx3sdx_cidade: TStringField;
    SqlSdx3sdx_uf: TStringField;
    SqlSdx3sdx_cep: TStringField;
    SqlSdx3sdx_numseqarq: TFloatField;
    SqlSdx3sdx_numseqreg: TStringField;
    SqlSdx3sdx_dtcarga: TDateField;
    SqlSdx3sdx_seqcarga: TLargeintField;
    SqlSdx3sdx_numobj2: TStringField;
    SqlSdx3sdx_cepnet: TStringField;
    SqlSdx3sdx_numobj1: TStringField;
    SqlSdx3sdx_valor: TFloatField;
    SqlSdx3sdx_peso: TFloatField;
    SqlSdx3sdx_qtde: TIntegerField;
    SqlSdx3sdx_tvalor: TFloatField;
    SqlSdx3sdx_valdec: TFloatField;
    SqlSdx3sdx_numobj5: TStringField;
    SqlAux4: TZQuery;
    DtSAux4: TDataSource;
    Sqltbbxasdx: TZQuery;
    DtStbbxasdx: TDataSource;
    Sqltbbxasdxbxasdx_codbxa: TIntegerField;
    Sqltbbxasdxbxasdx_dscbxa: TStringField;
    SqlSdx4sdx_dtentrega: TDateField;
    SqlSdx4sdx_dtenvio: TDateField;
    SqlSdx4sdx_nomrecebe: TStringField;
    SqlSdx4sdx_codbxa: TIntegerField;
    SqlSdx4sdx_codusu_bxa: TIntegerField;
    SqlSdx4sdx_dtbaixa: TDateField;
    SqlSdx4sdx_qtprod: TIntegerField;
    SqlSdx4sdx_dtarqret: TDateField;
    SqlSdx4sdx_dtmov: TDateField;
    SqlSdx4sdx_valar: TFloatField;
    SqlSdx4sdx_porc: TFloatField;
    SqlSdx4sdx_valmin: TFloatField;
    SqlSdx4sdx_difval: TFloatField;
    RvSystem1: TRvSystem;
    RvDtsSdx3: TRvDataSetConnection;
    SqlAgBradjuncao: TIntegerField;
    SqlAgBraddepto: TStringField;
    SqlAgBradcnpj: TStringField;
    SqlAgBradender: TStringField;
    SqlAgBradbairro: TStringField;
    SqlAgBradcep: TStringField;
    SqlAgBradcidade: TStringField;
    SqlAgBraduf: TStringField;
    SqlAgBradtel: TStringField;
    SqlAgBradramal: TStringField;
    SqlAgBradfax: TStringField;
    SqlAgBradregiao: TStringField;
    SqlAgBradempresa: TStringField;
    SqlSdx5: TZQuery;
    DtsSdx5: TDataSource;
    SqlSdx5sdx_codcli: TFloatField;
    SqlSdx5sdx_idcli: TStringField;
    SqlSdx5sdx_siglaobj: TStringField;
    SqlSdx5sdx_numobj: TFloatField;
    SqlSdx5sdx_paisorigem: TStringField;
    SqlSdx5sdx_codoperacao: TStringField;
    SqlSdx5sdx_numobj3: TStringField;
    SqlSdx5sdx_nomdest: TStringField;
    SqlSdx5sdx_endedest: TStringField;
    SqlSdx5sdx_cidade: TStringField;
    SqlSdx5sdx_uf: TStringField;
    SqlSdx5sdx_cep: TStringField;
    SqlSdx5sdx_numseqarq: TFloatField;
    SqlSdx5sdx_numseqreg: TFloatField;
    SqlSdx5sdx_dtcarga: TDateField;
    SqlSdx5sdx_seqcarga: TIntegerField;
    SqlSdx5sdx_numobj2: TStringField;
    SqlSdx5sdx_cepnet: TStringField;
    SqlSdx5sdx_numobj1: TStringField;
    SqlSdx5sdx_numobj4: TStringField;
    SqlSdx5sdx_numobj5: TStringField;
    SqlSdx5sdx_codusu: TIntegerField;
    SqlSdx5sdx_peso: TFloatField;
    SqlSdx5sdx_qtd: TIntegerField;
    SqlSdx5sdx_dtenvio: TDateField;
    SqlSdxServtbsdxserv_cod: TIntegerField;
    SqlSdxServtbsdxserv_prod: TIntegerField;
    SqlSdxServtbsdxserv_dsc: TStringField;
    SqlSdxServtbsdxserv_dtcad: TDateField;
    SqlSdxServtbsdxserv_usu: TIntegerField;
    SqlSdxServtbsdxserv_sigla: TStringField;
    SqlSdxServtbsdxserv_nrocto: TStringField;
    SqlSdxServtbsdxserv_crtpst: TStringField;
    SqlSdx4sdx_horaenvio: TTimeField;
    SqlSdx4sdx_bas: TFloatField;
    SqlSdx4sdx_cmp: TFloatField;
    SqlSdx4sdx_alt: TFloatField;
    SqlSdx4sdx_cobdest: TFloatField;
    SqlSdx4sdx_codcxa: TIntegerField;
    SqlServicotbsdxserv_cod: TIntegerField;
    SqlServicotbsdxserv_prod: TIntegerField;
    SqlServicotbsdxserv_dsc: TStringField;
    SqlServicotbsdxserv_dtcad: TDateField;
    SqlServicotbsdxserv_usu: TIntegerField;
    SqlServicotbsdxserv_sigla: TStringField;
    SqlServicotbsdxserv_nrocto: TStringField;
    SqlServicotbsdxserv_crtpst: TStringField;
    SqlServicotbsdxserv_txasrv: TFloatField;
    SqlAux3: TZQuery;
    SqlSdx4tbsdxserv_siglaproduto: TStringField;
    SqlSdx4tbsdxserv_produto: TStringField;
    SqlSdx4tbsdxserv_codprod: TIntegerField;
    SqlSdxServtbsdxserv_status: TSmallintField;
    SqlSdxServtbsdxserv_txasrv: TFloatField;
    SqlSdx6: TZQuery;
    DtsSdx6: TDataSource;
    SqlSdx6Lote: TLargeintField;
    SqlSdx6QtObjs: TLargeintField;
    SqlSdx6Dtfin: TDateField;
    SqlSdx6Dtini: TDateField;
    SqlSdx6Produto: TStringField;
    SqlSdx6CodProduto: TIntegerField;
    SqlSdx4bxasdx_dscbxa: TStringField;
    procedure DataModuleCreate(Sender: TObject);



  private
    { Private declarations }
  public
    conect:boolean;
    currdir,uni : string;
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

uses U_Func;

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
    currdir :=  GetCurrentDir;
    Ads.Connected :=  false;
    uni           := Trim(copy(procarqconf('Unidade'),10,50));
    Ads.Database  := Trim(copy(procarqconf('Banco'),10,50));
    Ads.HostName  := trim(copy(procarqconf('Host'),10,150));
    Ads.Port      := strtoint(Trim(copy(procarqconf('Porta'),10,50)));
    Ads.User      := Trim(copy(procarqconf('Usuario'),10,50));//+'res';;
    Ads.Password  := Trim(copy(procarqconf('Snh'),10,50));

//  Ads.Connected :=  false;
//  Ads.Database  :=  'dbads';
//  Ads.HostName  :=  '192.168.101.77';//'192.168.100.7';//
//  Ads.Password  :=  'ads!.!';
//  Ads.Port      :=  5432;
//  Ads.User      :=  'ads';
  try
    Ads.Connected :=  True;
    Ads.StartTransaction;
    conect        :=  true;
        // For�ando o DateStyle a ser sempre o mesmo, independente do
    // que foi configurado no servidor, devido a Bug da Lib Zeos
    SqlAux2.Close;
    SqlAux2.SQL.Clear;
    SqlAux2.SQL.Add(FORMAT('SET DATESTYLE TO %s', [QuotedStr('ISO, DMY')]));
    SqlAux2.Open;

  Except on e: exception do
    begin
      Ads.Rollback;
      conect  :=  false;
    end;
  end;
end;

end.
