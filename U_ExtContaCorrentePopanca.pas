unit FrmExtContaCorrentePopanca;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, DBCtrls;

type
  TFrmExtContaCorrentePoupanca = class(TForm)
    ScrollBox1: TScrollBox;
    DbLkBaixa: TDBLookupComboBox;
    EdCaixa: TEdit;
    EdQt: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EdRemessa: TEdit;
    Panel4: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtContaCorrentePoupanca: TFrmExtContaCorrentePoupanca;

implementation

uses DmDados;

{$R *.dfm}

end.
