unit U_FrmRlResumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRlResumo = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLBand2: TRLBand;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLLabel2: TRLLabel;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw7: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw12: TRLDraw;
    RLDraw13: TRLDraw;
    RLDraw14: TRLDraw;
    RLDraw15: TRLDraw;
    RLDraw16: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw28: TRLDraw;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLBand3: TRLBand;
    RLDraw29: TRLDraw;
    RLDraw30: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw32: TRLDraw;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw38: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw40: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw43: TRLDraw;
    RLLabel3: TRLLabel;
    RLDraw44: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw46: TRLDraw;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel13: TRLLabel;
    RLDBText14: TRLDBText;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    RLDBResult13: TRLDBResult;
    RLBand4: TRLBand;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLDraw47: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw50: TRLDraw;
    RLDraw51: TRLDraw;
    RLDraw52: TRLDraw;
    RLDraw53: TRLDraw;
    RLDraw54: TRLDraw;
    RLDraw55: TRLDraw;
    RLDraw56: TRLDraw;
    RLDraw57: TRLDraw;
    RLDraw58: TRLDraw;
    RLDraw59: TRLDraw;
    RLDraw60: TRLDraw;
    RLDraw61: TRLDraw;
    RLDraw62: TRLDraw;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLDraw63: TRLDraw;
    RLDraw64: TRLDraw;
    RLDraw65: TRLDraw;
    RLDraw66: TRLDraw;
    RLDraw67: TRLDraw;
    RLDraw68: TRLDraw;
    RLDraw69: TRLDraw;
    RLDraw70: TRLDraw;
    RLDraw71: TRLDraw;
    RLDraw72: TRLDraw;
    RLDraw73: TRLDraw;
    RLDraw74: TRLDraw;
    RLDraw75: TRLDraw;
    RLDraw76: TRLDraw;
    RLDraw77: TRLDraw;
    RLDraw78: TRLDraw;
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
    RLDraw79: TRLDraw;
    RLDraw80: TRLDraw;
    RLDraw81: TRLDraw;
    RLDraw82: TRLDraw;
    RLDraw83: TRLDraw;
    RLDraw84: TRLDraw;
    RLDraw85: TRLDraw;
    RLDraw86: TRLDraw;
    RLDraw87: TRLDraw;
    RLDraw88: TRLDraw;
    RLDraw89: TRLDraw;
    RLDraw90: TRLDraw;
    RLDraw91: TRLDraw;
    RLDraw93: TRLDraw;
    RLDraw94: TRLDraw;
    RLDraw95: TRLDraw;
    RLDraw96: TRLDraw;
    RLDraw97: TRLDraw;
    RLDraw98: TRLDraw;
    RLDraw99: TRLDraw;
    RLDraw100: TRLDraw;
    RLDraw101: TRLDraw;
    RLDraw102: TRLDraw;
    RLDBText15: TRLDBText;
    RLDBResult14: TRLDBResult;
    RLLabel60: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel63: TRLLabel;
    RLDraw92: TRLDraw;
    RLDraw103: TRLDraw;
    RLDraw104: TRLDraw;
    RLDraw105: TRLDraw;
    RLDraw106: TRLDraw;
    RLDraw107: TRLDraw;
    RLLabel64: TRLLabel;
    RLDBText16: TRLDBText;
    RLDBResult15: TRLDBResult;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRlResumo: TFrmRlResumo;

implementation

uses DmDados, U_PesqImp;

{$R *.dfm}

procedure TFrmRlResumo.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
RLLabel47.Caption :=  inttostr(RLDBResult1.Value + strtoint(rllabel33.Caption));
RLLabel48.Caption :=  inttostr(RLDBResult2.Value + strtoint(rllabel34.Caption));
RLLabel49.Caption :=  inttostr(RLDBResult3.Value + strtoint(rllabel35.Caption));
RLLabel50.Caption :=  inttostr(RLDBResult4.Value + strtoint(rllabel36.Caption));
RLLabel51.Caption :=  inttostr(RLDBResult5.Value + strtoint(rllabel37.Caption));
RLLabel52.Caption :=  inttostr(RLDBResult6.Value + strtoint(rllabel38.Caption));
RLLabel53.Caption :=  inttostr(RLDBResult7.Value + strtoint(rllabel39.Caption));
RLLabel54.Caption :=  inttostr(RLDBResult8.Value + strtoint(rllabel40.Caption));
RLLabel55.Caption :=  inttostr(RLDBResult9.Value + strtoint(rllabel41.Caption));
RLLabel56.Caption :=  inttostr(RLDBResult10.Value + strtoint(rllabel42.Caption));
RLLabel57.Caption :=  inttostr(RLDBResult11.Value + strtoint(rllabel43.Caption));
RLLabel58.Caption :=  inttostr(RLDBResult12.Value + strtoint(rllabel44.Caption));
RLLabel59.Caption :=  inttostr(RLDBResult13.Value+ strtoint(rllabel45.Caption));
RLLabel62.Caption :=  inttostr(RLDBResult14.Value+ strtoint(rllabel61.Caption));
RLLabel67.Caption :=  inttostr(RLDBResult15.Value+ strtoint(rllabel66.Caption));


end;

end.
