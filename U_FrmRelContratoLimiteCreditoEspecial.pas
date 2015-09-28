unit U_FrmRelContratoLimiteCreditoEspecial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DmDados, Menus;

type
  TFrmRelContratoLimiteCreditoEspecial = class(TForm)
    ReportContrato: TRLReport;
    RLBand1: TRLBand;
    RLImage2: TRLImage;
    LbData: TRLLabel;
    RLLabel8: TRLLabel;
    LbAgencia: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLMemo2: TRLMemo;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelContratoLimiteCreditoEspecial: TFrmRelContratoLimiteCreditoEspecial;

implementation

{$R *.dfm}

procedure TFrmRelContratoLimiteCreditoEspecial.RLBand1BeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  FrmRelContratoLimiteCreditoEspecial.LbData.Caption     := 'Osasco SP,'+FormatDateTime('dd',Date)+' de '+FormatDateTime('mmmm',Date)+' de '+FormatDateTime('yyyy',Date)+'.';
  FrmRelContratoLimiteCreditoEspecial.LbAgencia.Caption  := Dm.SqlRel.Fields[1].AsString+' - '+Dm.SqlRel.Fields[2].AsString;
end;

end.
