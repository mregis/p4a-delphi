unit U_FrmRlTotRa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRlTotalRa = class(TForm)
    RLRTotalRa: TRLReport;
    RLBand1: TRLBand;
    Lista: TRLLabel;
    cabsedex: TRLLabel;
    Codigo: TRLLabel;
    Numero: TRLLabel;
    RLLabel1: TRLLabel;
    GRAMAS: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel59: TRLLabel;
    RLLabel60: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel23: TRLLabel;
    NUM: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel68: TRLLabel;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel99: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel4: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRlTotalRa: TFrmRlTotalRa;

implementation

uses DmDados, U_FrmRelArSedex, U_FrmRelArSedexLista, U_PesqImpSedex, U_Func;

{$R *.dfm}


procedure TFrmRlTotalRa.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
//  QTDE.Caption:= dm.SqlAux1.Fields[0].AsString;
//  QTDE.Caption:= '20';
  NUM.Caption:= gerant(inttostr(FrmPesqImpSedex.totfol),4);
  RLLabel54.Caption :=  formatdatetime('dd/mm/yyyy',date);
  RLLabel55.Caption :=  formatdatetime('dd/mm/yyyy',date);
  RLLabel56.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa01);
  RLLabel57.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa02);
  RLLabel58.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa03);
  RLLabel59.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa04);
  RLLabel66.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa05);
  RLLabel67.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa06);
  RLLabel68.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa07);
  RLLabel69.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa08);
  RLLabel70.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa09);
  RLLabel71.Caption :=  inttostr(FrmPesqImpSedex.qtdfxa10);

{  RLLabel56.Caption :=  inttstr(FrmPesqImpSedex.qtdcepcap);
//  RLLabel56.Caption :=  '20';
  RLLabel57.Caption :=  inttostr(FrmPesqImpSedex.qtdcepest);
  RLLabel58.Caption :=  inttostr(FrmPesqImpSedex.qtdcepnac1);
  RLLabel59.Caption :=  inttostr(FrmPesqImpSedex.qtdcepnac2);}
  RLLabel83.Caption :=  GeraNt(inttostr(FrmPesqImpSedex.totfol),4);
  RLLabel100.Caption :=  'DB'+FrmPesqImpSedex.fxaIni;
  RLLabel101.Caption :=  'DB'+FrmPesqImpSedex.fxaFim;
  RLLabel102.Caption :=  GeraNt(inttostr(FrmPesqImpSedex.qtdar),4);

end;

end.
