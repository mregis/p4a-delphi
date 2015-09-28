unit U_FrRelFaturamentoEtica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrRelFaturamentoEtica = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RlTipoRelat: TRLLabel;
    RlPeriodo: TRLLabel;
    RlValorUnitario: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    Rldata: TRLLabel;
    Rlqt: TRLLabel;
    RlValor: TRLLabel;
    RLBand5: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RlValorFin: TRLDBResult;
    RLLabel5: TRLLabel;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrRelFaturamentoEtica: TFrRelFaturamentoEtica;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrRelFaturamentoEtica.RLBand3BeforePrint(Sender: TObject;
 var PrintIt: Boolean);
begin
  Rldata.caption  := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[2].AsDateTime);
  Rlqt.Caption    := inttostr(Dm.SqlRel.Fields[0].AsInteger);
  RlValor.Caption := 'R$ '+Dm.SqlRel.Fields[1].AsString;
  RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));

end;

end.
