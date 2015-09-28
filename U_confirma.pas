unit U_confirma;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFrmconfirma = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmconfirma: TFrmconfirma;

implementation

uses U_cadcliPrint;

{$R *.dfm}

procedure TFrmconfirma.BitBtn2Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmconfirma.BitBtn1Click(Sender: TObject);
begin
      Application.CreateForm(TFrmCadcliPrint,FrmCadcliPrint);
      FrmCadcliPrint.RLReport1.PreviewModal;
      FrmCadcliPrint.RLReport1.Destroy;
end;

procedure TFrmconfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  FrmConfirma := nil;
end;

end.
