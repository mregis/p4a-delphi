unit U_FrmFrRelAgExtCons;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport;

type
  TFrmFrRelAgExtCons = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    Rldata: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLMemo1: TRLMemo;
    RLMemo2: TRLMemo;
    RLMemo3: TRLMemo;
    RLMemo4: TRLMemo;
    RLMemo5: TRLMemo;
    RlAg: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrRelAgExtCons: TFrmFrRelAgExtCons;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmFrRelAgExtCons.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RlData.Caption  := 'Matriz, '+formatdatetime('dd',date)+' de '+FormatDateTime('mmmm',date)+' de '+formatdatetime('yyyy',date);
//  RlAg.Caption := Qry_ConsCG21_CODAG.AsString+' / '+Qry_ConsCG21_AG.Value+' - '+Qry_ConsCG21_UF.Value;
  RlAg.Caption := Dm.SqlRel.Fields[0].AsString+' / '+Dm.SqlRel.Fields[1].AsString+' - '+Dm.SqlRel.Fields[2].AsString;
end;

end.
