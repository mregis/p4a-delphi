unit U_FrmEtqMLD;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport;

type
  TFrmEtqMLD = class(TForm)
    RLEtqMLD: TRLReport;
    RLBand1: TRLBand;
    RLLbNom: TRLLabel;
    RLLbHbo: TRLLabel;
    RLLbEnd: TRLLabel;
    RLLbCid: TRLLabel;
    RLLbUfCep: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEtqMLD: TFrmEtqMLD;

implementation

uses DmDados, U_PesqImp, U_Func;

{$R *.dfm}

procedure TFrmEtqMLD.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLLbNom.Caption    := Dm.SqlRel.Fields[0].AsString +' '+Dm.SqlRel.Fields[1].AsString;
  RLLbHbo.Caption    := 'HPO-'+GeraNT(Dm.SqlRel.Fields[7].AsString,4);
  RllbEnd.Caption    := Dm.SqlRel.Fields[2].AsString;
  RllbCid.Caption    := Dm.SqlRel.Fields[3].AsString;
  RllbUfCep.Caption  := Dm.SqlRel.Fields[4].AsString+' - '+Dm.SqlRel.Fields[5].AsString +' - '+ Dm.SqlRel.Fields[6].AsString

end;

end.
