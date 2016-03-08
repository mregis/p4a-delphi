unit U_FrmFrBoleto2;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLBarcode, RLReport;

type
  TFrmFrBoleto2 = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw1: TRLDraw;
    RLImage1: TRLImage;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel1: TRLLabel;
    RLLinhaDigitavel: TRLLabel;
    RLDraw4: TRLDraw;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLLabel6: TRLLabel;
    RLDraw7: TRLDraw;
    RLLabel7: TRLLabel;
    RLDraw8: TRLDraw;
    RLLabel8: TRLLabel;
    RLDraw9: TRLDraw;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLDBText4: TRLDBText;
    RLLabel11: TRLLabel;
    RLDraw10: TRLDraw;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLDraw11: TRLDraw;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLDraw12: TRLDraw;
    RLLabel17: TRLLabel;
    RLDraw13: TRLDraw;
    RLDraw14: TRLDraw;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RlValor: TRLLabel;
    RLLabel21: TRLLabel;
    RLDraw15: TRLDraw;
    RLLabel22: TRLLabel;
    RLDraw16: TRLDraw;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RlAgCedD: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLDraw17: TRLDraw;
    RLLabel28: TRLLabel;
    RLDraw18: TRLDraw;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RlNosNum: TRLLabel;
    RlNome: TRLLabel;
    RLDBText1: TRLDBText;
    RlCepCidEst: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel25: TRLLabel;
    RLDraw19: TRLDraw;
    RLLabel35: TRLLabel;
    RlNumDoc: TRLLabel;
    RLDraw20: TRLDraw;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLDraw21: TRLDraw;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLDtImp: TRLLabel;
    RLDtDig: TRLLabel;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw26: TRLDraw;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLDraw27: TRLDraw;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RlNome2: TRLLabel;
    RLDraw28: TRLDraw;
    RLDraw29: TRLDraw;
    RLLabel44: TRLLabel;
    RlAgCodCedD2: TRLLabel;
    RLLabel45: TRLLabel;
    RlNUmDoc2: TRLLabel;
    RLLabel47: TRLLabel;
    RlNosNUm2: TRLLabel;
    RLDraw30: TRLDraw;
    RLDraw31: TRLDraw;
    RLLabel49: TRLLabel;
    RLDraw32: TRLDraw;
    RLDraw33: TRLDraw;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLDraw34: TRLDraw;
    RLLabel53: TRLLabel;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw37: TRLDraw;
    RlCodBarra: TRLBarcode;
    RLLabel46: TRLLabel;
    RLLabel48: TRLLabel;
    RLDraw24: TRLDraw;
    RLBand2: TRLBand;
    RLImage2: TRLImage;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrBoleto2: TFrmFrBoleto2;

implementation

uses U_Func, DmDados;

{$R *.dfm}

procedure TFrmFrBoleto2.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
Const Num = '0123456789';
var
  codbarra : string;
begin
  RlAgCedD.Caption    := '0727/1720719/'+ GeraCodigo((GeraNT(Dm.SqlCga10cg10_codcli.AsString,13))+'07271720719',0);
  RlNosNum.Caption    := Dm.SqlCga10cg10_codcli.AsString;
//////////////////////////////////////// linha digitavel /////////////////////////////////////
  RLLinhaDigitavel.Caption := '35690.7271'+GeraCodigo('356907271',1)+'  '; // 1° bloco 10 digitos
  RLLinhaDigitavel.Caption := RLLinhaDigitavel.Caption +'72071.9'+copy(RlAgCedD.Caption,14,1)+copy(GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),1,3)+GeraCodigo('720719'+copy(RlAgCedD.Caption,14,1)+copy(GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),1,3),2);//2º bloco
  RLLinhaDigitavel.Caption := RLLinhaDigitavel.Caption +'  ' +copy((GeraNT(Dm.SqlCga10cg10_codcli.AsString,13)),4,5)+'.'+copy((GeraNT(Dm.SqlCga10cg10_codcli.AsString,13)),9,5)+GeraCodigo(copy(GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),4,10),3); //3° bloco
  RLLinhaDigitavel.Caption := RLLinhaDigitavel.Caption +' '+ GeraCodigo('35690000000000180007271720719'+copy(RlAgCedD.Caption,14,1)+GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),4)+' 00000000001800';//4°bloco
///////////////////////////////////////////////////////////////////////////////////////////////
  RlDtImp.Caption      := FormatDateTime('dd/mm/yyyy',date);
  RLDtDig.Caption      := formatdatetime('dd/mm/yyyy',Dm.SqlCga10cg10_dtdig.AsDateTime);
  RlNome.caption       := Dm.SqlCga10cg10_pnome.AsString +' '+Dm.SqlCga10cg10_snome.AsString+' - HPO-'+GeraNT(Dm.SqlCga10cg10_codcli.AsString,5);
  RlCepCidEst.Caption  := Dm.SqlCga10cg10_cep.AsString +' - '+Dm.SqlCga10cg10_cidade.AsString+' - '+Dm.SqlCga10cg10_uf.AsString;
  RlNumDoc.Caption     := GeraNT(Dm.SqlCga10cg10_codcli.AsString,13);
  RlNUmDoc2.Caption    := GeraNT(Dm.SqlCga10cg10_codcli.AsString,13);
  RlNosNUm2.Caption    := Dm.SqlCga10cg10_codcli.AsString;
  RlAgCodCedD2.Caption := RlAgCedD.Caption;
  RlNome2.Caption      := RlNome.Caption;
  codbarra := Trim(RLLinhaDigitavel.Caption);
  RlCodBarra.Caption := '3569'+GeraCodigo('35692400000000180007271720719'+copy(RlAgCedD.Caption,14,1)+
  GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),4)+'0000000000180007271720719'+copy(RlAgCedD.Caption,14,1)+(GeraNT(Dm.SqlCga10cg10_codcli.AsString,13));
end;

end.
