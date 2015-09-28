unit U_FrmFrBoleto;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport, RLBarcode, RLFilters, RLPDFFilter,
  RLXLSFilter, RLHTMLFilter, RLRichFilter, RLPreviewForm;

type
  TFrmFrBoleto = class(TForm)
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrBoleto: TFrmFrBoleto;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmFrBoleto.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
Const Num = '0123456789';
var
  codbarra : string;
  i : integer;
begin
  {RlAgCedD.Caption    := '0727/1720719/'+ GeraCodigo((GeraNT(Dm.SqlCga10cg10_codcli.AsString,13))+'07271720719',0);
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
  GeraNT(Dm.SqlCga10cg10_codcli.AsString,13),4)+'0000000000180007271720719'+copy(RlAgCedD.Caption,14,1)+(GeraNT(Dm.SqlCga10cg10_codcli.AsString,13));}
end;

procedure TFrmFrBoleto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

end.
