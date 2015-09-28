unit U_PesqImpProdTk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Buttons;

type
  TFrmPesqImpProdTk = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    Panel9: TPanel;
    BtnFechar: TBitBtn;
    Btn_Salvar: TBitBtn;
    MkEdDtIni: TMaskEdit;
    MkEdDtFin: TMaskEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    EdAgIni: TEdit;
    EdAgFin: TEdit;
    RdGrpTipo: TRadioGroup;
    Bevel1: TBevel;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqImpProdTk: TFrmPesqImpProdTk;

implementation

{$R *.dfm}

procedure TFrmPesqImpProdTk.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesqImpProdTk.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=Cafree;
  dm.SqlAux1.Close;
  dm.SqlCga07.Close;

end;

end.
