unit U_cadcliPrint;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport;

type
  TFrmCadcliPrint = class(TForm)
    RLReport1: TRLReport;
    RLDetailGrid2: TRLDetailGrid;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    rldbCep: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    procedure RLReport1AfterPrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadcliPrint: TFrmCadcliPrint;

implementation

uses DmDados, U_confirma;

{$R *.dfm}

procedure TFrmCadcliPrint.RLReport1AfterPrint(Sender: TObject);
begin
   frmconfirma.Close;
end;

end.
