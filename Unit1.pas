unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport, RLFilters, RLDraftFilter;

type
  TForm1 = class(TForm)
    RLReport1: TRLReport;
    RLDraftFilter1: TRLDraftFilter;
    RLDetailGrid1: TRLDetailGrid;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLSystemInfo1: TRLSystemInfo;
    RLDBText3: TRLDBText;
    procedure RLReport1AfterPrint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DmDados, un_frmprint;

{$R *.dfm}

procedure TForm1.RLReport1AfterPrint(Sender: TObject);
begin
   With Dmdados.Dm do
    begin
     SqlCga111Check.Close;
     SqlCga111Check.Sql.Clear;
     SqlCga111Check.Sql.Add('insert into cga111check (chloja,chdivisao,chedicao) values (:chloja,:chdivisao,:chedicao)');
     SqlCga111Check.Params[0].Value := frmMkprint.dblcloja.KeyValue;
     SqlCga111Check.Params[1].Value := frmMkprint.dblcdivisao.KeyValue;
     SqlCga111Check.Params[2].Value := frmMkprint.dblcedicao.KeyValue;
     sqlcga111check.ExecSql;
   end
end;
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  Form1:=nil;
end;

end.
