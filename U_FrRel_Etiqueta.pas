
unit U_FrRel_Etiqueta;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport, RLFilters, RLDraftFilter;

type
  TFrFrmImpEtiqueta = class(TForm)
    RLReport1: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDraftFilter1: TRLDraftFilter;
    RLEnd: TRLLabel;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrFrmImpEtiqueta: TFrFrmImpEtiqueta;

implementation

uses DB, Math, DmDados;

{$R *.dfm}

procedure TFrFrmImpEtiqueta.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLEnd.Caption := Dm.SqlCga44cg40_ende.value+', '+Dm.SqlCga44cg40_num.Value+' '+Dm.SqlCga44cg40_compl.Value;
end;

procedure TFrFrmImpEtiqueta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga44.Close;
  action := cafree;
end;

end.
