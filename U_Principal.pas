unit U_Principal;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, ComCtrls, WinSkinData, Buttons;

type
    TFrmPrincipal = class(TForm)
    ScrollBox1: TScrollBox;
    MainMenu1: TMainMenu;
    Cadastros: TMenuItem;
    Agencia: TMenuItem;
    Carga1: TMenuItem;
    ExtratoConsolidado1: TMenuItem;
    ExtratoContaCorrentePoupana1: TMenuItem;
    DRCCob: TMenuItem;
    ExtratoUnificado1: TMenuItem;
    CartesExtratoPequeno1: TMenuItem;
    Bradesco1: TMenuItem;
    BCN1: TMenuItem;
    BNDE1: TMenuItem;
    Digitar: TMenuItem;
    ClientesDRC: TMenuItem;
    Impressao1: TMenuItem;
    PrevidenciaBradesco2: TMenuItem;
    ExtratoUnificado2: TMenuItem;
    ExtratoConsolidado2: TMenuItem;
    Extrato1: TMenuItem;
    Sair1: TMenuItem;
    Baixa: TMenuItem;
    Usuarios: TMenuItem;
    ChristianSciense: TMenuItem;
    DigitarRcs: TMenuItem;
    ImpEtqRCS: TMenuItem;
    ImpBolRCS: TMenuItem;
    RelatoriodeMovimento: TMenuItem;
    CadastroporEMail1: TMenuItem;
    Etiquetas1: TMenuItem;
    QuatroColunas1: TMenuItem;
    RelatoriodeProduo1: TMenuItem;
    RelatoriodeProduo2: TMenuItem;
    RelatoriodeProduo3: TMenuItem;
    ExtratoDRC1: TMenuItem;
    RelatoriodeProduo4: TMenuItem;
    RelatoriodeFaturamento1: TMenuItem;
    RelatoriodeFaturamento2: TMenuItem;
    RelatoriodeFaturamento3: TMenuItem;
    RelatoriodeFaturamento4: TMenuItem;
    Manuteno1: TMenuItem;
    GeraodeArquivoRetorno1: TMenuItem;
    ExtratoConsolidado3: TMenuItem;
    ExtratoContaCorrentePoupana2: TMenuItem;
    DRC: TMenuItem;
    ExtratoUnificado3: TMenuItem;
    RetornoCrt: TMenuItem;
    RelatorioCartaParaAgencia1: TMenuItem;
    StsMenu: TStatusBar;
    Timer1: TTimer;
    CadastrodeAssinantes: TMenuItem;
    EdiesArauto: TMenuItem;
    EtiquetasparaAssinantes: TMenuItem;
    EMDArauto: TMenuItem;
    Makro: TMenuItem;
    medi: TMenuItem;
    mfilial: TMenuItem;
    mdfaixacep: TMenuItem;
    BaterCarto: TMenuItem;
    Loja: TMenuItem;
    Diviso: TMenuItem;
    Carregar: TMenuItem;
    CadsMakro: TMenuItem;
    Imprimir: TMenuItem;
    CadCli: TMenuItem;
    N1: TMenuItem;
    ExtratoCarto1: TMenuItem;
    RelatoriodeProduo5: TMenuItem;
    RelatoriodeFaturamento5: TMenuItem;
    BNDE2: TMenuItem;
    BCN2: TMenuItem;
    Bradesco2: TMenuItem;
    ImpProtocolo: TMenuItem;
    RelProtRCS: TMenuItem;
    ImpProtERCS: TMenuItem;
    ExtratoCVM1: TMenuItem;
    RelatoriodeProduo6: TMenuItem;
    RelatoriodeFaturamento6: TMenuItem;
    ExtratoCVM2: TMenuItem;
    ExtratoBancoPostal1: TMenuItem;
    RelatoriodeProduo7: TMenuItem;
    RelatoriodeProduo8: TMenuItem;
    ExtratoBancoPostal2: TMenuItem;
    ExtratoContaCorrente: TMenuItem;
    RelatriodoContratodeLimitedeCrditoEspecial1: TMenuItem;
    EntradadeTokens1: TMenuItem;
    SaidadeTokens1: TMenuItem;
    okensBradesco1: TMenuItem;
    RelAge: TMenuItem;
    DRCCrtAviso: TMenuItem;
    DrcCobranca: TMenuItem;
    DRCCartaConvite: TMenuItem;
    DRCCConvite: TMenuItem;
    RelProdDrcCConv: TMenuItem;
    DRCRelFatCConv: TMenuItem;
    CrtSegur: TMenuItem;
    RetCrtConv: TMenuItem;
    RetCrtSeg: TMenuItem;
    ImpCrtSeg: TMenuItem;
    GerCodEtica: TMenuItem;
    BrindesSecretaria: TMenuItem;
    RelBrindeSecr: TMenuItem;
    RelBrindeSecrEntr: TMenuItem;
    RelBrindSecrSai: TMenuItem;
    RetToken: TMenuItem;
    CodEticaBrad: TMenuItem;
    CadCodEticaBrad: TMenuItem;
    ImpCodEtica: TMenuItem;
    BxaCodEticaBrad: TMenuItem;
    RelProdToken: TMenuItem;
    RetCadCodEtica: TMenuItem;
    RetBxaCodEtica: TMenuItem;
    ImpCadCodEtica: TMenuItem;
    ImpBxaCodEtica: TMenuItem;
    ImpBxaTanCode: TMenuItem;
    AltToken: TMenuItem;
    Consultas: TMenuItem;
    Token: TMenuItem;
    PlanTok: TMenuItem;
    CargaSedex: TMenuItem;
    PostaAr: TMenuItem;
    Sedex1: TMenuItem;
    SedexAr1: TMenuItem;
    ResumoAR: TMenuItem;
    Faturamento1: TMenuItem;
    Faturamento2: TMenuItem;
    Faturamento: TMenuItem;
    CaertodeCredito1: TMenuItem;
    FaturaCartodeCrdito1: TMenuItem;
    CartoCrditoBradesco1: TMenuItem;
    ArDigital: TMenuItem;
    PostArDig: TMenuItem;
    Range: TMenuItem;
    ProdTokLido: TMenuItem;
    ProdTokBxa: TMenuItem;
    LerCLLP: TMenuItem;
    DRCCLLP: TMenuItem;
    RelCons: TMenuItem;
    reltot: TMenuItem;
    RelAvCob: TMenuItem;
    ProdDrcAvCob: TMenuItem;
    RelFatDrcAvCob: TMenuItem;
    ServnLido: TMenuItem;
    Consorcio: TMenuItem;
    Consrcio1: TMenuItem;
    RelConsorcio: TMenuItem;
    ProdConsorcio: TMenuItem;
    CrtSenha: TMenuItem;
    ExtratoConsorcio: TMenuItem;
    ExtratoConsorciado1: TMenuItem;
    RetCrtSenha: TMenuItem;
    RetExtrConsorcio: TMenuItem;
    SedexArOL1: TMenuItem;
    ResumoArOL1: TMenuItem;
    SedexOLTKTC1: TMenuItem;
    SigepSedex1: TMenuItem;
    TokCadEntr: TMenuItem;
    Sedex: TMenuItem;
    SedexOL: TMenuItem;
    SedexTC: TMenuItem;
    SedexTK: TMenuItem;
    SedexOLTkTC2: TMenuItem;
    PlanSedex: TMenuItem;
    BxaSedex: TMenuItem;
    ReenvArTk: TMenuItem;
    ARPend: TMenuItem;
    RetEntreg: TMenuItem;
    Sair: TMenuItem;
    ExtratoFinasa: TMenuItem;
    ExtratoPFE: TMenuItem;
    ImpExFinasa: TMenuItem;
    IExtFPE: TMenuItem;
    GExtratoFinasa: TMenuItem;
    GERFPE001: TMenuItem;
    RelPedOlTcTk: TMenuItem;
    BoletoCLI: TMenuItem;
    IBolCli: TMenuItem;
    GERFCLI01: TMenuItem;
    FinCraCli: TMenuItem;
    ICrtCLI: TMenuItem;
    GERFCRT01: TMenuItem;
    Carga_Token: TMenuItem;
    PreBrindes: TMenuItem;
    PesqSedex: TMenuItem;
    DRCPrivLbl: TMenuItem;
    RelDrcPrv: TMenuItem;
    ProdDrcPrv: TMenuItem;
    DRCPrvLbl: TMenuItem;
    FatDrcPrv: TMenuItem;
    DRCs1: TMenuItem;
    RFatSdx: TMenuItem;
    SedexKV: TMenuItem;
    Sintetico: TMenuItem;
    Analitico: TMenuItem;
    BxaManualSdx: TMenuItem;
    BxaArqSdx: TMenuItem;
    RelPendOLTCTK: TMenuItem;
    DRCCrtFat: TMenuItem;
    RELDrcCrtFat: TMenuItem;
    RelProdDrcCrtFAT: TMenuItem;
    lFatDrcCrtFat: TMenuItem;
    DRCZogMsci: TMenuItem;
    DRCBolAmex: TMenuItem;
    DRCZOGBIMCSI1: TMenuItem;
    RelProdDrcZogMCSI: TMenuItem;
    IFatDRCZogMcsi: TMenuItem;
    DRCCARTOAMEX1: TMenuItem;
    RelPredDrcAmex: TMenuItem;
    IFatDrcAmex: TMenuItem;
    PlanilhaGeral1: TMenuItem;
    precargamenuitem: TMenuItem;
    ImprimeARs: TMenuItem;
    MenuItemCadCaixaToken: TMenuItem;
    MenuItemCadToken: TMenuItem;
    MenuCadToken1A1: TMenuItem;
    ScrollBox2: TScrollBox;
    BitBtnCargaAR: TBitBtn;
    BitBtnRepostagemAR: TBitBtn;
    BitBtnListaPostagem: TBitBtn;
    BitBtnVinculaToken: TBitBtn;
    BitBtnPesagem: TBitBtn;
    BitBtnPrintArs: TBitBtn;
    BitBtnConfig: TBitBtn;
    BitBtnDesvinculaToken: TBitBtn;
    Image1: TImage;
    procedure MenuCadToken1A1Click(Sender: TObject);
    procedure MenuItemCadCaixaTokenClick(Sender: TObject);
    procedure MenuItemCadTokenClick(Sender: TObject);
    procedure BitBtnConfigClick(Sender: TObject);
    procedure BitBtnListaPostagemClick(Sender: TObject);
    procedure BitBtnPesagemClick(Sender: TObject);
    procedure ImprimeARsClick(Sender: TObject);
    procedure precargamenuitemClick(Sender: TObject);
    procedure ReenvArTkClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure PlanilhaGeral1Click(Sender: TObject);
    procedure IFatDrcAmexClick(Sender: TObject);
    procedure IFatDRCZogMcsiClick(Sender: TObject);
    procedure RelPredDrcAmexClick(Sender: TObject);
    procedure RelProdDrcZogMCSIClick(Sender: TObject);
    procedure DRCBolAmexClick(Sender: TObject);
    procedure DRCZogMsciClick(Sender: TObject);
    procedure lFatDrcCrtFatClick(Sender: TObject);
    procedure RelProdDrcCrtFATClick(Sender: TObject);
    procedure DRCCrtFatClick(Sender: TObject);
    procedure RelPendOLTCTKClick(Sender: TObject);
    procedure BxaArqSdxClick(Sender: TObject);
    procedure BxaManualSdxClick(Sender: TObject);
    procedure SinteticoClick(Sender: TObject);
    procedure AnaliticoClick(Sender: TObject);
    procedure SedexKVClick(Sender: TObject);
    procedure RFatSdxClick(Sender: TObject);
    procedure DRCs1Click(Sender: TObject);
    procedure PreOLClick(Sender: TObject);
    procedure FatDrcPrvClick(Sender: TObject);
    procedure DRCPrvLblClick(Sender: TObject);
    procedure ProdDrcPrvClick(Sender: TObject);
    procedure DRCPrivLblClick(Sender: TObject);
    procedure PesqSedexClick(Sender: TObject);
    procedure PreBrindesClick(Sender: TObject);
    procedure Carga_TokenClick(Sender: TObject);
    procedure GERFCRT01Click(Sender: TObject);
    procedure ICrtCLIClick(Sender: TObject);
    procedure FinCraCliClick(Sender: TObject);
    procedure GERFCLI01Click(Sender: TObject);
    procedure IBolCliClick(Sender: TObject);
    procedure BoletoCLIClick(Sender: TObject);
    procedure RelPedOlTcTkClick(Sender: TObject);
    procedure IExtFPEClick(Sender: TObject);
    procedure GERFPE001Click(Sender: TObject);
    procedure IRetFPEClick(Sender: TObject);
    procedure IProdExtFPEClick(Sender: TObject);
    procedure ExtratoPFEClick(Sender: TObject);
    procedure RAROLClick(Sender: TObject);
    procedure RARTCClick(Sender: TObject);
    procedure RARTKClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure RetEntregClick(Sender: TObject);
    procedure ARPendClick(Sender: TObject);
    procedure PreTanCodeClick(Sender: TObject);
    procedure BxaSdxTkClick(Sender: TObject);
    procedure BxaSdxTcClick(Sender: TObject);
    procedure BxaSdxOlClick(Sender: TObject);
    procedure PlanSedexClick(Sender: TObject);
    procedure SedexOLTkTC2Click(Sender: TObject);
    procedure RepPrevPost_AROLClick(Sender: TObject);
    procedure SedexTKClick(Sender: TObject);
    procedure SedexTCClick(Sender: TObject);
    procedure SedexOLClick(Sender: TObject);
    procedure SigepSedex1Click(Sender: TObject);
    procedure SedexOLTKTC1Click(Sender: TObject);
    procedure ResumoArOL1Click(Sender: TObject);
    procedure SedexArOL1Click(Sender: TObject);
    procedure RetExtrConsorcioClick(Sender: TObject);
    procedure RetCrtSenhaClick(Sender: TObject);
    procedure ExtratoConsorciado1Click(Sender: TObject);
    procedure ExtratoConsorcioClick(Sender: TObject);
    procedure CrtSenhaClick(Sender: TObject);
    procedure ProdConsorcioClick(Sender: TObject);
    procedure ServnLidoClick(Sender: TObject);
    procedure RelFatDrcAvCobClick(Sender: TObject);
    procedure ProdDrcAvCobClick(Sender: TObject);
    procedure reltotClick(Sender: TObject);
    procedure DRCCLLPClick(Sender: TObject);
    procedure LerCLLPClick(Sender: TObject);
    procedure TesteClick(Sender: TObject);
    procedure ProdTokBxaClick(Sender: TObject);
    procedure ProdTokLidoClick(Sender: TObject);
    procedure RangeClick(Sender: TObject);
    procedure PostArDigClick(Sender: TObject);
    procedure CartoCrditoBradesco1Click(Sender: TObject);
    procedure FaturaCartodeCrdito1Click(Sender: TObject);
    procedure CaertodeCredito1Click(Sender: TObject);
    procedure AbreBaixa(tipo:integer);
    procedure Fechar1Click(Sender: TObject);
    procedure ExtratoConsolidado1Click(Sender: TObject);
    procedure ExtratoContaCorrentePoupana1Click(Sender: TObject);
    procedure BaixaClick(Sender: TObject);
    procedure UsuariosClick(Sender: TObject);
    procedure DigitarRcsClick(Sender: TObject);
    procedure RelatoriodeMovimentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastroporEMail1Click(Sender: TObject);
    procedure SucursalClick(Sender: TObject);
    procedure QuatroColunas1Click(Sender: TObject);
    procedure ImpBolRCSClick(Sender: TObject);
    procedure RelatoriodeProduo1Click(Sender: TObject);
    procedure RelatoriodeProduo2Click(Sender: TObject);
    procedure RelatoriodeProduo3Click(Sender: TObject);
    procedure RelatoriodeProduo4Click(Sender: TObject);
    procedure RelatoriodeFaturamento1Click(Sender: TObject);
    procedure RelatoriodeFaturamento2Click(Sender: TObject);
    procedure RelatoriodeFaturamento3Click(Sender: TObject);
    procedure RelatoriodeFaturamento4Click(Sender: TObject);
    procedure ExtratoUnificado3Click(Sender: TObject);
    procedure ExtratoConsolidado3Click(Sender: TObject);
    procedure ExtratoContaCorrentePoupana2Click(Sender: TObject);
    procedure ImpEtqRCSClick(Sender: TObject);
    procedure AgenciaClick(Sender: TObject);
    procedure RelatorioCartaParaAgencia1Click(Sender: TObject);
    procedure ExtratoUnificado1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DRCCobClick(Sender: TObject);
    procedure CadastrodeAssinantesClick(Sender: TObject);
    procedure EdiesArautoClick(Sender: TObject);
    procedure EtiquetasparaAssinantesClick(Sender: TObject);
    procedure EMDArautoClick(Sender: TObject);
    procedure mediClick(Sender: TObject);
    procedure mfilialClick(Sender: TObject);
    procedure mdfaixacepClick(Sender: TObject);
    procedure BaterCartoClick(Sender: TObject);
    procedure LojaClick(Sender: TObject);
    procedure DivisoClick(Sender: TObject);
    procedure CarregarClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure CadCliClick(Sender: TObject);
    procedure Bradesco1Click(Sender: TObject);
    procedure RelatoriodeProduo5Click(Sender: TObject);
    procedure RelatoriodeFaturamento5Click(Sender: TObject);
    procedure Bradesco2Click(Sender: TObject);
    procedure ImpProtocoloClick(Sender: TObject);
    procedure RelProtRCSClick(Sender: TObject);
    procedure ImpProtERCSClick(Sender: TObject);
    procedure Atalhos(var Teclado: TWMKey; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RelatoriodeProduo6Click(Sender: TObject);
    procedure RelatoriodeFaturamento6Click(Sender: TObject);
    procedure ExtratoCVM2Click(Sender: TObject);
    procedure RelatoriodeProduo7Click(Sender: TObject);
    procedure RelatoriodeProduo8Click(Sender: TObject);
    procedure ExtratoBancoPostal2Click(Sender: TObject);
    procedure ExtratoContaCorrenteClick(Sender: TObject);
    procedure RelatriodoContratodeLimitedeCrditoEspecial1Click(
      Sender: TObject);
    procedure SaidadeTokens1Click(Sender: TObject);
    procedure RelAgeClick(Sender: TObject);
    procedure DRCCrtAvisoClick(Sender: TObject);
    procedure DrcCobrancaClick(Sender: TObject);
    procedure DRCCartaConviteClick(Sender: TObject);
    procedure RelProdDrcCConvClick(Sender: TObject);
    procedure DRCRelFatCConvClick(Sender: TObject);
    procedure CrtSegurClick(Sender: TObject);
    procedure RetCrtSegClick(Sender: TObject);
    procedure RetCrtConvClick(Sender: TObject);
    procedure BrindesSecretariaClick(Sender: TObject);
    procedure RelBrindeSecrEntrClick(Sender: TObject);
    procedure RelBrindSecrSaiClick(Sender: TObject);
    procedure RetTokenClick(Sender: TObject);
    procedure CadCodEticaBradClick(Sender: TObject);
    procedure BxaCodEticaBradClick(Sender: TObject);
    procedure RetBxaCodEticaClick(Sender: TObject);
    procedure RetCadCodEticaClick(Sender: TObject);
    procedure PreTokenClick(Sender: TObject);
    procedure ImpCadCodEticaClick(Sender: TObject);
    procedure ImpBxaCodEticaClick(Sender: TObject);
    procedure ImpBxaTanCodeClick(Sender: TObject);
    procedure AltTokenClick(Sender: TObject);
    procedure TokenClick(Sender: TObject);
    procedure PlanTokClick(Sender: TObject);
    procedure PostaArClick(Sender: TObject);
    procedure SedexAr1Click(Sender: TObject);
    procedure ResumoARClick(Sender: TObject);
    procedure Faturamento1Click(Sender: TObject);
    procedure Faturamento2Click(Sender: TObject);
    procedure FaturamentoClick(Sender: TObject);
    procedure abretiposerv;
    procedure abreservnlido;
  private
    { Private declarations }
  public
   ambiente,codusu : integer;
   usuario : string;
   FrmNome: TForm;
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses U_ExtConsolidado, FrmExtContaCorrentePopanca, U_CadBaixa,
  U_CadUsu, U_Acesso, U_Dig_Christian_Science, U_PesqImp,
  U_CadAuto_Christian_Science, U_CadSucursal, U_ImpPrev, U_RetornoExtratos,
  U_CadAssinantes, U_CadEdicao, U_PesImpAssinantes, u_FrmMkEdi, u_FrmmKcep,
  u_FrmMkFilial, U_Cartao, U_FrmMkLoja, u_FrmMkdivisao, U_CadMakro,
  un_frmprint, Un_cadcli, U_FrmDigExtratoUnificado, UFrTokenBradesco,
  U_PreCadToken, U_AltTokens, U_FrmConsulta, U_CadSedex, U_PesqImpSedex,
  U_FrmRelArSedexLista, U_FrmRlTotRa, DmDados, U_FrmCadNLido, U_FrmRemessaSedex,
  U_FrmBxaSedex, U_FrmRemSdx, U_FrmBxaArqSdx, uGerarPlanilhaGeral, U_FrmPrintAr,
  U_FrmGeraListaPostagem, U_FrmConfig, U_FrmGeraRelatToken,
  U_FrmImprRelExtrBase, U_FrmCadToken;

{$R *.dfm}
procedure TFrmPrincipal.AbreBaixa(tipo:Integer);
begin
  with dm do
    begin
      SqlCga20.Close;
      SqlCga20.SQL.Clear;
      if FrmExtContaCorrentePoupanca <> nil then
        begin
          case FrmExtContaCorrentePoupanca.Tag of
            8:
              begin
                SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa = ''120'') order by cg20_descricao' );
              end;
            else
              begin
                case tipo of
                0: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa < ''118'') order by cg20_descricao' );
                1: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa = ''119'') order by cg20_descricao' );
                2: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa = ''120'') order by cg20_descricao' );
                3: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa = ''118'') order by cg20_descricao' );
                4: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa = ''121'') order by cg20_descricao' );
                5: SqlCga20.SQL.Add('select * from cga20 order by cg20_descricao' );
                end;
              end;
          end;
        end
      else if FrmExtConsolidado <> nil then
        begin
          case tipo of
          0: SqlCga20.SQL.Add('select * from cga20 where (cg20_codbaixa < ''118'') order by cg20_descricao' );
          end;
        end;
      SqlCga20.open;
    end;
end;
procedure TFrmPrincipal.Fechar1Click(Sender: TObject);
begin
  close;
end;

procedure TFrmPrincipal.FinCraCliClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('yyyymmdd',date)+formatdatetime('hhmmss',time)+format('%4.4d',[Dm.sqlcga_acessocodigo.Value]);
  FrmExtContaCorrentePoupanca.Tag := 55;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Carta Finasa - CLI';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength :=  07;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.ExtratoConsolidado1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtConsolidado,FrmExtConsolidado);
  AbreBaixa(0);
  FrmExtConsolidado.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ExtratoContaCorrentePoupana1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 1;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa de extratos Conta Corrente Poupan�a';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.BaixaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadBaixa,FrmCadBaixa);
  AbreBaixa(5);
  FrmCadBaixa.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.UsuariosClick(Sender: TObject);
begin
  Application.createform(TFrmCadUsu,FrmCadUsu);
  Dm.sqlcga_acesso.Close;
  Dm.sqlcga_acesso.Sql.Clear;
  Dm.sqlcga_acesso.Sql.Add('select * from cga_acesso');
  Dm.sqlcga_acesso.Open;
  FrmCadUsu.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.DigitarRcsClick(Sender: TObject);
begin
  Application.CreateForm(TFrmDigChristianSciense,FrmDigChristianSciense);
  FrmDigChristianSciense.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+IntToStr(Dm.sqlcga_acessocodigo.Value);
  FrmDigChristianSciense.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RelatoriodeMovimentoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 1;
  FrmPesqImp.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TFrmPrincipal.CadastroporEMail1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadAutoChristianSciense,FrmCadAutoChristianSciense);
  FrmCadAutoChristianSciense.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+IntToStr(Dm.sqlcga_acessocodigo.Value);
  Dm.SqlCga11.Open;
  FrmCadAutoChristianSciense.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.SucursalClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadSucursal,FrmCadSucursal);
  Dm.SqlTbBradDeptos.Open;
  FrmCadSucursal.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.QuatroColunas1Click(Sender: TObject);
begin
  application.CreateForm(TFrmImpPrevidencia,FrmImpPrevidencia);
  FrmImpPrevidencia.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ImpBolRCSClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 2;
  FrmPesqImp.ShowModal;
  setfocus;
end;

{ Prepara o formul�rio de Extrato Base para gerar Relat�rio de Extrato Consolidado }
procedure TFrmPrincipal.RelatoriodeProduo1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 1;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

{ Prepara o formul�rio de Extrato Base para gerar Relat�rio de Extrato Unificado }
procedure TFrmPrincipal.RelatoriodeProduo2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 5;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.RelatoriodeProduo3Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 6;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeProduo4Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 7;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeFaturamento1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 8;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeFaturamento2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 9;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeFaturamento3Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 10;
  FrmPesqImp.ShowModal;
end;
procedure TFrmPrincipal.RelatoriodeFaturamento4Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 11;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ExtratoUnificado3Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 4;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Unificado';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ExtratoConsolidado3Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 1;
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ExtratoConsorciado1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 45;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.ExtratoConsorcioClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmss',time);
  FrmExtContaCorrentePoupanca.Tag := 15;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Bradesco Adm. Cons�rcio';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.ExtratoContaCorrentePoupana2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 2;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Conta Corrente Poupan�a';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;


procedure TFrmPrincipal.ImpEtqRCSClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 12;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.AgenciaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadSucursal,FrmCadSucursal);
  Dm.SqlTbBradDeptos.Open;
  FrmCadSucursal.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RelatorioCartaParaAgencia1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 13;
  FrmPesqImp.EdAgIni.Enabled := true;
  FrmPesqImp.EdAgFin.Enabled := true;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ExtratoUnificado1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 2;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa de extratos Unificado';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := -1;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;
Function Saudacao : string;
begin
  result:='Boa-noite!';
 if (Time>=0.25) and (time<0.5) then
  result:='Bom-dia!';
 if (time>=0.5) and (time<0.80) then
  result:='Boa-tarde!';
end;

procedure TFrmPrincipal.TesteClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 5;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StsMenu.Panels[1].text:='Usu�rio: '+Dm.sqlcga_acessonome.AsString;
  StsMenu.Panels[2].text:=saudacao+' '+'Hoje � '+formatdatetime('dddddd',date);
  StsMenu.Panels[3].text:='Vers�o: 2.0.0';
  StsMenu.Panels[4].text:='Hor�rio: ' + timetostr(time);
  StsMenu.Panels[4].text:='23/09/2015 17:45';
end;

procedure TFrmPrincipal.DRCCobClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 3;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Baixa de Extratos DRC';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.CadastrodeAssinantesClick(Sender: TObject);
begin
  if FormatDateTime('ddmmyy',date) = InputBox('Digite a Senha','Senha','') then
    begin
      Application.CreateForm(TFrmCadAssinantes,FrmCadAssinantes);
      FrmCadAssinantes.ShowModal;
    end
  else
    begin
      Application.MessageBox('Senha Incorreta','')
    end;
 setfocus;
end;

procedure TFrmPrincipal.EdiesArautoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadEdicao,FrmCadEdicao);
  Dm.SqlCga07.Close;
  Dm.SqlCga07.Sql.Clear;
  Dm.SqlCga07.Sql.Add('select * from cga07 order by cg07_codedicao');
  Dm.SqlCga07.Open;
  FrmCadEdicao.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.EtiquetasparaAssinantesClick(Sender: TObject);
begin
 Application.CreateForm(TFrmPesImpAssinantes,FrmPesImpAssinantes);
 FrmPesImpAssinantes.ShowModal;
 SetFocus;
end;
procedure TFrmPrincipal.EMDArautoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 14;
  FrmPesqImp.ShowModal;
end;


procedure TFrmPrincipal.mediClick(Sender: TObject);
begin
   Application.CreateForm(TFrmMkCadEdi,FrmMkCadEdi);
   Dm.SqlCga105.Close;
   Dm.SqlCga105.Sql.Clear;
   dm.SqlCga105.Sql.Add('select * from cga105cadedi order by numedi');
   dm.SqlCga105.Open;
   FrmMkCadEdi.ShowModal;
end;

procedure TFrmPrincipal.MenuCadToken1A1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 52;
  AbreBaixa(1);
  FrmExtContaCorrentePoupanca.Caption:='Cadastro e Entrada de Tokens';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 25;
  FrmExtContaCorrentePoupanca.EdRemessa2.Visible := False;
  FrmExtContaCorrentePoupanca.EdRemessa2.Enabled := False;
  FrmExtContaCorrentePoupanca.Panel2.Caption  :=  'Cadastro e Entrada de Tokens';
  FrmExtContaCorrentePoupanca.Panel5.Visible  :=  False;
  FrmExtContaCorrentePoupanca.Panel5.Enabled  :=  False;
  FrmExtContaCorrentePoupanca.DbLkBaixa.KeyValue  :=  '119';
  FrmExtContaCorrentePoupanca.BtnFechaCxa.Enabled := true;
  FrmExtContaCorrentePoupanca.BtnFechaCxa.Visible := true;
  FrmExtContaCorrentePoupanca.BtnRecCxa.Enabled   := true;
  FrmExtContaCorrentePoupanca.BtnRecCxa.Visible   := true;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.MenuItemCadCaixaTokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadToken, FrmCadToken);
  FrmCadToken.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.MenuItemCadTokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 7;
  AbreBaixa(1);
  FrmExtContaCorrentePoupanca.Caption:='Entrada de Tokens';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 25;
  FrmExtContaCorrentePoupanca.EdRemessa2.Visible := False;
  FrmExtContaCorrentePoupanca.EdRemessa2.Enabled := False;
  FrmExtContaCorrentePoupanca.Panel2.Caption  :=  'Entrada';
  FrmExtContaCorrentePoupanca.Panel5.Visible  :=  False;
  FrmExtContaCorrentePoupanca.Panel5.Enabled  :=  False;
  FrmExtContaCorrentePoupanca.DbLkBaixa.KeyValue  :=  '119';
  FrmExtContaCorrentePoupanca.BtnFechaCxa.Enabled := true;
  FrmExtContaCorrentePoupanca.BtnFechaCxa.Visible := true;
  FrmExtContaCorrentePoupanca.BtnRecCxa.Enabled   := true;
  FrmExtContaCorrentePoupanca.BtnRecCxa.Visible   := true;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.mfilialClick(Sender: TObject);
begin
  Application.CreateForm(TFrmMkCadfilial,FrmMkCadfilial);
  dm.SqlCga107.Close;
  dm.SqlCga107.Sql.Clear;
  dm.SqlCga107.Sql.Add('select * from cga107cadfilial');
  dm.SqlCga107.Open;
  FrmMkcadfilial.ShowModal;
end;

procedure TFrmPrincipal.mdfaixacepClick(Sender: TObject);
begin
  Application.CreateForm(TFrmMkCep,FrmMkCep);
  dm.SqlCga108.Close;
  dm.SqlCga108.Sql.Clear;
  dm.SqlCga108.Sql.Add('select * from cga108cadfaixacep');
  dm.SqlCga108.Open;
  FrmMkCep.ShowModal;
end;

procedure TFrmPrincipal.BaterCartoClick(Sender: TObject);
begin
  Application.CreateForm(Tfrm_cartao,frm_cartao);
  frm_cartao.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.BitBtnPesagemClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex, FrmRemessaSedex);
  FrmRemessaSedex.Tag := 9;
  FrmRemessaSedex.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.BitBtnConfigClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConfig, FrmConfig);
  FrmConfig.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.BitBtnListaPostagemClick(Sender: TObject);
begin
  Application.CreateForm(TFrmGeraListaPostagem, FrmGeraListaPostagem);
  FrmGeraListaPostagem.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.BoletoCLIClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('yyyymmdd',date)+formatdatetime('hhmmss',time)+format('%4.4d',[Dm.sqlcga_acessocodigo.Value]);
  FrmExtContaCorrentePoupanca.Tag := 54;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Boletos Finasa - CLI';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength :=  11;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.LerCLLPClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 51;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa DRC - Aviso de Cobran�a - CLLP';
  FrmExtContaCorrentePoupanca.CheckBox1.Visible := False;
  FrmExtContaCorrentePoupanca.CboBoxTipoBxa.Visible := False;
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 29;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.lFatDrcCrtFatClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 53;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.LojaClick(Sender: TObject);
begin
   Application.CreateForm(TFrmMkLoja,FrmMkLoja,);
   Dm.SqlCga14.Close;
   Dm.SqlCga14.Sql.Clear;
   Dm.SqlCga14.Sql.Add('select * from cga14 order by cg14_codag');
   Dm.SqlCga14.Open;
   FrmMkLoja.ShowModal;
end;

procedure TFrmPrincipal.BxaManualSdxClick(Sender: TObject);
begin
  Application.CreateForm(TFrmBxaSedex,FrmBxaSedex);
  FrmBxaSedex.Tag :=  0;
  FrmBxaSedex.ShowModal;
  SetFocus;

end;
procedure TFrmPrincipal.DivisoClick(Sender: TObject);
begin

  Dm.sqlcga_acesso.Close;
  Dm.sqlcga_acesso.Sql.Clear;
  Dm.sqlcga_acesso.Sql.Add('select * from cga_acesso');
  Dm.sqlcga_acesso.Open;

  Dm.SqlCga109.Close;
  Dm.SqlCga109.Sql.Clear;
  Dm.SqlCga109.Sql.Add('select * from cga109cadloja order by descricao');
  Dm.SqlCga109.ExecSql;
  Dm.SqlCga109.Open;
  Application.createform(TFrmMkdivisao,FrmMkdivisao);
  FrmMkdivisao.ShowModal;
end;

procedure TFrmPrincipal.Carga_TokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPreCadToken,FrmPreCadToken);
  FrmPreCadToken.tag  :=  3;
  FrmPreCadToken.Caption  :=  'Carga de Token';
  FrmPreCadToken.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.CarregarClick(Sender: TObject);
begin
// Na tela abaixo n�o foi feita a convers�o

{    Application.CreateForm(TfrmMkmakro,frmMkmakro);
//Abre a tabela Edi��o em ordem
    dm.SqlCga105.Close;
    dm.SqlCga105.Sql.Clear;
    dm.SqlCga105.Sql.Add('select * from cga105cadedi order by numedi');
    dm.SqlCga105.ExecSql;
    dm.SqlCga105.Open;
//Abre a Tabela Divis�o
    dm.SqlCga106.Open;
//Abre a Tabela Loja em Ordem
    dm.SqlCga109.Close;
    dm.SqlCga109.Sql.Clear;
    dm.SqlCga109.Sql.Add('select * from cga109cadloja order by codloja');
    dm.SqlCga109.ExecSql;
    dm.SqlCga109.Open;
    FrmMkmakro.ShowModal;}
end;

procedure TFrmPrincipal.ImprimirClick(Sender: TObject);
begin
   Application.CreateForm(TfrmMkPrint,frmMkPrint);
   dm.SqlCga109.Close;
   dm.SqlCga107.Close;
   dm.SqlCga109.Sql.Clear;
   dm.SqlCga107.Sql.Clear;
   dm.SqlCga109.Sql.Add('select * from cga109cadloja order by codloja');
   dm.SqlCga107.Sql.Add('select * from cga107cadfilial nomefilial');

   dm.SqlCga109.Open;
   dm.SqlCga107.Open;
   frmMkprint.ShowModal;
end;

procedure TFrmPrincipal.IProdExtFPEClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 46;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.IRetFPEClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 47;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.CadCliClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCadcli,frmCadcli);
  FrmCadcli.ShowModal;
end;

procedure TFrmPrincipal.Bradesco1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 4;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 32;
  FrmExtContaCorrentePoupanca.Caption:='Baixa de extratos Cart�o Bradesco';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RelatoriodeProduo5Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 16;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeFaturamento5Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 15;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.Bradesco2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 6;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Cart�o Bradesco';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ImpProtocoloClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 17;
  FrmPesqImp.ChePlanilia.Visible:=False;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RangeClick(Sender: TObject);
begin
  application.CreateForm(TfrmCadSedex,frmCadSedex);
  frmCadSedex.Tag := 1;
  frmCadSedex.showmodal;

end;


procedure TFrmPrincipal.RAROLClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  3;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.RARTCClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  4;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.RARTKClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  5;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.RelProtRCSClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 18;
  FrmPesqImp.ChePlanilia.Visible:=False;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ImpProtERCSClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 19;
  FrmPesqImp.ChePlanilia.Visible:=False;
  FrmPesqImp.MkEdDtIni.Enabled:=False;
  FrmPesqImp.MkEdDtFin.Enabled:=False;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.Atalhos(var Teclado: TWMKey;
  var Handled: Boolean);
begin

 { Esse procedimento pega as teclas abaixo como
   atalho, e pode ser usado em todo o programa.
   Isso pode ser poss�vel usando a variavel TForm
   Frm_Nome, fazendo com que ela receba o TForm
   correspondente ao formulario que esta sendo usado
 }
  case Teclado.CharCode of
    VK_F3     : Close;
    VK_ESCAPE :
      begin
        if not (FrmPrincipal.FrmNome=FrmPrincipal) then
          FrmNome.Close();
      end;
    VK_F1     : Close;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Application.OnShortCut:= FrmPrincipal.Atalhos;
  FrmPrincipal.FrmNome  := FrmPrincipal;
end;

procedure TFrmPrincipal.GERFCLI01Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 17;
  FrmRetornoExtratos.Caption := 'Retorno: Boleto Finasa CLI';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.GERFCRT01Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 18;
  FrmRetornoExtratos.Caption := 'Retorno: Carta Finasa CLI';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.GERFPE001Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 16;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Finasa FPE';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

{ Prepara o formul�rio de Extrato Base para gerar Relat�rio de Extrato CVM/INVE }
procedure TFrmPrincipal.RelatoriodeProduo6Click(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 7;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.RelatoriodeFaturamento6Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 21;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ExtratoCVM2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 5;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa de Extratos CVM/INVE';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 26;
  FrmExtContaCorrentePoupanca.EdRemessa2.MaxLength := 35;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ExtratoPFEClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('yyyymmdd',date)+formatdatetime('hhmmss',time)+format('%4.4d',[Dm.sqlcga_acessocodigo.Value]);
  FrmExtContaCorrentePoupanca.Tag := 53;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Baixa de Extratos Finasa - PFE';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength :=  35;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.RelatoriodeProduo7Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 22;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.RelatoriodeProduo8Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 23;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ExtratoBancoPostal2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 6;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa de extratos Banco Postal';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 17 ;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ExtratoContaCorrenteClick(Sender: TObject);
begin
  Application.CreateForm(TFrmDigExtratoUnificado,FrmDigExtratoUnificado);
  FrmDigExtratoUnificado.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  AbreBaixa(0);
  FrmDigExtratoUnificado.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RelatriodoContratodeLimitedeCrditoEspecial1Click(
  Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 24;
  FrmPesqImp.MkEdDtIni.Enabled  := false;
  FrmPesqImp.MkEdDtFin.Enabled  := false;
  FrmPesqImp.EdAgIni.Enabled    := true;
  FrmPesqImp.EdAgFin.Enabled    := true;
  FrmPesqImp.ShowModal;
end;


procedure TFrmPrincipal.SaidadeTokens1Click(Sender: TObject);
Begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 8;
  AbreBaixa(2);//AbreBaixa;
  FrmExtContaCorrentePoupanca.DbLkBaixa.KeyValue  := '120';
  FrmExtContaCorrentePoupanca.Caption:='Sa�da de Tokens';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength  := 25;
  FrmExtContaCorrentePoupanca.EdRemessa2.MaxLength := 35;
  FrmExtContaCorrentePoupanca.Panel5.Caption       := 'Ag�ncia';
  FrmExtContaCorrentePoupanca.Panel5.Top           := 48;
  FrmExtContaCorrentePoupanca.Panel5.Width         := 80;
  FrmExtContaCorrentePoupanca.Panel4.Top           := 85;
  FrmExtContaCorrentePoupanca.Panel4.Width         := 80;
  FrmExtContaCorrentePoupanca.EdRemessa.Top        := 86;
  FrmExtContaCorrentePoupanca.EdRemessa.Width      := 269;
  FrmExtContaCorrentePoupanca.EdRemessa2.Top       := 49;
  FrmExtContaCorrentePoupanca.EdRemessa2.Width     := 80;
  FrmExtContaCorrentePoupanca.EdRemessa.TabOrder   := 5;
  FrmExtContaCorrentePoupanca.EdRemessa2.TabOrder  := 4;
  FrmExtContaCorrentePoupanca.EdRemessa2.MaxLength := 5;
  FrmExtContaCorrentePoupanca.Edremessa2.Tag       := 5;
  FrmExtContaCorrentePoupanca.RdGrptipocli.Top     := 80;
  FrmExtContaCorrentePoupanca.Ednumlote.Top        := 49;
  FrmExtContaCorrentePoupanca.Ednumlote.TabOrder   := 5;
  FrmExtContaCorrentePoupanca.Panel6.Top           := 48;
  FrmExtContaCorrentePoupanca.EdQt.Width           := 70;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
End;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
  close;
end;

procedure TFrmPrincipal.SairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPrincipal.ReenvArTkClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex, FrmRemessaSedex);
  FrmRemessaSedex.Tag := 8;
  FrmRemessaSedex.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.RelAgeClick(Sender: TObject);
begin
  Application.CreateForm(TFrmGeraRelatToken, FrmGeraRelatToken);
  FrmGeraRelatToken.ShowModal;
end;

procedure TFrmPrincipal.DRCCrtAvisoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  with dm do
  begin
    SqlAux2.Close;
    SqlAux2.SQL.Clear;
    SqlAux2.SQL.Add('select now()');
    SqlAux2.Open;
    FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',SqlAux2.Fields[0].AsDateTime)
    +formatdatetime('hhmmssn',SqlAux2.Fields[0].AsDateTime);
  end;
  FrmExtContaCorrentePoupanca.Tag := 9;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Baixa de Carta Aviso DRC ';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 17;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCCrtFatClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 20;
  FrmRetornoExtratos.Caption := 'Retorno: Cart�o Fatura';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.DrcCobrancaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 3;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato DRC Cobran�a';
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCBolAmexClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 22;
  FrmRetornoExtratos.Caption := 'Retorno: DRC - Boleto Amex';
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCCartaConviteClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 7;
  FrmRetornoExtratos.Caption := 'Retorno: DRC Carta Convite';
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCCLLPClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 13;
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.RelPedOlTcTkClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 14;
  FrmPesqImpSedex.BtnSalvar.Caption :=  '&Gravar';
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpsedex.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.RelPendOLTCTKClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 15;
  FrmPesqImpSedex.BtnSalvar.Caption :=  '&Gerar';
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpsedex.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.RelPredDrcAmexClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 56;
  FrmPesqImp.ShowModal;
  SetFocus;


end;

procedure TFrmPrincipal.RelProdDrcCConvClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 26;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.RelProdDrcCrtFATClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 52;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.RelProdDrcZogMCSIClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 54;
  FrmPesqImp.ShowModal;
  SetFocus;


end;

procedure TFrmPrincipal.reltotClick(Sender: TObject);
begin
  //Application.MessageBox('Em Desenvolvimento !','ADS',64);
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 41;
  FrmPesqImp.Panel3.Visible := true;
  FrmPesqImp.Panel4.Visible := true;
  FrmPesqImp.MkEdDtTIni.Visible := true;
  FrmPesqImp.MkEdDtTIni.Enabled := true;
  FrmPesqImp.MkEdDtTFin.Visible := true;
  FrmPesqImp.MkEdDtTFin.Enabled := true;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.DRCPrivLblClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 56;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Extratos DRC - Private Label';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCPrvLblClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 19;
  FrmRetornoExtratos.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.DRCRelFatCConvClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 27;
  FrmPesqImp.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.DRCs1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 57;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Extratos DRCs';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.DRCZogMsciClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 21;
  FrmRetornoExtratos.Caption := 'Retorno: DRC - Zogbi MSCI';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.CrtSegurClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 10;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption :='Cart�o de Seguran�a TanCode';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := -1;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;


procedure TFrmPrincipal.CrtSenhaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmss',time);
  FrmExtContaCorrentePoupanca.Tag := 14;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Bradesco Adm. Cons�rcio';
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetCrtSegClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 8;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Cart�o Seguran�a';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetCrtSenhaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 14;
  FrmRetornoExtratos.Caption := 'Retorno: Carta Senha';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetExtrConsorcioClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 15;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Recibo Consorciado';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetEntregClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 13;
  FrmPesqImpSedex.BtnSalvar.Caption :=  '&Gravar';
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpsedex.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetCrtConvClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 5;
  FrmRetornoExtratos.Caption := 'Retorno: Extrato Cart�o Convencional';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.BrindesSecretariaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 12;
  AbreBaixa(4);
  FrmExtContaCorrentePoupanca.Caption :='Baixa de Brindes Secret�ria';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 20;
  FrmExtContaCorrentePoupanca.DbLkBaixa.Enabled :=  false;
//  FrmExtContaCorrentePoupanca.DbLkBaixa.Visible :=
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;


procedure TFrmPrincipal.RelBrindeSecrEntrClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 30;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.RelBrindSecrSaiClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 31;
  FrmPesqImp.ShowModal;

end;


procedure TFrmPrincipal.RelFatDrcAvCobClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 43;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.RetTokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 10;
  FrmRetornoExtratos.Caption := 'Retorno: Token';
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;


procedure TFrmPrincipal.RFatSdxClick(Sender: TObject);
begin
Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
FrmPesqImpSedex.Tag := 4;
FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
FrmPesqImpSedex.Panel3.Visible  :=  true;
FrmPesqImpsedex.ShowModal;

end;

procedure TFrmPrincipal.BxaArqSdxClick(Sender: TObject);
begin
  Application.CreateForm(TFrmBxaArqSdx,FrmBxaArqSdx);
  FrmBxaArqSdx.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.BxaCodEticaBradClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 13;
  //AbreBaixa;
  FrmExtContaCorrentePoupanca.Caption :='Baixa de C�digo de �tica';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 20;
  FrmExtContaCorrentePoupanca.DbLkBaixa.Enabled :=  false;
  FrmExtContaCorrentePoupanca.DbLkBaixa.Visible :=  false;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.BxaSdxOlClick(Sender: TObject);
begin
  Application.CreateForm(TFrmBxaSedex,FrmBxaSedex);
  FrmBxaSedex.Tag :=  0;
  FrmBxaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.BxaSdxTcClick(Sender: TObject);
begin
  Application.CreateForm(TFrmBxaSedex,FrmBxaSedex);
  FrmBxaSedex.Tag :=  1;
  FrmBxaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.BxaSdxTkClick(Sender: TObject);
begin
  Application.CreateForm(TFrmBxaSedex,FrmBxaSedex);
  FrmBxaSedex.Tag :=  2;
  FrmBxaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.CadCodEticaBradClick(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 11;
  AbreBaixa(3);
  FrmExtContaCorrentePoupanca.Caption :='Cadastro de C�digo de �tica';
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 20;
  FrmExtContaCorrentePoupanca.DbLkBaixa.Enabled :=  false;
//  FrmExtContaCorrentePoupanca.DbLkBaixa.Visible :=  false;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.CaertodeCredito1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmExtContaCorrentePoupanca,FrmExtContaCorrentePoupanca);
  FrmExtContaCorrentePoupanca.EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
  FrmExtContaCorrentePoupanca.Tag := 50;
  AbreBaixa(0);
  FrmExtContaCorrentePoupanca.Caption:='Baixa Fatura de Cart�o de Cr�dito';
  FrmExtContaCorrentePoupanca.CheckBox1.Visible := False;
  FrmExtContaCorrentePoupanca.CboBoxTipoBxa.Visible := False;
  FrmExtContaCorrentePoupanca.EdRemessa.MaxLength := 34;
  FrmExtContaCorrentePoupanca.ShowModal;
  setfocus;
end;


procedure TFrmPrincipal.RetBxaCodEticaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 9;
  FrmRetornoExtratos.Caption := 'Retorno: Baixa C�digo de �tica';
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RetCadCodEticaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 11;
  FrmRetornoExtratos.Caption := 'Retorno: Cadastro C�digo de �tica';
  FrmRetornoExtratos.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.PreBrindesClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPreCadToken,FrmPreCadToken);
  FrmPreCadToken.tag  :=  4;
  FrmPreCadToken.Caption  :=  'Cadastro Pr�-Brindes';
  FrmPreCadToken.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.precargamenuitemClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPreCadToken, FrmPreCadToken);
  FrmPreCadToken.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.PreTanCodeClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPreCadToken,FrmPreCadToken);
  FrmPreCadToken.tag  :=  2;
  FrmPreCadToken.Caption  :=  'Cadastro Pr�-TanCode';
  FrmPreCadToken.ShowModal;
  setfocus;

end;

procedure TFrmPrincipal.PreTokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPreCadToken,FrmPreCadToken);
  FrmPreCadToken.tag  :=  0;
  FrmPreCadToken.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.RepPrevPost_AROLClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 9;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;

end;

procedure TFrmPrincipal.ProdConsorcioClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 44;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.ProdDrcAvCobClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 42;
  FrmPesqImp.ShowModal;

end;

procedure TFrmPrincipal.ProdTokBxaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 32;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.ProdTokLidoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 39;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.PreOLClick(Sender: TObject);
begin
 Application.CreateForm(TFrmPreCadToken,FrmPreCadToken);
  FrmPreCadToken.tag  :=  1;
  FrmPreCadToken.Caption  :=  'Cadastro Pr�-OL';
  FrmPreCadToken.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.ProdDrcPrvClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 49;
  FrmPesqImp.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.ImpCadCodEticaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 29;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.IBolCliClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 47;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.ICrtCLIClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 48;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.IExtFPEClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 46;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.ImpBxaCodEticaClick(Sender: TObject);
begin
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 33;
  FrmPesqImp.ShowModal;
  SetFocus;
end;

end;

{ Prepara formul�rio para gerar relat�rio de Tancodes }
procedure TFrmPrincipal.ImpBxaTanCodeClick(Sender: TObject);
begin
  Application.CreateForm(TFrmImprRelExtrBase, FrmImprRelExtrBase);
  FrmImprRelExtrBase.Tag := 6;
  FrmImprRelExtrBase.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.AltTokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmAltToken, FrmAltToken);
  FrmAltToken.ShowModal;
  SetFocus
end;

procedure TFrmPrincipal.AnaliticoClick(Sender: TObject);
begin
 Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 40;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ARPendClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 12;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  false;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  false;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.ImprimeARsClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPrintAr, FrmPrintAr);
  FrmPrintAr.ShowModal;
end;

procedure TFrmPrincipal.TokenClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConsulta,FrmConsulta);
  FrmConsulta.ShowModal;

end;

procedure TFrmPrincipal.PesqSedexClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  6;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.PlanilhaGeral1Click(Sender: TObject);
begin
  fGerarPlanilhaGeral := TfGerarPlanilhaGeral.Create(Self);
  fGerarPlanilhaGeral.ShowModal;
  fGerarPlanilhaGeral.Release;
end;

procedure TFrmPrincipal.PlanSedexClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag                     := 11;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible          :=  true;
  FrmPesqImpSedex.BtnSalvar.Caption       :=  'Gerar';
  FrmPesqImpSedex.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.PlanTokClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag                  := 34;
  FrmPesqImp.Panel1.Caption       :=  'Lote';
  FrmPesqImp.EdAgIni.Enabled      :=  true;
  FrmPesqImp.EdAgFin.Enabled      :=  false;
  FrmPesqImp.MkEdDtIni.Enabled    :=  false;
  FrmPesqImp.MkEdDtFin.Enabled    :=  false;
  FrmPesqImp.RdGrpTipo.Enabled    :=  false;
  FrmPesqImp.ChePlanilia.Enabled  :=  false;
  FrmPesqImp.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.PostArDigClick(Sender: TObject);
begin
Application.CreateForm(TFrmPesqImpSedex, FrmPesqImpSedex);
FrmPesqImpSedex.Tag := 3;
FrmPesqImpSedex.DateTimePicker3.Visible := true;
FrmPesqImpSedex.DateTimePicker3.Enabled := true;
FrmPesqImpSedex.Panel3.Visible := true;
FrmPesqImpsedex.ShowModal;

end;

procedure TFrmPrincipal.PostaArClick(Sender: TObject);
begin
  application.CreateForm(TfrmCadSedex,frmCadSedex);
  frmCadSedex.showmodal;
end;

procedure TFrmPrincipal.CartoCrditoBradesco1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 38;
  FrmPesqImp.ShowModal;
end;



procedure TFrmPrincipal.SedexAr1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 0;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;
end;

procedure TFrmPrincipal.SedexArOL1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 6;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;
end;

procedure TFrmPrincipal.SedexKVClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemSdx,FrmRemSdx);
  FrmRemSdx.Tag :=  0;
  FrmRemSdx.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.SedexOLClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex, FrmRemessaSedex);
  FrmRemessaSedex.Tag := 9;
  FrmRemessaSedex.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.SedexOLTKTC1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 9;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpsedex.ShowModal;

end;

procedure TFrmPrincipal.SedexOLTkTC2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 10;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpsedex.ShowModal;
end;

procedure TFrmPrincipal.SedexTCClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  1;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.SedexTKClick(Sender: TObject);
begin
  Application.CreateForm(TFrmRemessaSedex,FrmRemessaSedex);
  FrmRemessaSedex.Tag :=  2;
  FrmRemessaSedex.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.ServnLidoClick(Sender: TObject);
begin
  abreservnlido;
  abretiposerv;
  Application.CreateForm(TFrmCadNLido,FrmCadNlido);
  FrmCadNlido.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.SigepSedex1Click(Sender: TObject);
begin
Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
FrmPesqImpSedex.Tag := 8;
FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
FrmPesqImpSedex.Panel3.Visible  :=  true;
FrmPesqImpsedex.ShowModal;
end;

procedure TFrmPrincipal.SinteticoClick(Sender: TObject);
begin
 Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 51;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.ResumoARClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 1;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;

end;

procedure TFrmPrincipal.ResumoArOL1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImpSedex,FrmPesqImpSedex);
  FrmPesqImpSedex.Tag := 7;
  FrmPesqImpSedex.DateTimePicker3.Visible :=  true;
  FrmPesqImpSedex.DateTimePicker3.Enabled :=  true;
  FrmPesqImpSedex.Panel3.Visible  :=  true;
  FrmPesqImpSedex.ShowModal;
end;

procedure TFrmPrincipal.FatDrcPrvClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 50;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.FaturaCartodeCrdito1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRetornoExtratos,FrmRetornoExtratos);
  FrmRetornoExtratos.Tag := 12;
  FrmRetornoExtratos.ShowModal;
  setfocus;
end;

procedure TFrmPrincipal.Faturamento1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 35;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.Faturamento2Click(Sender: TObject);
begin
Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 36;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.FaturamentoClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 37;
  FrmPesqImp.ShowModal;
end;

procedure TFrmPrincipal.IFatDrcAmexClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 57;
  FrmPesqImp.ShowModal;
  SetFocus;
end;

procedure TFrmPrincipal.IFatDRCZogMcsiClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPesqImp,FrmPesqImp);
  FrmPesqImp.Tag := 55;
  FrmPesqImp.ShowModal;
  SetFocus;

end;

procedure TFrmPrincipal.abretiposerv;
begin
  with dm do
    begin
      SqlServico.Close;
      SqlServico.SQL.Clear;
      SqlServico.SQL.Add('select * from ads002_servicos order by ads02serv_nome');
      try SqlServico.Open;
      except on e:exception do
        begin
          Application.MessageBox(Pchar('N�o foi poss�vel Abrir a Tabela de Servi�os!'+e.Message),'ADS',64);
          exit;
        end;
      end;
    end;
end;
procedure TFrmPrincipal.abreservnlido;
begin
  with dm do
    begin
      SqlServNLido.Close;
      SqlServNLido.SQL.Clear;
      SqlServNLido.SQL.Add('select * from ads005_servnaolido order by ads05servnlido_codserv');
      try SqlServNLido.Open;
      except on e:exception do
        begin
          Application.MessageBox(Pchar('N�o foi poss�vel Abrir a Tabela de Servi�os N�o Lidos!'+e.Message),'ADS',64);
          exit;
        end;
      end;
    end;
end;
end.
