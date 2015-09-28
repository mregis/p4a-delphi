unit UFrmRelArSedexOL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, RLBarcode, RLReport;

type
  TFrmRelArSedexOl = class(TForm)
    RLReport1: TRLReport;
    RLBand2: TRLBand;
    RLDraw1: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw12: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLImage1: TRLImage;
    RLDBText1: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText11: TRLDBText;
    RLDBBarcode1: TRLDBBarcode;
    RLDBText12: TRLDBText;
    RLDBBarcode2: TRLDBBarcode;
    RlcidUf: TRLLabel;
    Rlcep: TRLLabel;
    RlCidUfb: TRLLabel;
    RlCepb: TRLLabel;
    RLImage3: TRLImage;
    RLLabel43: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLImage2: TRLImage;
    RLLabel26: TRLLabel;
    RLDraw13: TRLDraw;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLDraw14: TRLDraw;
    RLLabel32: TRLLabel;
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
    RLDBBarcode3: TRLDBBarcode;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel25: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw7: TRLDraw;
    RLDraw9: TRLDraw;
    RLLabel15: TRLLabel;
    RLLabel52: TRLLabel;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelArSedexOl: TFrmRelArSedexOl;

implementation

Uses DmDados;

{$R *.dfm}

procedure TFrmRelArSedexOl.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  var
    v_cep  : string;
    v_cep1 : string;
    v_cep2 : string;
Begin
  RlcidUf.Caption := Dm.SqlSdx3.Fields[8].AsString + '  ' +  Dm.SqlSdx3.Fields[9].AsString;
  RlcidUfb.Caption := Dm.SqlSdx3.Fields[8].AsString + '  ' +  Dm.SqlSdx3.Fields[9].AsString;
  v_cep := Dm.SqlSdx3.Fields[10].AsString;
  v_cep1 := copy(v_cep,1,5);
  v_cep2 := copy(v_cep,6,3);
  v_cep := v_cep1 + '-' + v_cep2;
  Rlcep.Caption := v_cep;
  Rlcepb.Caption := v_cep;
End;
End.
