unit U_FrRelFaturamentoToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrRelFaturamentoToken = class(TForm)
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
  FrRelFaturamentoToken: TFrRelFaturamentoToken;

implementation
 uses DmDados, DB, U_PesqImp;
{$R *.dfm}


procedure TFrRelFaturamentoToken.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  Rldata.caption  := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[1].AsDateTime);
  Rlqt.Caption    := inttostr(Dm.SqlRel.Fields[0].AsInteger);
  if FrmPesqImp.tag <>  35  then
    RlValor.Caption := 'R$ '+Dm.SqlRel.Fields[1].AsString;
  RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
end;



end.
