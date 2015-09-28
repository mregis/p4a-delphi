unit u_mketiquetamat;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport, RLFilters, RLDraftFilter;

type
  TfrmMkEtiquetaMat = class(TForm)
    RLReport1: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMkEtiquetaMat: TfrmMkEtiquetaMat;

implementation

{$R *.dfm}

end.
