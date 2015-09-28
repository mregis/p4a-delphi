unit U_FrmRlNLido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRlNLido = class(TForm)
    RLReport1: TRLReport;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLLabel3: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLGroup1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRlNLido: TFrmRlNLido;

implementation

uses DmDados, U_FrmCadNLido;

{$R *.dfm}

procedure TFrmRlNLido.RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
RLLabel2.Caption  :=  formatdatetime('dd/mm/yyyy',date) + ' às ' + formatdatetime('hh:mm',time);
end;

procedure TFrmRlNLido.RLGroup1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
{  RLDBText1.DataField :=  '"Data"';
  RLDBText2.DataField :=  '''Serviço''';
  RLDBText3.DataField :=  '''Qtde''';}
end;

end.
