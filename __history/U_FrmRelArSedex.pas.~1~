unit U_FrmRelArSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, StdCtrls, RLBarcode, jpeg;

type
  TFrmRelArSedex = class(TForm)
    RLReport1: TRLReport;
    RLBand2: TRLBand;
    RLDraw1: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw12: TRLDraw;
    RLLabel3: TRLLabel;
    RLImage1: TRLImage;
    RLDBText1: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText11: TRLDBText;
    RLDBBarcode1: TRLDBBarcode;
    RLDBText12: TRLDBText;
    RLDBBarcode2: TRLDBBarcode;
    RLDBText3: TRLDBText;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLImage2: TRLImage;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLDraw15: TRLDraw;
    RLLabel33: TRLLabel;
    RLDraw16: TRLDraw;
    RLLabel34: TRLLabel;
    RLDraw17: TRLDraw;
    RLLabel35: TRLLabel;
    RLDraw18: TRLDraw;
    RLLabel36: TRLLabel;
    RLDraw19: TRLDraw;
    RLLabel37: TRLLabel;
    RLDraw20: TRLDraw;
    RLLabel38: TRLLabel;
    RLDraw21: TRLDraw;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLDraw22: TRLDraw;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    RLDBBarcode5: TRLDBBarcode;
    RLDBText17: TRLDBText;
    RLLabel69: TRLLabel;
    RLLabel68: TRLLabel;
    RLImage3: TRLImage;
    RLLabel20: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLDraw3: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw14: TRLDraw;
    RLLabel32: TRLLabel;
    RLDraw40: TRLDraw;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLDraw38: TRLDraw;
    procedure RLDraw12BeforePrint(Sender: TObject; var PrintIt: Boolean);

    //procedure RLDraw1AfterPrint(Sender: TObject);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelArSedex: TFrmRelArSedex;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmRelArSedex.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  var
    v_cep  : string;
    v_cep1 : string;
    v_cep2 : string;
begin
//     RlcidUf.Caption := Dm.SqlSdx2.Fields[9].AsString + '  ' +  Dm.SqlSdx2.Fields[10].AsString;
 //    RlcidUfb.Caption := Dm.SqlSdx2.Fields[9].AsString + '  ' +  Dm.SqlSdx2.Fields[10].AsString;
end;

procedure TFrmRelArSedex.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
RLLabel68.Caption := Dm.SqlSdx2.Fields[9].AsString + '  ' +  Dm.SqlSdx2.Fields[10].AsString;
RLLabel69.Caption := Dm.SqlSdx2.Fields[9].AsString + '  ' +  Dm.SqlSdx2.Fields[10].AsString;
end;


procedure TFrmRelArSedex.RLDraw12BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLLabel18.Caption  :=  copy(Dm.SqlSdx2sdx_numobj2.AsString,1,2);
end;

end.
