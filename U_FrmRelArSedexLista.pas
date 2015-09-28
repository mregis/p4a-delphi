unit U_FrmRelArSedexLista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRelArSedexLista = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    Lista: TRLLabel;
    cabsedex: TRLLabel;
    Codigo: TRLLabel;
    Numero: TRLLabel;
    RLLabel1: TRLLabel;
    ltotfol: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
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
    ordem: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    Label34: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLBand3: TRLBand;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    private
    seq:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelArSedexLista: TFrmRelArSedexLista;

implementation

uses DmDados, U_PesqImpSedex, U_Func, U_FrmRlTotRa;

{$R *.dfm}

procedure TFrmRelArSedexLista.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
//  QTDE.Caption:= dm.SqlAux1.Fields[0].AsString;
//  QTDE.Caption:= '20';
//ltotfol.Caption :=ltotfol.Caption + inttostr(FrmPesqImpSedex.totfol);
  RLLabel33.Caption :=  formatdatetime('dd/mm/yyyy',date);
end;



procedure TFrmRelArSedexLista.RLBand2AfterPrint(Sender: TObject);
begin
if dm.SqlSdx2.Eof then
  RLBand3.Visible   := true;
  RLLabel39.Caption := FrmPesqImpSedex.fxaini;
  RLLabel40.Caption := FrmPesqImpSedex.fxafim;
  RLLabel41.Caption := GeraNt(inttostr(FrmPesqImpSedex.qtdar),4);

end;

procedure TFrmRelArSedexLista.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  seq  :=  seq+1;
  ordem.Caption  :=   gerant(inttostr(seq),4);
//  if dm.SqlSdx2.eof then
//  begin
//  end;

end;


end.
