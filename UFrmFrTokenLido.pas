unit UFrmFrTokenLido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRlTokenLidos = class(TForm)
    RLReport1: TRLReport;
    RLGroup1: TRLGroup;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel3: TRLLabel;
    RLDBText2: TRLDBText;
    RLGroup2: TRLGroup;
    RLBand2: TRLBand;
    RLLabel4: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel5: TRLLabel;
    RLDraw1: TRLDraw;
    RLBand3: TRLBand;
    RLDraw2: TRLDraw;
    RLDBText4: TRLDBText;
    RLBand4: TRLBand;
    RLLabel6: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLBand5: TRLBand;
    RLLabel7: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLBand6: TRLBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRlTokenLidos: TFrmRlTokenLidos;

implementation

uses DmDados;

{$R *.dfm}

end.
