unit u_mketiqueta;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport,Dmdados;

type
  Tfrmmketiqueta = class(TForm)
    Rlmketiqueta: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    RLSystemInfo1: TRLSystemInfo;
    rldbcodigo: TRLDBText;
    rldbempresa: TRLDBText;
    rldbendereco: TRLDBText;
    rldbcep: TRLDBText;
    rldbcomplem: TRLDBText;
    procedure RlmketiquetaAfterPrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmketiqueta: Tfrmmketiqueta;

implementation

uses un_frmprint;

{$R *.dfm}

procedure Tfrmmketiqueta.RlmketiquetaAfterPrint(Sender: TObject);
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

end.
