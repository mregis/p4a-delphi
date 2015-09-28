unit U_FrmRelSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLBarcode, RLReport;

type
  TFrmRelSedex = class(TForm)
    RLSedex: TRLReport;
    RLBand1: TRLBand;
    RLDBBarcode1: TRLDBBarcode;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelSedex: TFrmRelSedex;

implementation

uses DmDados;

{$R *.dfm}

end.
