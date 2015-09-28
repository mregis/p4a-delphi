unit U_FrmFrCartao;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport;

type
  TFrmRelCartao = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLGroup1: TRLGroup;
    RLLabel1: TRLLabel;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RlUsuario: TRLLabel;
    RLBand4: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLDraw1: TRLDraw;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel7: TRLLabel;
    RLDraw2: TRLDraw;
    RLDBResult1: TRLDBResult;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText5: TRLDBText;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    saldo: integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelCartao: TFrmRelCartao;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmRelCartao.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
//  saldo := saldo + Dm.SqlRel
end;

end.
