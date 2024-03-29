program Ads1;

uses
  Forms,
  U_Principal in 'U_Principal.pas' {FrmPrincipal},
  DmDados in 'DmDados.pas' {Dm},
  FrmExtContaCorrentePopanca in 'FrmExtContaCorrentePopanca.pas' {FrmExtContaCorrentePoupanca},
  U_ExtConsolidado in 'U_ExtConsolidado.pas' {FrmExtConsolidado},
  U_CadBaixa in 'U_CadBaixa.pas' {FrmCadBaixa},
  U_CadUsu in 'U_CadUsu.pas' {FrmCadUsu},
  U_Func in 'U_Func.pas',
  U_Acesso in 'U_Acesso.pas' {FrmAcesso},
  U_Dig_Christian_Science in 'U_Dig_Christian_Science.pas' {FrmDigChristianSciense},
  U_FrRel_Christian_Sience in 'U_FrRel_Christian_Sience.pas' {FrFrm_Christian_Science},
  U_PesqImp in 'U_PesqImp.pas' {FrmPesqImp},
  U_FrRel_Etiqueta in 'U_FrRel_Etiqueta.pas' {FrFrmImpEtiqueta},
  U_Dig_Previdencia_Bradesco in 'U_Dig_Previdencia_Bradesco.pas' {Frm_Dig_Previdencia_Bradesco},
  U_CadAuto_Christian_Science in 'U_CadAuto_Christian_Science.pas' {FrmCadAutoChristianSciense},
  UPrepCarregAut in 'UPrepCarregAut.pas' {FrmPrepCarregAut},
  U_CadSucursal in 'U_CadSucursal.pas' {FrmCadSucursal},
  U_ImpPrev in 'U_ImpPrev.pas' {FrmImpPrevidencia},
  U_FrmFrProdExtContaCorrente in 'U_FrmFrProdExtContaCorrente.pas' {FrmFrProdExtContaCorrente},
  U_FrRelFaturamentoExt in 'U_FrRelFaturamentoExt.pas' {FrmFrRelFaturamentoExt},
  U_RetornoExtratos in 'U_RetornoExtratos.pas' {FrmRetornoExtratos},
  U_FrmFrEtiqueta in 'U_FrmFrEtiqueta.pas' {FrmFrEtiqueta},
  U_FrmFrRelAgExtCons in 'U_FrmFrRelAgExtCons.pas' {FrmFrRelAgExtCons},
  U_FrmFrBoleto2 in 'U_FrmFrBoleto2.pas' {FrmFrBoleto2},
  U_CadAssinantes in 'U_CadAssinantes.pas' {FrmCadAssinantes},
  U_CadEdicao in 'U_CadEdicao.pas' {FrmCadEdicao},
  U_PesImpAssinantes in 'U_PesImpAssinantes.pas' {FrmPesImpAssinantes},
  U_FrmEtqMLD in 'U_FrmEtqMLD.pas' {FrmEtqMLD},
  u_FrmMkEdi in 'u_FrmMkEdi.pas' {frmMkcadedi},
  u_FrmMkFilial in 'u_FrmMkFilial.pas' {frmMkcadfilial},
  u_FrmMkCep in 'u_FrmMkCep.pas' {FrmMkcep},
  U_Cartao in 'U_Cartao.pas' {frm_cartao},
  U_FrmMkLoja in 'U_FrmMkLoja.pas' {FrmMkLoja},
  u_FrmMkdivisao in 'u_FrmMkdivisao.pas' {FrmMkdivisao},
  U_CadMakro in 'U_CadMakro.pas' {frmmkmakro},
  un_frmprint in 'un_frmprint.pas' {frmMKPrint},
  u_mketiqueta in 'u_mketiqueta.pas' {frmmketiqueta},
  Un_cadcli in 'Un_cadcli.pas' {frmCadcli},
  U_cadcliPrint in 'U_cadcliPrint.pas' {FrmCadcliPrint},
  U_confirma in 'U_confirma.pas' {Frmconfirma},
  U_FrmFrRelFiliais in 'U_FrmFrRelFiliais.pas' {FrmRelFiliais},
  U_FrmRelProtocolosDigit in 'U_FrmRelProtocolosDigit.pas' {FrmRelProtocDigi},
  U_FrmRelRelatProtocolos in 'U_FrmRelRelatProtocolos.pas' {FrmRelProtocolos},
  U_FrmRelProtocAddressBrindes in 'U_FrmRelProtocAddressBrindes.pas' {FrmRelProtocAddress},
  U_FrmDigExtratoUnificado in 'U_FrmDigExtratoUnificado.pas' {FrmDigExtratoUnificado},
  U_FrmRelContratoLimiteCreditoEspecial in 'U_FrmRelContratoLimiteCreditoEspecial.pas' {FrmRelContratoLimiteCreditoEspecial},
  UFrTokenBradesco in 'UFrTokenBradesco.pas' {FrmFrTokenBradesco},
  U_AltTokens in 'U_AltTokens.pas' {FrmAltToken},
  U_FrmConsulta in 'U_FrmConsulta.pas' {FrmConsulta},
  U_CadSedex in 'U_CadSedex.pas' {FrmCadSedex},
  U_PesqImpSedex in 'U_PesqImpSedex.pas' {FrmPesqImpSedex},
  U_FrmRelArSedex in 'U_FrmRelArSedex.pas' {FrmRelArSedex},
  U_FrmRelArSedexLista in 'U_FrmRelArSedexLista.pas' {FrmRelArSedexLista},
  U_FrmRlTotRa in 'U_FrmRlTotRa.pas' {FrmRlTotalRa},
  U_FrRelFaturamentoToken in 'U_FrRelFaturamentoToken.pas' {FrRelFaturamentoToken},
  U_FrRelFaturamentoTancode in 'U_FrRelFaturamentoTancode.pas' {FrRelFaturamentoTancode},
  U_FrRelFaturamentoEtica in 'U_FrRelFaturamentoEtica.pas' {FrRelFaturamentoEtica},
  UFrmFrTokenLido in 'UFrmFrTokenLido.pas' {FrmRlTokenLidos},
  RelCons in 'RelCons.pas' {FrmRelCons},
  U_FrmRlResumo in 'U_FrmRlResumo.pas' {FrmRlResumo},
  U_FrmCadNLido in 'U_FrmCadNLido.pas' {FrmCadNlido},
  U_FrmRlNLido in 'U_FrmRlNLido.pas' {FrmRlNLido},
  UFrmRelArSedexOL in 'UFrmRelArSedexOL.pas' {FrmRelArSedexOl},
  U_FrmRelArSedexListaOL in 'U_FrmRelArSedexListaOL.pas' {U_FrmRelArSedexListaOL},
  U_FrmRemessaSedex in 'U_FrmRemessaSedex.pas' {FrmRemessaSedex},
  U_FrmBxaSedex in 'U_FrmBxaSedex.pas' {FrmBxaSedex},
  U_FrmRelARPend in 'U_FrmRelARPend.pas' {FrmRelARPend},
  U_FrmRlErrobxaArSdx in 'U_FrmRlErrobxaArSdx.pas' {FrmRlErroBxaArSdx},
  uGerarPlanilhaGeral in 'uGerarPlanilhaGeral.pas' {fGerarPlanilhaGeral},
  U_FrmPrintAR in 'U_FrmPrintAR.pas' {FrmPrintAR},
  U_FrmGeraListaPostagem in 'U_FrmGeraListaPostagem.pas' {FrmGeraListaPostagem},
  U_FrmConfig in 'U_FrmConfig.pas' {FrmConfig},
  U_FrmGeraRelatToken in 'U_FrmGeraRelatToken.pas' {FrmGeraRelatToken},
  U_FrmCadToken in 'U_FrmCadToken.pas' {FrmCadToken},
  U_PreCadToken in 'U_PreCadToken.pas' {FrmPreCadToken};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ADS';
  Application.CreateForm(TDm, Dm);
  if Dm.conect = true then
    begin
      Application.CreateForm(TFrmAcesso, FrmAcesso);
      FrmAcesso.ShowModal;
      Application.Run;
    end
  else
    begin
      Application.MessageBox(Pchar('Erro conex�o'), 'ADS',0);
      Application.Terminate;
    end;
end.
