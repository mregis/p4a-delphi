unit U_Acesso;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TFrmAcesso = class(TForm)
    ScrollBox1: TScrollBox;
    EdUsu: TEdit;
    EdSenha: TEdit;
    BtnEnt: TBitBtn;
    BtnSair: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Label3: TLabel;
    Image1: TImage;
    Shape1: TShape;
    Image3: TImage;
    Shape2: TShape;
    Label4: TLabel;
    procedure EdUsuKeyPress(Sender: TObject; var Key: Char);
    procedure ambientes(nivel:integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnEntClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    chave : integer;
    acesso_ok : boolean;
    conta : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAcesso: TFrmAcesso;

implementation

uses DmDados, U_Func, U_Principal;



{$R *.dfm}

procedure TFrmAcesso.ambientes(nivel:integer);
begin
  case nivel of
    0:
      begin
      end;
    1:
      begin
      end;
  end;
end;

procedure TFrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if acesso_ok = false then
    begin
      Application.Terminate;
    end;
  action:=cafree;
  FrmAcesso:=nil;
end;

procedure TFrmAcesso.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmAcesso.BtnEntClick(Sender: TObject);
var
  chave : integer;
begin
  chave := 128;
  acesso_ok := false;
  With Dm do
    begin
      sqlcga_acesso.Close;
      sqlcga_acesso.SQL.Clear;
      sqlcga_acesso.Sql.Add('SELECT * FROM cga_acesso ');
      sqlcga_acesso.Sql.Add('WHERE nome ILIKE :nome AND senha = :senha');
      sqlcga_acesso.Params[0].Value := trim(EdUsu.Text);
      sqlcga_acesso.Params[1].Value := Codificar(EdSenha.Text, chave);
      sqlcga_acesso.Open;
      if sqlcga_acesso.RecordCount = 1 then
        begin
          application.CreateForm(TFrmPrincipal, FrmPrincipal);
          FrmPrincipal.usuario := 'Usu�rio: ' + sqlcga_acessonome.Value + ' - ';
          FrmPrincipal.codusu := sqlcga_acessocodigo.Value;
          acesso_ok := true;
          FrmPrincipal.ambiente := sqlcga_acessonivel.AsInteger;
          FrmPrincipal.Show;
          FrmAcesso.Close;
        end
      else
        begin
          Application.MessageBox(PChar('Dados incorretos!'),
              'Acesso no Sistema ADS', MB_OK + MB_ICONWARNING);
          EdSenha.Clear;
          EdUsu.Clear;
          EdUsu.SetFocus;
        end;
    end;
end;

procedure TFrmAcesso.FormCreate(Sender: TObject);
begin
  chave:=128;
  conta:=0;
end;

procedure TFrmAcesso.FormShow(Sender: TObject);
begin
  EdUsu.SetFocus;
end;

procedure TFrmAcesso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=4100) or (Key=4101) then
    begin
      SelectNext(ActiveControl,True,True);
    end;
end;

procedure TFrmAcesso.EdSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    BtnEnt.Click;
end;

procedure TFrmAcesso.EdUsuKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    EdSenha.SetFocus;
end;

end.
