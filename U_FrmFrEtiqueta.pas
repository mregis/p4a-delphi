unit U_FrmFrEtiqueta;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport;

type
  TFrmFrEtiqueta = class(TForm)
    RLReport1: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    RlNome: TRLLabel;
    RlEndNumComp: TRLLabel;
    RlBaiMuni: TRLLabel;
    RlUfCep: TRLLabel;
    RlHPO: TRLLabel;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrEtiqueta: TFrmFrEtiqueta;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmFrEtiqueta.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RlNome.Caption       := Dm.SqlRel.Fields[0].AsString +' '+Dm.SqlRel.Fields[1].AsString;
  RlHPO.Caption        := 'HPO-'+GeraNT(Dm.SqlRel.Fields[7].AsString,4);
  RlEndNumComp.Caption := Dm.SqlRel.Fields[2].AsString;
  RlBaiMuni.Caption    := Dm.SqlRel.Fields[3].AsString;
  RlUfCep.Caption      := Dm.SqlRel.Fields[4].AsString+' - '+Dm.SqlRel.Fields[5].AsString +' - '+ Dm.SqlRel.Fields[6].AsString
end;

end.
