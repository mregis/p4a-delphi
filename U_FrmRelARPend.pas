unit U_FrmRelARPend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRelARPend = class(TForm)
    RLARPend: TRLReport;
    RLGrpDtCarga: TRLGroup;
    RLGrpDtCarga_SiglaObj: TRLGroup;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLBand2: TRLBand;
    RLLabel2: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    Envio: TRLLabel;
    RLDraw1: TRLDraw;
    RLBand3: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDraw2: TRLDraw;
    RLBand4: TRLBand;
    RLLabel5: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLBand5: TRLBand;
    RLLabel6: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLBand6: TRLBand;
    RLLabel7: TRLLabel;
    RLDBResult3: TRLDBResult;
    RLBand7: TRLBand;
    RLLabel8: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel9: TRLLabel;
    RLBand8: TRLBand;
    RLLabel10: TRLLabel;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelARPend: TFrmRelARPend;

implementation

uses DmDados;

{$R *.dfm}

end.
