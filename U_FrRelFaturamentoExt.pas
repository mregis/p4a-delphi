unit U_FrRelFaturamentoExt;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport;

type
  TFrmFrRelFaturamentoExt = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RlTipoRelat: TRLLabel;
    RlPeriodo: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    Rldata: TRLLabel;
    Rlqt: TRLLabel;
    RLBand5: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RlValorFin: TRLDBResult;
    RlValor: TRLLabel;
    RLLabel5: TRLLabel;
    RlValorUnitario: TRLLabel;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrRelFaturamentoExt: TFrmFrRelFaturamentoExt;

implementation

uses DmDados, DB;

{$R *.dfm}

procedure TFrmFrRelFaturamentoExt.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  Rldata.caption  := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[2].AsDateTime);
  Rlqt.Caption    := inttostr(Dm.SqlRel.Fields[0].AsInteger);
  RlValor.Caption := 'R$ '+Dm.SqlRel.Fields[1].AsString;
  RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
end;

end.
