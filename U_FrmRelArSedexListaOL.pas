unit U_FrmRelArSedexListaOL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRelArSedexListaOl = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    Lista: TRLLabel;
    cabsedex: TRLLabel;
    Codigo: TRLLabel;
    Numero: TRLLabel;
    RLLabel1: TRLLabel;
    ltotfol: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    QTDE: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    Label34: TRLLabel;
    RLLabel34: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    ordem: TRLLabel;
    RLLabel42: TRLLabel;
    RLBand3: TRLBand;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel3: TRLLabel;
    LblPeso: TRLLabel;
    LblValor: TRLLabel;
    RLLabel47: TRLLabel;
    valdec: TRLLabel;
    RLDraw3: TRLDraw;
    RLLabel35: TRLLabel;
    RLLabel48: TRLLabel;
    RLDraw4: TRLDraw;
    RLLabel49: TRLLabel;
    RLDBText5: TRLDBText;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
  seq:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelArSedexListaOl: TFrmRelArSedexListaOl;

implementation


Uses DmDados, U_PesqImpSedex, U_Func, U_FrmRlTotRa ;

{$R *.dfm}


procedure TFrmRelArSedexListaOl.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLLabel33.Caption :=  formatdatetime('dd/mm/yyyy',date);
  QTDE.Caption      :=  FormatFloat('#,##0.000;;',dm.SqlAux3.Fields[0].AsFloat );
  valdec.Caption    :=  FormatFloat('##,##0.00;;',dm.SqlAux3.Fields[1].AsFloat );
end;

procedure TFrmRelArSedexListaOl.RLBand2AfterPrint(Sender: TObject);
begin
if dm.SqlSdx3.Eof then
  RLBand3.Visible   := true;
  RLLabel39.Caption := FrmPesqImpSedex.fxaini;
  RLLabel40.Caption := FrmPesqImpSedex.fxafim;
  RLLabel41.Caption := GeraNt(inttostr(FrmPesqImpSedex.qtdar),4);
end;

procedure TFrmRelArSedexListaOl.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  seq               :=  seq+1;
  ordem.Caption     :=  gerant(inttostr(seq),4);
  LblPeso.Caption   :=  formatfloat('#,##0.000;;',Dm.SqlSdx3sdx_peso.Value);
  LblValor.Caption  :=  formatfloat('##,##0.00;;',Dm.SqlSdx3sdx_valdec.Value);
end;



end.
