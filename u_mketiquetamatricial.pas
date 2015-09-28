unit u_mketiquetamatricial;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport, RLFilters, RLDraftFilter;

type
  TForm1 = class(TForm)
    RLReport1: TRLReport;
    RLDraftFilter1: TRLDraftFilter;
    RLDetailGrid1: TRLDetailGrid;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DmDados;

{$R *.dfm}

procedure TForm1.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
   self.RLLabel1.Caption:=dm.SqlCgaMakromkempresa.AsString;
end;

end.
