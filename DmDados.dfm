object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 984
  Width = 1087
  object Ads: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    ClientCodepage = 'UTF8'
    Properties.Strings = (
      'codepage=UTF8'
      'controls_cp=GET_ACP'
      'AutoEncodeStrings=ON')
    Port = 5432
    Database = 'dbads'
    User = 'ads'
    Password = 'ads!.!'
    Protocol = 'postgresql-9'
    Left = 30
    Top = 16
  end
  object SqlAux1: TZQuery
    Connection = Ads
    Params = <>
    Left = 30
    Top = 139
  end
  object SqlCga06: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga06')
    Params = <>
    Left = 284
    Top = 139
  end
  object SqlCga33: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga33')
    Params = <>
    Left = 371
    Top = 139
    object SqlCga33cg33_remes: TStringField
      FieldName = 'cg33_remes'
      Size = 22
    end
    object SqlCga33cg33_dup: TIntegerField
      FieldName = 'cg33_dup'
    end
    object SqlCga33cg33_dtext: TDateField
      FieldName = 'cg33_dtext'
    end
    object SqlCga33cg33_dtbaixa: TDateField
      FieldName = 'cg33_dtbaixa'
    end
    object SqlCga33cg33_codbaixa: TStringField
      FieldName = 'cg33_codbaixa'
      Size = 3
    end
    object SqlCga33cg33_dtret: TDateField
      FieldName = 'cg33_dtret'
    end
    object SqlCga33cg33_caixa: TLargeintField
      FieldName = 'cg33_caixa'
    end
    object SqlCga33cg33_codusu: TIntegerField
      FieldName = 'cg33_codusu'
    end
    object SqlCga33cg33_codag: TStringField
      FieldName = 'cg33_codag'
      Size = 10
    end
    object SqlCga33cg33_dataenv: TDateField
      FieldName = 'cg33_dataenv'
    end
  end
  object SqlCga20: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga20 order by cg20_descricao')
    Params = <>
    Left = 30
    Top = 303
    object SqlCga20cg20_codbaixa: TStringField
      FieldName = 'cg20_codbaixa'
      Required = True
      Size = 3
    end
    object SqlCga20cg20_descricao: TStringField
      FieldName = 'cg20_descricao'
      Size = 35
    end
    object SqlCga20cg20_codbrad: TStringField
      FieldName = 'cg20_codbrad'
      Required = True
      Size = 2
    end
  end
  object DtsCga20: TDataSource
    DataSet = SqlCga20
    Left = 104
    Top = 303
  end
  object sqlcga_acesso: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga_acesso')
    Params = <>
    Left = 574
    Top = 358
    object sqlcga_acessonome: TStringField
      FieldName = 'nome'
      Size = 14
    end
    object sqlcga_acessonivel: TIntegerField
      FieldName = 'nivel'
    end
    object sqlcga_acessosenha: TStringField
      FieldName = 'senha'
      Size = 10
    end
    object sqlcga_acessocodigo: TIntegerField
      FieldName = 'codigo'
    end
  end
  object Dtscga_acesso: TDataSource
    DataSet = sqlcga_acesso
    Left = 661
    Top = 358
  end
  object SqlCga75: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga75')
    Params = <>
    Left = 200
    Top = 303
    object SqlCga75cg75_remes: TStringField
      FieldName = 'cg75_remes'
    end
    object SqlCga75cg75_dup: TIntegerField
      FieldName = 'cg75_dup'
    end
    object SqlCga75cg75_dtext: TDateField
      FieldName = 'cg75_dtext'
    end
    object SqlCga75cg75_dtbaixa: TDateField
      FieldName = 'cg75_dtbaixa'
    end
    object SqlCga75cg75_codbaixa: TStringField
      FieldName = 'cg75_codbaixa'
      Size = 3
    end
    object SqlCga75cg75_dtret: TDateField
      FieldName = 'cg75_dtret'
    end
    object SqlCga75cg75_caixa: TLargeintField
      FieldName = 'cg75_caixa'
    end
    object SqlCga75cg75_codusu: TIntegerField
      FieldName = 'cg75_codusu'
    end
    object SqlCga75cg75_codag: TStringField
      FieldName = 'cg75_codag'
      Size = 10
    end
    object SqlCga75cg75_conta: TStringField
      FieldName = 'cg75_conta'
      Size = 10
    end
    object SqlCga75cg75_tipo: TStringField
      FieldName = 'cg75_tipo'
      Size = 4
    end
  end
  object DtsCga75: TDataSource
    DataSet = SqlCga75
    Left = 283
    Top = 303
  end
  object SqlCga10: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga10  order by cg10_codcli')
    Params = <>
    Left = 30
    Top = 358
    object SqlCga10cg10_codcli: TIntegerField
      FieldName = 'cg10_codcli'
    end
    object SqlCga10cg10_codveiculo: TIntegerField
      FieldName = 'cg10_codveiculo'
    end
    object SqlCga10cg10_pnome: TStringField
      FieldName = 'cg10_pnome'
      Size = 30
    end
    object SqlCga10cg10_snome: TStringField
      FieldName = 'cg10_snome'
      Size = 30
    end
    object SqlCga10cg10_endereco: TStringField
      FieldName = 'cg10_endereco'
      Size = 80
    end
    object SqlCga10cg10_bairro: TStringField
      FieldName = 'cg10_bairro'
      Size = 50
    end
    object SqlCga10cg10_cidade: TStringField
      FieldName = 'cg10_cidade'
      Size = 50
    end
    object SqlCga10cg10_uf: TStringField
      FieldName = 'cg10_uf'
      Size = 2
    end
    object SqlCga10cg10_cep: TStringField
      FieldName = 'cg10_cep'
      Size = 9
    end
    object SqlCga10cg10_pais: TStringField
      FieldName = 'cg10_pais'
    end
    object SqlCga10cg10_sexo: TStringField
      FieldName = 'cg10_sexo'
      Size = 1
    end
    object SqlCga10cg10_codusu: TIntegerField
      FieldName = 'cg10_codusu'
    end
    object SqlCga10cg10_dtdig: TDateField
      FieldName = 'cg10_dtdig'
    end
    object SqlCga10cg10_caixa: TLargeintField
      FieldName = 'cg10_caixa'
    end
    object SqlCga10cg10_internet: TStringField
      FieldName = 'cg10_internet'
      Size = 1
    end
    object SqlCga10cg10_outros: TStringField
      FieldName = 'cg10_outros'
      Size = 50
    end
    object SqlCga10cg10_email: TStringField
      FieldName = 'cg10_email'
      Size = 70
    end
  end
  object SqlCga11: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga11')
    Params = <>
    Left = 389
    Top = 195
    object SqlCga11cg11_descricao: TStringField
      FieldName = 'cg11_descricao'
    end
    object SqlCga11cg11_sigla: TStringField
      FieldName = 'cg11_sigla'
      Size = 5
    end
    object SqlCga11cg11_cod: TIntegerField
      FieldName = 'cg11_cod'
    end
  end
  object DtsCga10: TDataSource
    DataSet = SqlCga10
    Left = 104
    Top = 358
  end
  object DtsCga11: TDataSource
    DataSet = SqlCga11
    Left = 465
    Top = 195
  end
  object Cep: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    AutoEncodeStrings = False
    ReadOnly = True
    HostName = '192.168.100.3'
    Port = 5432
    Database = 'dbcep'
    User = 'cartoriores'
    Password = 'cart6539'
    Protocol = 'postgresql-7.4'
    Left = 32
    Top = 872
  end
  object SqlCep: TZQuery
    Connection = Cep
    SQL.Strings = (
      'select logradouros.logradouro,'
      'bairros.bairro,'
      'localidades.localidade,'
      'ufs.uf'
      'from logradouros'
      'inner join bairros on bairros.dne = logradouros.dnebairroinicial'
      
        'inner join localidades on bairros.dnelocalidade = localidades.dn' +
        'e'
      'inner join  ufs on ufs.dne = localidades.dneuf'
      'where logradouros.cep = '#39'06333060'#39)
    Params = <>
    Left = 32
    Top = 923
    object SqlCeplogradouro: TStringField
      FieldName = 'logradouro'
      Size = 72
    end
    object SqlCepbairro: TStringField
      FieldName = 'bairro'
      Size = 72
    end
    object SqlCeplocalidade: TStringField
      FieldName = 'localidade'
      Size = 72
    end
    object SqlCepuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
  object SqlCga42: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select cg42_ncont,'
      'cg42_codsuc,'
      'cg42_qtdtb,'
      'cg42_qtdig,'
      'cg42_erros,'
      'sum (cg42_erros + cg42_qtdig) - cg42_qtdtb'
      'from cga42'
      'group by cg42_ncont,cg42_codsuc,cg42_qtdtb,'
      'cg42_qtdig,'
      'cg42_erros'
      'order by cg42_ncont')
    Params = <>
    Left = 30
    Top = 413
    object SqlCga42cg42_ncont: TStringField
      FieldName = 'cg42_ncont'
      Required = True
      Size = 10
    end
    object SqlCga42cg42_codsuc: TStringField
      FieldName = 'cg42_codsuc'
      Size = 5
    end
    object SqlCga42cg42_qtdtb: TLargeintField
      FieldName = 'cg42_qtdtb'
    end
    object SqlCga42cg42_qtdig: TLargeintField
      FieldName = 'cg42_qtdig'
    end
    object SqlCga42cg42_erros: TLargeintField
      FieldName = 'cg42_erros'
    end
    object SqlCga42column: TFloatField
      FieldName = '?column?'
    end
  end
  object SqlAgBrad: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from tbbraddptos')
    Params = <>
    Left = 389
    Top = 413
    object SqlAgBradjuncao: TIntegerField
      FieldName = 'juncao'
    end
    object SqlAgBraddepto: TStringField
      FieldName = 'depto'
      Size = 50
    end
    object SqlAgBradcnpj: TStringField
      FieldName = 'cnpj'
      Size = 18
    end
    object SqlAgBradender: TStringField
      FieldName = 'ender'
      Size = 60
    end
    object SqlAgBradbairro: TStringField
      FieldName = 'bairro'
      Size = 30
    end
    object SqlAgBradcep: TStringField
      FieldName = 'cep'
      Size = 10
    end
    object SqlAgBradcidade: TStringField
      FieldName = 'cidade'
      Size = 30
    end
    object SqlAgBraduf: TStringField
      FieldName = 'uf'
      Size = 2
    end
    object SqlAgBradtel: TStringField
      FieldName = 'tel'
      Size = 40
    end
    object SqlAgBradramal: TStringField
      FieldName = 'ramal'
      Size = 10
    end
    object SqlAgBradfax: TStringField
      FieldName = 'fax'
      Size = 40
    end
    object SqlAgBradregiao: TStringField
      FieldName = 'regiao'
      Size = 50
    end
    object SqlAgBradempresa: TStringField
      FieldName = 'empresa'
      Size = 50
    end
  end
  object SqlCga40: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga40 order by cg40_remes')
    Params = <>
    Left = 389
    Top = 358
    object SqlCga40cg40_remes: TIntegerField
      FieldName = 'cg40_remes'
    end
    object SqlCga40cg40_nome: TStringField
      FieldName = 'cg40_nome'
      Size = 60
    end
    object SqlCga40cg40_ende: TStringField
      FieldName = 'cg40_ende'
      Size = 80
    end
    object SqlCga40cg40_compl: TStringField
      FieldName = 'cg40_compl'
      Size = 30
    end
    object SqlCga40cg40_num: TStringField
      FieldName = 'cg40_num'
      Size = 10
    end
    object SqlCga40cg40_bairro: TStringField
      FieldName = 'cg40_bairro'
      Size = 40
    end
    object SqlCga40cg40_cid: TStringField
      FieldName = 'cg40_cid'
      Size = 40
    end
    object SqlCga40cg40_uf: TStringField
      FieldName = 'cg40_uf'
      Size = 2
    end
    object SqlCga40cg40_cep: TStringField
      FieldName = 'cg40_cep'
      Size = 8
    end
    object SqlCga40cg40_data: TDateField
      FieldName = 'cg40_data'
    end
    object SqlCga40cg40_codusu: TIntegerField
      FieldName = 'cg40_codusu'
    end
    object SqlCga40cg40_ncont: TStringField
      FieldName = 'cg40_ncont'
      Size = 10
    end
    object SqlCga40cg40_nsuc: TStringField
      FieldName = 'cg40_nsuc'
      Size = 6
    end
    object SqlCga40cg40_coderro: TLargeintField
      FieldName = 'cg40_coderro'
    end
    object SqlCga40cg40_ordimp: TLargeintField
      FieldName = 'cg40_ordimp'
    end
  end
  object DtsCga42: TDataSource
    DataSet = SqlCga42
    Left = 104
    Top = 413
  end
  object DtsAgBrad: TDataSource
    DataSet = SqlAgBrad
    Left = 465
    Top = 413
  end
  object DtsCga40: TDataSource
    DataSet = SqlCga40
    Left = 465
    Top = 358
  end
  object SqlCga44: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga44')
    Params = <>
    Left = 200
    Top = 358
    object SqlCga44cg40_nome: TStringField
      FieldName = 'cg40_nome'
      Size = 60
    end
    object SqlCga44cg40_ende: TStringField
      FieldName = 'cg40_ende'
      Size = 80
    end
    object SqlCga44cg40_compl: TStringField
      FieldName = 'cg40_compl'
      Size = 30
    end
    object SqlCga44cg40_num: TStringField
      FieldName = 'cg40_num'
      Size = 10
    end
    object SqlCga44cg40_bairro: TStringField
      FieldName = 'cg40_bairro'
      Size = 40
    end
    object SqlCga44cg40_cid: TStringField
      FieldName = 'cg40_cid'
      Size = 40
    end
    object SqlCga44cg40_uf: TStringField
      FieldName = 'cg40_uf'
      Size = 2
    end
    object SqlCga44cg40_cep: TStringField
      FieldName = 'cg40_cep'
      Size = 8
    end
    object SqlCga44cg40_nsuc: TStringField
      FieldName = 'cg40_nsuc'
      Size = 6
    end
    object SqlCga44cg40_remes: TIntegerField
      FieldName = 'cg40_remes'
    end
  end
  object DtsCga44: TDataSource
    DataSet = SqlCga44
    Left = 283
    Top = 358
  end
  object SqlAux2: TZQuery
    Connection = Ads
    Params = <>
    Left = 30
    Top = 195
  end
  object RLRichFilter1: TRLRichFilter
    DisplayName = 'Formato RichText'
    Left = 545
    Top = 75
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 458
    Top = 75
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport v0.3.10e \251 Copyright '#169' 1999-2003 Fortes Inform'#225't' +
      'ica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 632
    Top = 75
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel'
    Left = 371
    Top = 75
  end
  object SqlRel: TZQuery
    Connection = Ads
    Params = <>
    Left = 30
    Top = 468
  end
  object DtsRel: TDataSource
    DataSet = SqlRel
    Left = 104
    Top = 468
  end
  object SqlCga14: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga14 order by cg14_codag')
    Params = <>
    Left = 574
    Top = 413
    object SqlCga14cg14_codag: TStringField
      FieldName = 'cg14_codag'
      Size = 10
    end
    object SqlCga14cg14_nome: TStringField
      FieldName = 'cg14_nome'
      Size = 40
    end
    object SqlCga14cg14_uf: TStringField
      FieldName = 'cg14_uf'
      Size = 2
    end
  end
  object DtsCga14: TDataSource
    DataSet = SqlCga14
    Left = 661
    Top = 413
  end
  object SqlCga07: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga107cadfilial')
    Params = <>
    Left = 200
    Top = 413
    object SqlCga07cg07_edicao: TStringField
      FieldName = 'cg07_edicao'
      Size = 50
    end
    object SqlCga07cg07_codedicao: TIntegerField
      FieldName = 'cg07_codedicao'
    end
    object SqlCga07cg07_dtedicao: TDateField
      FieldName = 'cg07_dtedicao'
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
  object DtsCga07: TDataSource
    DataSet = SqlCga07
    Left = 283
    Top = 413
  end
  object SqlCga107: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga107cadfilial order by codfilial')
    Params = <>
    Left = 389
    Top = 468
    object SqlCga107nomefilial: TStringField
      FieldName = 'nomefilial'
      Size = 35
    end
    object SqlCga107codfilial: TFloatField
      FieldName = 'codfilial'
    end
  end
  object SqlCga105: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga105cadedi')
    Params = <>
    Left = 200
    Top = 468
    object SqlCga105numedi: TIntegerField
      FieldName = 'numedi'
      Required = True
    end
    object SqlCga105dtedi: TDateField
      FieldName = 'dtedi'
    end
  end
  object DtsCga105: TDataSource
    DataSet = SqlCga105
    Left = 283
    Top = 468
  end
  object dtsCga107: TDataSource
    DataSet = SqlCga107
    Left = 465
    Top = 468
  end
  object sqlhora: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select current_time,current_date')
    Params = <>
    Left = 197
    Top = 139
    object sqlhoratimetz: TStringField
      FieldName = 'timetz'
      ReadOnly = True
      Size = 255
    end
    object sqlhoradate: TDateField
      FieldName = 'date'
      ReadOnly = True
    end
  end
  object SqlRelCartao: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select cga_acesso.nome, cga_acesso.codigo, cga50.cg50_data,'
      '  cga50.cg50_horaini, cga50.cg50_horafin,'
      '  (cga50.cg50_horafin - cga50.cg50_horaini) AS prazo'
      'FROM cga50'
      
        '    INNR JOIN cga_acesso ON cga_acesso.codigo = cga50.cg50_codus' +
        'u')
    Params = <>
    Left = 200
    Top = 250
    object SqlRelCartaonome: TStringField
      FieldName = 'nome'
      Size = 14
    end
    object SqlRelCartaocodigo: TIntegerField
      FieldName = 'codigo'
    end
    object SqlRelCartaocg50_data: TDateField
      FieldName = 'cg50_data'
    end
    object SqlRelCartaocg50_horaini: TTimeField
      FieldName = 'cg50_horaini'
    end
    object SqlRelCartaocg50_horafin: TTimeField
      FieldName = 'cg50_horafin'
    end
    object SqlRelCartaoPrazo: TTimeField
      FieldName = 'Prazo'
    end
  end
  object DstSqlRelCartao: TDataSource
    DataSet = SqlRelCartao
    Left = 283
    Top = 250
  end
  object SqlCga108: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga108cadfaixacep')
    Params = <>
    Left = 574
    Top = 468
    object SqlCga108codfilial: TFloatField
      FieldName = 'codfilial'
    end
    object SqlCga108cepini: TStringField
      FieldName = 'cepini'
      Size = 9
    end
    object SqlCga108cepfim: TStringField
      FieldName = 'cepfim'
      Size = 9
    end
  end
  object dtsCga108: TDataSource
    DataSet = SqlCga108
    Left = 661
    Top = 468
  end
  object SqlCga109: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga109cadloja')
    Params = <>
    Left = 200
    Top = 521
    object SqlCga109codloja: TFloatField
      FieldName = 'codloja'
      Required = True
    end
    object SqlCga109descricao: TStringField
      FieldName = 'descricao'
      Size = 34
    end
  end
  object DtsCga109: TDataSource
    DataSet = SqlCga109
    Left = 283
    Top = 521
  end
  object SqlCga106: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga106divisao')
    Params = <>
    Left = 389
    Top = 521
    object SqlCga106codloja: TFloatField
      FieldName = 'codloja'
      Required = True
    end
    object SqlCga106coddiv: TStringField
      FieldName = 'coddiv'
      Required = True
      Size = 5
    end
    object SqlCga106endereco: TStringField
      FieldName = 'endereco'
      Size = 40
    end
    object SqlCga106cidade: TStringField
      FieldName = 'cidade'
      Size = 30
    end
    object SqlCga106uf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
  object DtsCga106: TDataSource
    DataSet = SqlCga106
    Left = 465
    Top = 521
  end
  object DtsCgaLojadivi: TDataSource
    DataSet = SqlCgaLojaDivi
    Left = 661
    Top = 521
  end
  object SqlCgaLojaDivi: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga106divisao'
      
        'inner join cga109cadloja on cga109cadloja.codloja = cga106divisa' +
        'o.codloja')
    Params = <>
    Left = 574
    Top = 521
    object SqlCgaLojaDivicodloja: TFloatField
      FieldName = 'codloja'
    end
    object SqlCgaLojaDivicoddiv: TStringField
      FieldName = 'coddiv'
      Size = 5
    end
    object SqlCgaLojaDiviendereco: TStringField
      FieldName = 'endereco'
      Size = 40
    end
    object SqlCgaLojaDivicidade: TStringField
      FieldName = 'cidade'
      Size = 30
    end
    object SqlCgaLojaDiviuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
    object SqlCgaLojaDivicodloja_1: TFloatField
      FieldName = 'codloja_1'
    end
    object SqlCgaLojaDividescricao: TStringField
      FieldName = 'descricao'
      Size = 34
    end
  end
  object DtsCgaMakro: TDataSource
    DataSet = SqlCgaMakro
    Left = 104
    Top = 576
  end
  object SqlCgaMakro: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga110makro')
    Params = <>
    Left = 30
    Top = 576
    object SqlCgaMakromkcod: TStringField
      FieldName = 'mkcod'
      Size = 33
    end
    object SqlCgaMakromkempresa: TStringField
      FieldName = 'mkempresa'
      Size = 70
    end
    object SqlCgaMakromkendereco: TStringField
      FieldName = 'mkendereco'
      Size = 73
    end
    object SqlCgaMakromkcomplemento: TStringField
      FieldName = 'mkcomplemento'
      Size = 35
    end
    object SqlCgaMakromkcep: TStringField
      DisplayWidth = 35
      FieldName = 'mkcep'
      Size = 35
    end
    object SqlCgaMakromkcep1: TStringField
      DisplayWidth = 10
      FieldName = 'mkcep1'
      Size = 10
    end
    object SqlCgaMakromkcodfilial: TFloatField
      FieldName = 'mkcodfilial'
    end
    object SqlCgaMakromkcoddiv: TStringField
      FieldName = 'mkcoddiv'
      Size = 5
    end
    object SqlCgaMakromkcodloja: TFloatField
      FieldName = 'mkcodloja'
    end
    object SqlCgaMakromkedicao: TFloatField
      FieldName = 'mkedicao'
    end
  end
  object Sqlcga111check: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga111check')
    Params = <>
    Left = 200
    Top = 576
    object Sqlcga111checkchloja: TFloatField
      FieldName = 'chloja'
    end
    object Sqlcga111checkchdivisao: TStringField
      FieldName = 'chdivisao'
      Size = 5
    end
    object Sqlcga111checkchedicao: TIntegerField
      FieldName = 'chedicao'
    end
  end
  object DtSCga111check: TDataSource
    DataSet = Sqlcga111check
    Left = 283
    Top = 576
  end
  object sqlcadcli: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT * FROM CADCLI ORDER BY CODCLI')
    Params = <>
    Left = 389
    Top = 576
    object sqlcadclinome: TStringField
      FieldName = 'nome'
      Size = 65
    end
    object sqlcadcliendereco: TStringField
      FieldName = 'endereco'
      Size = 80
    end
    object sqlcadclicidade: TStringField
      FieldName = 'cidade'
      Size = 60
    end
    object sqlcadclicep: TStringField
      FieldName = 'cep'
      Size = 9
    end
    object sqlcadcliestado: TStringField
      FieldName = 'estado'
      Size = 2
    end
    object sqlcadclicodcli: TIntegerField
      FieldName = 'codcli'
      Required = True
    end
    object sqlcadclibairro: TStringField
      FieldName = 'bairro'
      Size = 45
    end
  end
  object DtsCadcli: TDataSource
    DataSet = sqlcadcli
    Left = 465
    Top = 576
  end
  object SqlCadcliPrint: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cadcli order by cep')
    Params = <>
    Left = 574
    Top = 576
    object SqlCadcliPrintnome: TStringField
      FieldName = 'nome'
      Size = 65
    end
    object SqlCadcliPrintendereco: TStringField
      FieldName = 'endereco'
      Size = 80
    end
    object SqlCadcliPrintcidade: TStringField
      FieldName = 'cidade'
      Size = 60
    end
    object SqlCadcliPrintcep: TStringField
      FieldName = 'cep'
      Size = 9
    end
    object SqlCadcliPrintestado: TStringField
      FieldName = 'estado'
      Size = 2
    end
    object SqlCadcliPrintcodcli: TIntegerField
      FieldName = 'codcli'
      Required = True
    end
    object SqlCadcliPrintbairro: TStringField
      FieldName = 'bairro'
      Size = 45
    end
  end
  object DtscadcliPrint: TDataSource
    DataSet = SqlCadcliPrint
    Left = 661
    Top = 576
  end
  object SqlCga120: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga120 limit 1')
    Params = <>
    Left = 574
    Top = 303
    object SqlCga120cg120_remes: TStringField
      FieldName = 'cg120_remes'
      Size = 17
    end
    object SqlCga120cg120_dup: TIntegerField
      FieldName = 'cg120_dup'
    end
    object SqlCga120cg120_dtext: TDateField
      FieldName = 'cg120_dtext'
    end
    object SqlCga120cg120_dtbaixa: TDateField
      FieldName = 'cg120_dtbaixa'
    end
    object SqlCga120cg120_codbaixa: TStringField
      FieldName = 'cg120_codbaixa'
      Required = True
      Size = 3
    end
    object SqlCga120cg120_dtret: TDateField
      FieldName = 'cg120_dtret'
    end
    object SqlCga120cg120_caixa: TLargeintField
      FieldName = 'cg120_caixa'
    end
    object SqlCga120cg120_codusu: TIntegerField
      FieldName = 'cg120_codusu'
      Required = True
    end
    object SqlCga120cg120_dtenv: TDateField
      FieldName = 'cg120_dtenv'
    end
  end
  object DtSCga120: TDataSource
    DataSet = SqlCga120
    Left = 661
    Top = 303
  end
  object SqlCga130: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga130 limit 1')
    Params = <>
    Left = 574
    Top = 250
    object SqlCga130cg130_remes: TStringField
      FieldName = 'cg130_remes'
      Size = 11
    end
    object SqlCga130cg130_dup: TIntegerField
      FieldName = 'cg130_dup'
    end
    object SqlCga130cg130_dtext: TDateField
      FieldName = 'cg130_dtext'
    end
    object SqlCga130cg130_dtbaixa: TDateField
      FieldName = 'cg130_dtbaixa'
    end
    object SqlCga130cg130_codbaixa: TStringField
      FieldName = 'cg130_codbaixa'
      Required = True
      Size = 3
    end
    object SqlCga130cg130_dtret: TDateField
      FieldName = 'cg130_dtret'
    end
    object SqlCga130cg130_caixa: TLargeintField
      FieldName = 'cg130_caixa'
    end
    object SqlCga130cg130_codusu: TIntegerField
      FieldName = 'cg130_codusu'
      Required = True
    end
    object SqlCga130cg130_dtenv: TDateField
      FieldName = 'cg130_dtenv'
    end
  end
  object DtSCga130: TDataSource
    DataSet = SqlCga130
    Left = 661
    Top = 250
  end
  object ZROQToken: TZReadOnlyQuery
    Connection = Ads
    SQL.Strings = (
      
        'select cg76_remes as "Token",cg76_ag as "Ag'#234'ncia",cg76_dtb as "D' +
        'TB",cg76_dtsai as "Data"'
      
        ',cg76_numlote as "Lote", cga_acesso.nome  as "Usu'#225'rio" from cga7' +
        '6'
      'full join cga_acesso on cga76.cg76_codusu = cga_acesso.codigo'
      'where cg76_numlote = '#39'000036'#39' limit 1')
    Params = <>
    Properties.Strings = (
      ''
      '')
    Left = 30
    Top = 250
    object ZROQTokenToken: TStringField
      FieldName = 'Token'
      Required = True
      Size = 25
    end
    object ZROQTokenAgncia: TStringField
      FieldName = 'Ag'#234'ncia'
      Size = 5
    end
    object ZROQTokenDTB: TStringField
      FieldName = 'DTB'
      Size = 15
    end
    object ZROQTokenData: TDateField
      FieldName = 'Data'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object ZROQTokenLote: TStringField
      FieldName = 'Lote'
      Size = 6
    end
    object ZROQTokenUsurio: TStringField
      FieldName = 'Usu'#225'rio'
      Size = 14
    end
  end
  object DtSToken: TDataSource
    DataSet = ZROQToken
    Left = 104
    Top = 250
  end
  object ZROQTokExc: TZReadOnlyQuery
    Connection = Ads
    SQL.Strings = (
      
        'select cg76_ag as "Agencia", cg76_dtb as "DTB",min(cg76_remes) a' +
        's "Inicial",'
      'max(cg76_remes) as "Final",'
      
        '(cast(max(substr(cg76_remes,1,9)) as inT8) - CAST(min(substr(cg7' +
        '6_remes,1,9))as int8)+1) as "Qtde" from cga76'
      'where'
      '--(cg76_dtsai between '#39'01/29/2006'#39' and '#39'02/01/2006'#39')'
      '--and'
      
        '(cg76_numlote = '#39'000038'#39') group by cg76_ag,cg76_dtb order by cg7' +
        '6_dtb')
    Params = <>
    Left = 574
    Top = 195
    object ZROQTokExcAgencia: TStringField
      FieldName = 'Agencia'
      Size = 5
    end
    object ZROQTokExcDTB: TStringField
      FieldName = 'DTB'
      Size = 15
    end
    object ZROQTokExcInicial: TMemoField
      FieldName = 'Inicial'
      ReadOnly = True
      BlobType = ftMemo
    end
    object ZROQTokExcFinal: TMemoField
      FieldName = 'Final'
      ReadOnly = True
      BlobType = ftMemo
    end
    object ZROQTokExcQtde: TLargeintField
      FieldName = 'Qtde'
      ReadOnly = True
    end
  end
  object DtSTokExc: TDataSource
    DataSet = ZROQTokExc
    Left = 661
    Top = 195
  end
  object SqlSdx1: TZQuery
    Connection = Ads
    Params = <>
    Left = 458
    Top = 139
  end
  object SqlSdx2: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,'
      
        'sdx_paisorigem,sdx_codoperacao,sdx_numobj3,sdx_nomdest,sdx_ended' +
        'est,sdx_cidade,'
      
        'sdx_uf,sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_seqca' +
        'rga,'
      'sdx_numobj2,sdx_cepnet,sdx_numobj1,sdx_numobj4 ,sdx_numobj5'
      'from tbsdx '
      ''
      'limit1'
      '')
    Params = <>
    Left = 30
    Top = 630
    object SqlSdx2sdx_codcli: TFloatField
      FieldName = 'sdx_codcli'
    end
    object SqlSdx2sdx_idcli: TStringField
      FieldName = 'sdx_idcli'
      Size = 2
    end
    object SqlSdx2sdx_siglaobj: TStringField
      FieldName = 'sdx_siglaobj'
      Size = 2
    end
    object SqlSdx2sdx_numobj: TFloatField
      FieldName = 'sdx_numobj'
    end
    object SqlSdx2sdx_paisorigem: TStringField
      FieldName = 'sdx_paisorigem'
      Size = 2
    end
    object SqlSdx2sdx_codoperacao: TStringField
      FieldName = 'sdx_codoperacao'
      Size = 4
    end
    object SqlSdx2sdx_numobj3: TStringField
      FieldName = 'sdx_numobj3'
    end
    object SqlSdx2sdx_nomdest: TStringField
      FieldName = 'sdx_nomdest'
      Size = 50
    end
    object SqlSdx2sdx_endedest: TStringField
      FieldName = 'sdx_endedest'
      Size = 50
    end
    object SqlSdx2sdx_cidade: TStringField
      FieldName = 'sdx_cidade'
      Size = 30
    end
    object SqlSdx2sdx_uf: TStringField
      FieldName = 'sdx_uf'
      Size = 2
    end
    object SqlSdx2sdx_cep: TStringField
      FieldName = 'sdx_cep'
      EditMask = '!99999\-999;0;0'
      Size = 8
    end
    object SqlSdx2sdx_numseqarq: TFloatField
      FieldName = 'sdx_numseqarq'
    end
    object SqlSdx2sdx_numseqreg: TFloatField
      FieldName = 'sdx_numseqreg'
    end
    object SqlSdx2sdx_dtcarga: TDateField
      FieldName = 'sdx_dtcarga'
    end
    object SqlSdx2sdx_seqcarga: TIntegerField
      FieldName = 'sdx_seqcarga'
    end
    object SqlSdx2sdx_numobj2: TStringField
      FieldName = 'sdx_numobj2'
      Size = 13
    end
    object SqlSdx2sdx_cepnet: TStringField
      FieldName = 'sdx_cepnet'
      Size = 11
    end
    object SqlSdx2sdx_numobj1: TStringField
      FieldName = 'sdx_numobj1'
      Size = 13
    end
    object SqlSdx2sdx_numobj4: TStringField
      FieldName = 'sdx_numobj4'
    end
    object SqlSdx2sdx_numobj5: TStringField
      FieldName = 'sdx_numobj5'
      Size = 9
    end
  end
  object DtsSdx2: TDataSource
    DataSet = SqlSdx2
    Left = 104
    Top = 630
  end
  object SqlSdxEct: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from tbsdx_ect')
    Params = <>
    Properties.Strings = (
      'select * from tbsdx_ect')
    Left = 389
    Top = 250
    object SqlSdxEcttbsdxect_num: TStringField
      FieldName = 'tbsdxect_num'
      Size = 9
    end
    object SqlSdxEcttbsdx_use: TStringField
      FieldName = 'tbsdx_use'
      Size = 1
    end
  end
  object DTSsdxEtc: TDataSource
    DataSet = SqlSdxEct
    Left = 465
    Top = 250
  end
  object ZROQTokenLido: TZReadOnlyQuery
    Connection = Ads
    SQL.Strings = (
      
        'select cg76_remes as "Token",cg76_caixa as "Caixa",cg76_dtentr a' +
        's "Lido", cg76_ag as "Ag'#234'ncia",cg76_dtb as "DTB",cg76_dtsai as "' +
        'Data"'
      
        ',cg76_numlote as "Lote", cga_acesso.nome  as "Usu'#225'rio" from cga7' +
        '6'
      
        'full join cga_acesso on cga76.cg76_codusu_dig = cga_acesso.codig' +
        'o '
      'limit 1')
    Params = <>
    Properties.Strings = (
      ''
      '')
    Left = 389
    Top = 303
    object ZROQTokenLidoToken: TStringField
      FieldName = 'Token'
      Required = True
      Size = 25
    end
    object ZROQTokenLidoCaixa: TLargeintField
      FieldName = 'Caixa'
    end
    object ZROQTokenLidoLido: TDateField
      FieldName = 'Lido'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object ZROQTokenLidoAgncia: TStringField
      FieldName = 'Ag'#234'ncia'
      Size = 5
    end
    object ZROQTokenLidoDTB: TStringField
      FieldName = 'DTB'
      Size = 15
    end
    object ZROQTokenLidoData: TDateField
      FieldName = 'Data'
    end
    object ZROQTokenLidoLote: TStringField
      FieldName = 'Lote'
      Size = 6
    end
    object ZROQTokenLidoUsurio: TStringField
      FieldName = 'Usu'#225'rio'
      Size = 14
    end
  end
  object DtSTokenLido: TDataSource
    DataSet = ZROQTokenLido
    Left = 465
    Top = 303
  end
  object SqlCga78: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cga78')
    Params = <>
    Left = 200
    Top = 630
    object StringField1: TStringField
      FieldName = 'cg75_remes'
    end
    object IntegerField1: TIntegerField
      FieldName = 'cg75_dup'
    end
    object DateField1: TDateField
      FieldName = 'cg75_dtext'
    end
    object DateField2: TDateField
      FieldName = 'cg75_dtbaixa'
    end
    object StringField2: TStringField
      FieldName = 'cg75_codbaixa'
      Size = 3
    end
    object DateField3: TDateField
      FieldName = 'cg75_dtret'
    end
    object LargeintField1: TLargeintField
      FieldName = 'cg75_caixa'
    end
    object IntegerField2: TIntegerField
      FieldName = 'cg75_codusu'
    end
    object StringField3: TStringField
      FieldName = 'cg75_codag'
      Size = 10
    end
    object StringField4: TStringField
      FieldName = 'cg75_conta'
      Size = 10
    end
    object StringField5: TStringField
      FieldName = 'cg75_tipo'
      Size = 4
    end
  end
  object DtSCga78: TDataSource
    DataSet = SqlCga78
    Left = 283
    Top = 630
  end
  object ZRResumo: TZReadOnlyQuery
    Connection = Ads
    SQL.Strings = (
      'select * from cgatemp')
    Params = <>
    Properties.Strings = (
      ''
      '')
    Left = 389
    Top = 630
    object ZRResumomotivo: TStringField
      FieldName = 'motivo'
      Size = 50
    end
    object ZRResumotipo_serv_01: TFloatField
      FieldName = 'tipo_serv_01'
    end
    object ZRResumotipo_serv_02: TFloatField
      FieldName = 'tipo_serv_02'
    end
    object ZRResumotipo_serv_03: TFloatField
      FieldName = 'tipo_serv_03'
    end
    object ZRResumotipo_serv_04: TFloatField
      FieldName = 'tipo_serv_04'
    end
    object ZRResumotipo_serv_05: TFloatField
      FieldName = 'tipo_serv_05'
    end
    object ZRResumotipo_serv_06: TFloatField
      FieldName = 'tipo_serv_06'
    end
    object ZRResumotipo_serv_07: TFloatField
      FieldName = 'tipo_serv_07'
    end
    object ZRResumotipo_serv_08: TFloatField
      FieldName = 'tipo_serv_08'
    end
    object ZRResumotipo_serv_09: TFloatField
      FieldName = 'tipo_serv_09'
    end
    object ZRResumotipo_serv_10: TFloatField
      FieldName = 'tipo_serv_10'
    end
    object ZRResumotipo_serv_11: TFloatField
      FieldName = 'tipo_serv_11'
    end
    object ZRResumotipo_serv_12: TFloatField
      FieldName = 'tipo_serv_12'
    end
    object ZRResumotipo_serv_13: TFloatField
      FieldName = 'tipo_serv_13'
    end
    object ZRResumotipo_serv_14: TFloatField
      FieldName = 'tipo_serv_14'
    end
    object ZRResumotipo_serv_15: TFloatField
      FieldName = 'tipo_serv_15'
    end
  end
  object DtSResumo: TDataSource
    DataSet = ZRResumo
    Left = 465
    Top = 630
  end
  object SqlServNLido: TZQuery
    Connection = Ads
    Params = <>
    Left = 574
    Top = 630
  end
  object DtSServNLido: TDataSource
    DataSet = SqlServNLido
    Left = 661
    Top = 630
  end
  object DtSServico: TDataSource
    DataSet = SqlServico
    Left = 104
    Top = 685
  end
  object SqlServico: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from tbsdxserv where (0=1)')
    Params = <>
    Left = 30
    Top = 685
    object SqlServicotbsdxserv_cod: TIntegerField
      FieldName = 'tbsdxserv_cod'
      Required = True
    end
    object SqlServicotbsdxserv_prod: TIntegerField
      FieldName = 'tbsdxserv_prod'
    end
    object SqlServicotbsdxserv_dsc: TStringField
      FieldName = 'tbsdxserv_dsc'
      Size = 50
    end
    object SqlServicotbsdxserv_dtcad: TDateField
      FieldName = 'tbsdxserv_dtcad'
    end
    object SqlServicotbsdxserv_usu: TIntegerField
      FieldName = 'tbsdxserv_usu'
    end
    object SqlServicotbsdxserv_sigla: TStringField
      FieldName = 'tbsdxserv_sigla'
      Size = 2
    end
    object SqlServicotbsdxserv_nrocto: TStringField
      FieldName = 'tbsdxserv_nrocto'
      Size = 10
    end
    object SqlServicotbsdxserv_crtpst: TStringField
      FieldName = 'tbsdxserv_crtpst'
      Size = 9
    end
    object SqlServicotbsdxserv_txasrv: TFloatField
      FieldName = 'tbsdxserv_txasrv'
    end
  end
  object DtSqlAux2: TDataSource
    DataSet = SqlTotNLido
    Left = 104
    Top = 195
  end
  object SqlTotNLido: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from totnlido')
    Params = <>
    Left = 200
    Top = 195
    object SqlTotNLidoQtde: TFloatField
      FieldName = 'Qtde'
    end
    object SqlTotNLidoData: TDateField
      FieldName = 'Data'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object SqlTotNLidoTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object SqlTotNLidoServio: TStringField
      FieldName = 'Servi'#231'o'
      Size = 40
    end
  end
  object DtSTotNLido: TDataSource
    DataSet = SqlTotNLido
    Left = 283
    Top = 195
  end
  object ZOQListaToken: TZReadOnlyQuery
    Connection = Ads
    SQL.Strings = (
      
        'select cga76.cg76_dtsai, cga76.cg76_ag,cga76.cg76_remes,cga76.cg' +
        '76_dtb,cg76_numlote,cga20.cg20_descricao,cg76_tipocli '
      'from cga76 '
      'inner join cga20 on cga76.cg76_codbaixa = cga20.cg20_codbaixa'
      'where (cga76.cg76_numlote = '#39'001258'#39')  ')
    Params = <>
    Left = 30
    Top = 521
    object ZOQListaTokencg76_dtsai: TDateField
      FieldName = 'cg76_dtsai'
    end
    object ZOQListaTokencg76_ag: TStringField
      FieldName = 'cg76_ag'
      Size = 5
    end
    object ZOQListaTokencg76_remes: TStringField
      FieldName = 'cg76_remes'
      Required = True
      Size = 25
    end
    object ZOQListaTokencg76_dtb: TStringField
      FieldName = 'cg76_dtb'
      Size = 15
    end
    object ZOQListaTokencg76_numlote: TStringField
      FieldName = 'cg76_numlote'
      Size = 6
    end
    object ZOQListaTokencg20_descricao: TStringField
      FieldName = 'cg20_descricao'
      Size = 35
    end
    object ZOQListaTokencg76_tipocli: TIntegerField
      FieldName = 'cg76_tipocli'
    end
  end
  object DtSListaToken: TDataSource
    DataSet = ZOQListaToken
    Left = 104
    Top = 521
  end
  object SqlSdx3: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT sdx02.*, serv.* '
      'FROM'
      '  public.tbsdx02 sdx02'
      
        '  INNER JOIN public.tbsdx_ect e ON (sdx02.sdx_numobj2 = e.tbsdxe' +
        'ct_sigla || e.tbsdxect_num || e.tbsdxect_dv || '#39'BR'#39')'
      
        '  INNER JOIN public.tbsdxserv serv ON (e.tbsdxect_prod = serv.tb' +
        'sdxserv_prod)'
      'WHERE sdx02.sdx_dtcarga > CURRENT_DATE - 1'
      'ORDER BY sdx02.sdx_dtcarga DESC'
      '')
    Params = <>
    Left = 200
    Top = 685
    object SqlSdx3sdx_codcli: TFloatField
      FieldName = 'sdx_codcli'
    end
    object SqlSdx3sdx_siglaobj: TStringField
      FieldName = 'sdx_siglaobj'
      Size = 2
    end
    object SqlSdx3sdx_numobj: TFloatField
      FieldName = 'sdx_numobj'
    end
    object SqlSdx3sdx_paisorigem: TStringField
      FieldName = 'sdx_paisorigem'
      Size = 2
    end
    object SqlSdx3sdx_codoperacao: TStringField
      FieldName = 'sdx_codoperacao'
      Size = 4
    end
    object SqlSdx3sdx_numobj4: TStringField
      FieldName = 'sdx_numobj4'
    end
    object SqlSdx3sdx_nomdest: TStringField
      FieldName = 'sdx_nomdest'
      Size = 80
    end
    object SqlSdx3sdx_endedest: TStringField
      FieldName = 'sdx_endedest'
      Size = 80
    end
    object SqlSdx3sdx_cidade: TStringField
      FieldName = 'sdx_cidade'
      Size = 50
    end
    object SqlSdx3sdx_uf: TStringField
      FieldName = 'sdx_uf'
      Size = 2
    end
    object SqlSdx3sdx_cep: TStringField
      FieldName = 'sdx_cep'
      Size = 8
    end
    object SqlSdx3sdx_numseqarq: TFloatField
      FieldName = 'sdx_numseqarq'
    end
    object SqlSdx3sdx_numseqreg: TStringField
      FieldName = 'sdx_numseqreg'
      Size = 24
    end
    object SqlSdx3sdx_dtcarga: TDateField
      FieldName = 'sdx_dtcarga'
    end
    object SqlSdx3sdx_seqcarga: TLargeintField
      FieldName = 'sdx_seqcarga'
    end
    object SqlSdx3sdx_numobj2: TStringField
      FieldName = 'sdx_numobj2'
      Size = 13
    end
    object SqlSdx3sdx_cepnet: TStringField
      FieldName = 'sdx_cepnet'
      Size = 11
    end
    object SqlSdx3sdx_numobj1: TStringField
      FieldName = 'sdx_numobj1'
      Size = 13
    end
    object SqlSdx3sdx_valor: TFloatField
      FieldName = 'sdx_valor'
    end
    object SqlSdx3sdx_peso: TFloatField
      FieldName = 'sdx_peso'
    end
    object SqlSdx3sdx_qtde: TIntegerField
      FieldName = 'sdx_qtde'
    end
    object SqlSdx3sdx_tvalor: TFloatField
      FieldName = 'sdx_tvalor'
    end
    object SqlSdx3sdx_valdec: TFloatField
      FieldName = 'sdx_valdec'
    end
    object SqlSdx3sdx_numobj5: TStringField
      FieldName = 'sdx_numobj5'
    end
    object SqlSdx3tbsdxserv_crtpst: TStringField
      FieldName = 'tbsdxserv_crtpst'
      Size = 9
    end
    object SqlSdx3tbsdxserv_nrocto: TStringField
      FieldName = 'tbsdxserv_nrocto'
      Size = 10
    end
    object SqlSdx3sdx_cmp: TFloatField
      FieldName = 'sdx_cmp'
    end
    object SqlSdx3sdx_bas: TFloatField
      FieldName = 'sdx_bas'
    end
    object SqlSdx3sdx_alt: TFloatField
      FieldName = 'sdx_alt'
    end
    object SqlSdx3tbsdxect_sigla: TStringField
      FieldName = 'tbsdxect_sigla'
      Size = 2
    end
  end
  object DtsSdx3: TDataSource
    DataSet = SqlSdx3
    Left = 283
    Top = 685
  end
  object RvRelatorios: TRvProject
    Engine = RvSystem1
    Left = 30
    Top = 75
  end
  object RvRenderPDF1: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    BufferDocument = True
    DisableHyperlinks = False
    Left = 284
    Top = 75
  end
  object SqlSdxServ: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT t.* FROM public.tbsdxserv t '
      'WHERE t.tbsdxserv_status = 1')
    Params = <>
    Left = 389
    Top = 685
    object SqlSdxServtbsdxserv_cod: TIntegerField
      FieldName = 'tbsdxserv_cod'
      Required = True
    end
    object SqlSdxServtbsdxserv_prod: TIntegerField
      FieldName = 'tbsdxserv_prod'
    end
    object SqlSdxServtbsdxserv_dsc: TStringField
      FieldName = 'tbsdxserv_dsc'
      Size = 50
    end
    object SqlSdxServtbsdxserv_dtcad: TDateField
      FieldName = 'tbsdxserv_dtcad'
    end
    object SqlSdxServtbsdxserv_usu: TIntegerField
      FieldName = 'tbsdxserv_usu'
    end
    object SqlSdxServtbsdxserv_sigla: TStringField
      FieldName = 'tbsdxserv_sigla'
      Size = 2
    end
    object SqlSdxServtbsdxserv_nrocto: TStringField
      FieldName = 'tbsdxserv_nrocto'
      Size = 10
    end
    object SqlSdxServtbsdxserv_crtpst: TStringField
      FieldName = 'tbsdxserv_crtpst'
      Size = 9
    end
    object SqlSdxServtbsdxserv_status: TSmallintField
      DisplayWidth = 2
      FieldName = 'tbsdxserv_status'
    end
    object SqlSdxServtbsdxserv_txasrv: TFloatField
      FieldName = 'tbsdxserv_txasrv'
    end
  end
  object DtSSdxServ: TDataSource
    AutoEdit = False
    DataSet = SqlSdxServ
    Left = 465
    Top = 685
  end
  object SqlTbBradDeptos: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT * FROM tbbraddptos ORDER BY juncao LIMIT 10')
    Params = <>
    Left = 574
    Top = 685
    object SqlTbBradDeptosjuncao: TIntegerField
      FieldName = 'juncao'
    end
    object SqlTbBradDeptosdepto: TStringField
      FieldName = 'depto'
      Size = 50
    end
    object SqlTbBradDeptoscnpj: TStringField
      FieldName = 'cnpj'
      Size = 18
    end
    object SqlTbBradDeptosender: TStringField
      FieldName = 'ender'
      Size = 60
    end
    object SqlTbBradDeptosbairro: TStringField
      FieldName = 'bairro'
      Size = 30
    end
    object SqlTbBradDeptoscep: TStringField
      FieldName = 'cep'
      Size = 10
    end
    object SqlTbBradDeptoscidade: TStringField
      FieldName = 'cidade'
      Size = 30
    end
    object SqlTbBradDeptosuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
    object SqlTbBradDeptostel: TStringField
      FieldName = 'tel'
      Size = 40
    end
    object SqlTbBradDeptosramal: TStringField
      FieldName = 'ramal'
      Size = 10
    end
    object SqlTbBradDeptosfax: TStringField
      FieldName = 'fax'
      Size = 40
    end
    object SqlTbBradDeptosregiao: TStringField
      FieldName = 'regiao'
      Size = 50
    end
    object SqlTbBradDeptosempresa: TStringField
      FieldName = 'empresa'
      Size = 50
    end
  end
  object DtSTbBradDeptos: TDataSource
    DataSet = SqlTbBradDeptos
    Left = 661
    Top = 685
  end
  object SqlSdx4: TZQuery
    Connection = Ads
    AutoCalcFields = False
    SQL.Strings = (
      'SELECT t.*, s.tbsdxserv_sigla, s.tbsdxserv_dsc, d.bxasdx_dscbxa'
      'FROM public.tbsdx02 t'
      
        '    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj2 = e.tbsdxect' +
        '_sigla || e.tbsdxect_num || e.tbsdxect_dv || '#39'BR'#39')'
      
        '    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxs' +
        'erv_prod)'
      
        '    LEFT JOIN public.tbbxasdx d ON (t.sdx_codbxa = d.bxasdx_codb' +
        'xa)'
      'ORDER BY t.sdx_dtbaixa DESC LIMIT 10')
    Params = <>
    Left = 200
    Top = 741
    object SqlSdx4sdx_tpreg: TFloatField
      FieldName = 'sdx_tpreg'
    end
    object SqlSdx4sdx_codcli: TFloatField
      FieldName = 'sdx_codcli'
    end
    object SqlSdx4sdx_idcli: TStringField
      FieldName = 'sdx_idcli'
      Size = 2
    end
    object SqlSdx4sdx_siglaobj: TStringField
      FieldName = 'sdx_siglaobj'
      Size = 2
    end
    object SqlSdx4sdx_numobj: TFloatField
      FieldName = 'sdx_numobj'
    end
    object SqlSdx4sdx_paisorigem: TStringField
      FieldName = 'sdx_paisorigem'
      Size = 2
    end
    object SqlSdx4sdx_codoperacao: TStringField
      FieldName = 'sdx_codoperacao'
      Size = 4
    end
    object SqlSdx4sdx_numobj4: TStringField
      FieldName = 'sdx_numobj4'
    end
    object SqlSdx4sdx_nomdest: TStringField
      FieldName = 'sdx_nomdest'
      Size = 50
    end
    object SqlSdx4sdx_endedest: TStringField
      FieldName = 'sdx_endedest'
      Size = 50
    end
    object SqlSdx4sdx_cidade: TStringField
      FieldName = 'sdx_cidade'
      Size = 30
    end
    object SqlSdx4sdx_uf: TStringField
      FieldName = 'sdx_uf'
      Size = 2
    end
    object SqlSdx4sdx_cep: TStringField
      DisplayWidth = 9
      FieldName = 'sdx_cep'
      EditMask = '00000\-999;0;_'
      Size = 9
      Transliterate = False
    end
    object SqlSdx4sdx_numseqarq: TFloatField
      FieldName = 'sdx_numseqarq'
    end
    object SqlSdx4sdx_numseqreg: TStringField
      FieldName = 'sdx_numseqreg'
      Size = 24
    end
    object SqlSdx4sdx_dtcarga: TDateField
      FieldName = 'sdx_dtcarga'
    end
    object SqlSdx4sdx_seqcarga: TLargeintField
      FieldName = 'sdx_seqcarga'
    end
    object SqlSdx4sdx_numobj2: TStringField
      FieldName = 'sdx_numobj2'
      Size = 13
    end
    object SqlSdx4sdx_cepnet: TStringField
      FieldName = 'sdx_cepnet'
      Size = 11
    end
    object SqlSdx4sdx_numobj1: TStringField
      FieldName = 'sdx_numobj1'
      Size = 13
    end
    object SqlSdx4sdx_codusu: TIntegerField
      FieldName = 'sdx_codusu'
    end
    object SqlSdx4sdx_valor: TFloatField
      FieldName = 'sdx_valor'
    end
    object SqlSdx4sdx_peso: TFloatField
      FieldName = 'sdx_peso'
    end
    object SqlSdx4sdx_numobj3: TStringField
      FieldName = 'sdx_numobj3'
    end
    object SqlSdx4sdx_numobj5: TStringField
      FieldName = 'sdx_numobj5'
    end
    object SqlSdx4sdx_qtde: TIntegerField
      FieldName = 'sdx_qtde'
    end
    object SqlSdx4sdx_tvalor: TFloatField
      FieldName = 'sdx_tvalor'
    end
    object SqlSdx4sdx_valdec: TFloatField
      FieldName = 'sdx_valdec'
    end
    object SqlSdx4sdx_dtentrega: TDateField
      FieldName = 'sdx_dtentrega'
    end
    object SqlSdx4sdx_dtenvio: TDateField
      FieldName = 'sdx_dtenvio'
    end
    object SqlSdx4sdx_nomrecebe: TStringField
      FieldName = 'sdx_nomrecebe'
      Size = 50
    end
    object SqlSdx4sdx_codbxa: TIntegerField
      FieldName = 'sdx_codbxa'
    end
    object SqlSdx4sdx_codusu_bxa: TIntegerField
      FieldName = 'sdx_codusu_bxa'
    end
    object SqlSdx4sdx_dtbaixa: TDateField
      FieldName = 'sdx_dtbaixa'
    end
    object SqlSdx4sdx_qtprod: TIntegerField
      FieldName = 'sdx_qtprod'
    end
    object SqlSdx4sdx_dtarqret: TDateField
      FieldName = 'sdx_dtarqret'
    end
    object SqlSdx4sdx_dtmov: TDateField
      FieldName = 'sdx_dtmov'
    end
    object SqlSdx4sdx_valar: TFloatField
      FieldName = 'sdx_valar'
    end
    object SqlSdx4sdx_porc: TFloatField
      FieldName = 'sdx_porc'
    end
    object SqlSdx4sdx_valmin: TFloatField
      FieldName = 'sdx_valmin'
    end
    object SqlSdx4sdx_difval: TFloatField
      FieldName = 'sdx_difval'
    end
    object SqlSdx4sdx_horaenvio: TTimeField
      FieldName = 'sdx_horaenvio'
    end
    object SqlSdx4sdx_bas: TFloatField
      FieldName = 'sdx_bas'
    end
    object SqlSdx4sdx_cmp: TFloatField
      FieldName = 'sdx_cmp'
    end
    object SqlSdx4sdx_alt: TFloatField
      FieldName = 'sdx_alt'
    end
    object SqlSdx4sdx_cobdest: TFloatField
      FieldName = 'sdx_cobdest'
    end
    object SqlSdx4sdx_codcxa: TIntegerField
      FieldName = 'sdx_codcxa'
    end
    object SqlSdx4tbsdxserv_siglaproduto: TStringField
      FieldName = 'tbsdxserv_sigla'
      Size = 2
    end
    object SqlSdx4tbsdxserv_produto: TStringField
      FieldName = 'tbsdxserv_dsc'
      Size = 50
    end
    object SqlSdx4tbsdxserv_codprod: TIntegerField
      FieldName = 'tbsdxserv_prod'
    end
    object SqlSdx4bxasdx_dscbxa: TStringField
      FieldName = 'bxasdx_dscbxa'
      Size = 50
    end
  end
  object DtSSdx4: TDataSource
    DataSet = SqlSdx4
    Left = 283
    Top = 741
  end
  object SqlAux4: TZQuery
    Connection = Ads
    Params = <>
    Left = 389
    Top = 741
  end
  object DtSAux4: TDataSource
    DataSet = SqlAux4
    Left = 465
    Top = 741
  end
  object Sqltbbxasdx: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select * from tbbxasdx')
    Params = <>
    Left = 574
    Top = 741
    object Sqltbbxasdxbxasdx_codbxa: TIntegerField
      FieldName = 'bxasdx_codbxa'
      Required = True
    end
    object Sqltbbxasdxbxasdx_dscbxa: TStringField
      FieldName = 'bxasdx_dscbxa'
      Size = 50
    end
  end
  object DtStbbxasdx: TDataSource
    DataSet = Sqltbbxasdx
    Left = 661
    Top = 741
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Gerando p'#225'gina %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 197
    Top = 75
  end
  object RvDtsSdx3: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = SqlSdx3
    Left = 110
    Top = 75
  end
  object SqlSdx5: TZQuery
    Connection = Ads
    SQL.Strings = (
      'select sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,'
      
        'sdx_paisorigem,sdx_codoperacao,sdx_numobj3,sdx_nomdest,sdx_ended' +
        'est,sdx_cidade,'
      
        'sdx_uf,sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_seqca' +
        'rga,'
      'sdx_numobj2,sdx_cepnet,sdx_numobj1,sdx_numobj4 ,sdx_numobj5,'
      'sdx_codusu,  sdx_peso,  sdx_qtd,  sdx_dtenvio,  sdx_horaenvio'
      'from tbsdx '
      ''
      'limit1'
      '')
    Params = <>
    Left = 30
    Top = 741
    object SqlSdx5sdx_codcli: TFloatField
      FieldName = 'sdx_codcli'
    end
    object SqlSdx5sdx_idcli: TStringField
      FieldName = 'sdx_idcli'
      Size = 2
    end
    object SqlSdx5sdx_siglaobj: TStringField
      FieldName = 'sdx_siglaobj'
      Size = 2
    end
    object SqlSdx5sdx_numobj: TFloatField
      FieldName = 'sdx_numobj'
    end
    object SqlSdx5sdx_paisorigem: TStringField
      FieldName = 'sdx_paisorigem'
      Size = 2
    end
    object SqlSdx5sdx_codoperacao: TStringField
      FieldName = 'sdx_codoperacao'
      Size = 4
    end
    object SqlSdx5sdx_numobj3: TStringField
      FieldName = 'sdx_numobj3'
    end
    object SqlSdx5sdx_nomdest: TStringField
      FieldName = 'sdx_nomdest'
      Size = 50
    end
    object SqlSdx5sdx_endedest: TStringField
      FieldName = 'sdx_endedest'
      Size = 50
    end
    object SqlSdx5sdx_cidade: TStringField
      FieldName = 'sdx_cidade'
      Size = 30
    end
    object SqlSdx5sdx_uf: TStringField
      FieldName = 'sdx_uf'
      Size = 2
    end
    object SqlSdx5sdx_cep: TStringField
      FieldName = 'sdx_cep'
      EditMask = '!99999\-999;0;0'
      Size = 8
    end
    object SqlSdx5sdx_numseqarq: TFloatField
      FieldName = 'sdx_numseqarq'
    end
    object SqlSdx5sdx_numseqreg: TFloatField
      FieldName = 'sdx_numseqreg'
    end
    object SqlSdx5sdx_dtcarga: TDateField
      FieldName = 'sdx_dtcarga'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object SqlSdx5sdx_seqcarga: TIntegerField
      FieldName = 'sdx_seqcarga'
    end
    object SqlSdx5sdx_numobj2: TStringField
      FieldName = 'sdx_numobj2'
      Size = 13
    end
    object SqlSdx5sdx_cepnet: TStringField
      FieldName = 'sdx_cepnet'
      Size = 11
    end
    object SqlSdx5sdx_numobj1: TStringField
      FieldName = 'sdx_numobj1'
      Size = 13
    end
    object SqlSdx5sdx_numobj4: TStringField
      FieldName = 'sdx_numobj4'
    end
    object SqlSdx5sdx_numobj5: TStringField
      FieldName = 'sdx_numobj5'
      Size = 9
    end
    object SqlSdx5sdx_codusu: TIntegerField
      FieldName = 'sdx_codusu'
    end
    object SqlSdx5sdx_peso: TFloatField
      FieldName = 'sdx_peso'
    end
    object SqlSdx5sdx_qtd: TIntegerField
      FieldName = 'sdx_qtd'
    end
    object SqlSdx5sdx_dtenvio: TDateField
      FieldName = 'sdx_dtenvio'
    end
  end
  object DtsSdx5: TDataSource
    DataSet = SqlSdx5
    Left = 104
    Top = 741
  end
  object SqlAux3: TZQuery
    Connection = Ads
    SQL.Strings = (
      
        'select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdx' +
        'ect_prod = '#39#39'0'#39#39') and (tbsdx_use is null) group by tbsdxect_num,' +
        'tbsdxect_dv order by tbsdxect_num limit 1')
    Params = <>
    Left = 110
    Top = 139
  end
  object SqlSdx6: TZQuery
    Connection = Ads
    AutoCalcFields = False
    SQL.Strings = (
      'SELECT '
      '  sdx02.sdx_seqcarga AS lote,'
      '  serv.tbsdxserv_prod AS codproduto,'
      '  serv.tbsdxserv_dsc as produto,'
      '  COUNT(*) as qtitens,'
      '  MIN(sdx02.sdx_dtcarga) AS dtini,'
      '  MAX(sdx02.sdx_dtcarga) AS dtfin'
      'FROM'
      '  public.tbsdx02 sdx02'
      
        '  INNER JOIN public.tbsdx_ect e ON (sdx02.sdx_numobj2 = e.tbsdxe' +
        'ct_sigla || e.tbsdxect_num || e.tbsdxect_dv || '#39'BR'#39')'
      
        '  INNER JOIN public.tbsdxserv serv ON (e.tbsdxect_prod = serv.tb' +
        'sdxserv_prod)'
      'WHERE sdx02.sdx_dtcarga BETWEEN :dtini AND :dtfin'
      'GROUP BY 1, 2, 3'
      'ORDER BY 6 DESC, sdx_seqcarga DESC')
    Params = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dtfin'
        ParamType = ptUnknown
        Value = 0d
      end>
    Left = 30
    Top = 795
    ParamData = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dtfin'
        ParamType = ptUnknown
        Value = 0d
      end>
    object SqlSdx6Lote: TLargeintField
      FieldName = 'lote'
    end
    object SqlSdx6QtObjs: TLargeintField
      FieldName = 'qtitens'
    end
    object SqlSdx6Dtini: TDateField
      FieldName = 'dtini'
    end
    object SqlSdx6Dtfin: TDateField
      FieldName = 'dtfin'
    end
    object SqlSdx6Produto: TStringField
      FieldName = 'produto'
    end
    object SqlSdx6CodProduto: TIntegerField
      FieldName = 'codproduto'
    end
  end
  object DtsSdx6: TDataSource
    DataSet = SqlSdx6
    Left = 104
    Top = 795
  end
  object SqlSdx7: TZQuery
    Connection = Ads
    AutoCalcFields = False
    SQL.Strings = (
      'SELECT '
      '  s.tbsdxserv_dsc,'
      '  s.tbsdxserv_crtpst,'
      '  s.tbsdxserv_sigla,'
      '  s.tbsdxserv_prod,'
      '  t.sdx_seqcarga as lote,'
      '  COUNT(t.sdx_numobj2) AS qtobjs,'
      '  MIN(t.sdx_dtenvio) AS mindt,'
      '  MAX(t.sdx_dtenvio) as maxdt'
      'FROM'
      '  public.tbsdx_ect e'
      
        '  INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxser' +
        'v_prod)'
      
        '  INNER JOIN public.tbsdx02 t ON (e.tbsdxect_sigla || e.tbsdxect' +
        '_num || e.tbsdxect_dv || '#39'BR'#39' = t.sdx_numobj2)'
      'WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim'
      'GROUP BY 1, 2, 3, 4, 5'
      'ORDER BY 8 DESC')
    Params = <
      item
        DataType = ftString
        Name = 'dtini'
        ParamType = ptInput
        Value = 42293d
      end
      item
        DataType = ftString
        Name = 'dtfim'
        ParamType = ptInput
        Value = 42293d
      end>
    Left = 200
    Top = 795
    ParamData = <
      item
        DataType = ftString
        Name = 'dtini'
        ParamType = ptInput
        Value = 42293d
      end
      item
        DataType = ftString
        Name = 'dtfim'
        ParamType = ptInput
        Value = 42293d
      end>
    object SqlSdx7tbsdxserv_dsc: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'tbsdxserv_dsc'
      Size = 50
    end
    object SqlSdx7tbsdxserv_crtpst: TStringField
      DisplayLabel = 'Cart'#227'o de Postagem'
      FieldName = 'tbsdxserv_crtpst'
      Size = 9
    end
    object SqlSdx7tbsdxserv_sigla: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'tbsdxserv_sigla'
      Size = 2
    end
    object SqlSdx7tbsdxserv_prod: TIntegerField
      FieldName = 'tbsdxserv_prod'
    end
    object SqlSdx7lote: TLargeintField
      FieldName = 'lote'
    end
    object SqlSdx7qtobjs: TLargeintField
      DisplayLabel = 'Qtde'
      FieldName = 'qtobjs'
    end
    object SqlSdx7mindt: TDateField
      FieldName = 'mindt'
    end
    object SqlSdx7maxdt: TDateField
      FieldName = 'maxdt'
    end
  end
  object DtSSdx7: TDataSource
    DataSet = SqlSdx7
    Left = 283
    Top = 795
  end
  object SqlSdx8: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT COUNT(a.cg75_remes) as qtde, '
      '    b.cg20_descricao as descricao, '
      '    b.cg20_codbaixa as codbaixa'
      'FROM cga75 a '
      '  INNER JOIN cga20 b ON (a.cg75_codbaixa = b.cg20_codbaixa)'
      'WHERE a.cg75_dtbaixa BETWEEN :dtini AND :dtfim'
      'GROUP BY b.cg20_descricao, b.cg20_codbaixa'
      'ORDER BY b.cg20_descricao')
    Params = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dtfim'
        ParamType = ptUnknown
        Value = 0d
      end>
    Left = 389
    Top = 805
    ParamData = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dtfim'
        ParamType = ptUnknown
        Value = 0d
      end>
    object SqlSdx8_descricao: TStringField
      FieldName = 'descricao'
      Size = 35
    end
    object SqlSdx8_codbaixa: TStringField
      DisplayWidth = 4
      FieldName = 'codbaixa'
      Size = 4
    end
    object SqlSdx8qtde: TLargeintField
      FieldName = 'qtde'
    end
  end
  object DtsSdx8: TDataSource
    DataSet = SqlSdx8
    Left = 467
    Top = 805
  end
  object RvDtsSdx8: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = SqlSdx8
    Left = 536
    Top = 805
  end
  object SqlSdx9: TZQuery
    Connection = Ads
    SQL.Strings = (
      'SELECT COUNT(a.cg75_remes) as qtde, '
      '    a.cg75_dtbaixa as dtbaixa, '
      '    b.cg20_descricao as descricao, '
      '    b.cg20_codbaixa as codbaixa'
      'FROM cga75 a '
      '  INNER JOIN cga20 b ON (a.cg75_codbaixa = b.cg20_codbaixa)'
      'WHERE a.cg75_dtbaixa BETWEEN :dtini AND :dtfim'
      'GROUP BY a.cg75_dtbaixa, b.cg20_descricao, b.cg20_codbaixa'
      'ORDER BY b.cg20_descricao, a.cg75_dtbaixa')
    Params = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'dtfim'
        ParamType = ptUnknown
      end>
    Left = 389
    Top = 861
    ParamData = <
      item
        DataType = ftDate
        Name = 'dtini'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'dtfim'
        ParamType = ptUnknown
      end>
    object DateTimeField1: TDateTimeField
      FieldName = 'dtbaixa'
    end
    object StringField6: TStringField
      FieldName = 'descricao'
      Size = 35
    end
    object StringField7: TStringField
      DisplayWidth = 4
      FieldName = 'codbaixa'
      Size = 4
    end
    object SqlSdx9qtde: TLargeintField
      FieldName = 'qtde'
    end
  end
  object DtsSdx9: TDataSource
    DataSet = SqlSdx9
    Left = 467
    Top = 861
  end
  object RvDtsSdx9: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = SqlSdx9
    Left = 536
    Top = 861
  end
end
