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
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
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
    RLDBText8: TRLDBText;
    ordem: TRLLabel;
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
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText9: TRLDBText;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    seq: integer;
  public
    { Public declarations }
    pesoTotal, valDecTotal : Extended;
    qtObjs : Integer;
    objIni, objFim : string;
  end;

var
  FrmRelArSedexListaOl: TFrmRelArSedexListaOl;

implementation


Uses DmDados, U_PesqImpSedex, U_Func, U_FrmRlTotRa , DB, ZDataset;

{$R *.dfm}


procedure TFrmRelArSedexListaOl.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  // Retro compatibilidade ap�s tornar formulario atual independente
  // do formul�rio chamador
  try
    if (pesoTotal = null) AND (dm.SqlAux3.FieldCount > 0) then
      begin
        pesoTotal := dm.SqlAux3.Fields[0].AsFloat;
        valDecTotal := dm.SqlAux3.Fields[1].AsFloat;
      end;
  except
     pesoTotal := 0.00;
     valDecTotal := 0.00;
  end;

  RLLabel33.Caption :=  formatdatetime('dd/mm/yyyy', Date);
  QTDE.Caption      :=  FormatFloat('#,##0.000;;', pesoTotal);
  valdec.Caption    :=  FormatFloat('##,##0.00;;', valDecTotal);
end;

procedure TFrmRelArSedexListaOl.RLBand2AfterPrint(Sender: TObject);
begin
  try
    if (objIni = null) AND
       (FrmPesqImpSedex <> nil) AND
       (FrmPesqImpSedex.fxaini <> null ) then
      objIni := FrmPesqImpSedex.fxaini;

    if (objFim = null) AND
       (FrmPesqImpSedex <> nil) AND
       (FrmPesqImpSedex.fxafim <> null) then
      objFim := FrmPesqImpSedex.fxafim;

    if (qtObjs = null) AND
       (FrmPesqImpSedex <> nil) AND
       (FrmPesqImpSedex.qtdar <> null) then
      qtObjs := FrmPesqImpSedex.qtdar;

  Except
    objIni := '0';
    objFim := '0';
    qtObjs := 0;
  end;

// if dm.SqlSdx3.Eof then
  RLBand3.Visible   := true;
  RLLabel39.Caption := objIni;
  RLLabel40.Caption := objFim;
  RLLabel41.Caption := Format('%.4d', [qtObjs]);
end;

procedure TFrmRelArSedexListaOl.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  seq               :=  seq + 1;
  ordem.Caption     :=  Format('%.4d', [seq]);
  LblPeso.Caption   :=  formatfloat('#,##0.000;;', Dm.SqlSdx3sdx_peso.Value);
  LblValor.Caption  :=  formatfloat('##,##0.00;;', Dm.SqlSdx3sdx_valdec.Value);
end;



end.
