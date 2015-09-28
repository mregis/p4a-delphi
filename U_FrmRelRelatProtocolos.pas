unit U_FrmRelRelatProtocolos;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport, DmDados;

type
  TFrmRelProtocolos = class(TForm)
    Relatorio: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    Nome: TRLLabel;
    Endere: TRLLabel;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Contador,num_carac: Integer;
  public
    { Public declarations }
  end;

var
  FrmRelProtocolos: TFrmRelProtocolos;

implementation

{$R *.dfm}

procedure TFrmRelProtocolos.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin


  Nome.Caption         := IntToStr(Contador)+' - '+Dm.SqlRel.Fields[0].AsString;
  Endere.Caption       := Dm.SqlRel.Fields[1].AsString+' - '+Dm.SqlRel.Fields[2].AsString;

  Contador:=Contador+1;

end;

procedure TFrmRelProtocolos.FormCreate(Sender: TObject);
begin
  Contador:=1;
  num_carac:= 2;
  end;

end.
