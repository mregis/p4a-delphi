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
    Panel5: TPanel;
    Panel1: TPanel;
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
    senhadig : string;
    conta : integer;
    literal:integer;
    aux,senha : string;
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
  chr : char;
begin
  chr:=#39;
  chave := 128;
  acesso_ok := false;
  if conta <> 2 then
    begin
      With Dm do
        begin
          Dm.sqlcga_acesso.Close;
          Dm.sqlcga_acesso.SQL.Clear;
          Dm.sqlcga_acesso.Sql.Add('select * from cga_acesso where (nome=:nome) and (senha=:senha)');
          Dm.sqlcga_acesso.Params[0].Value := trim(EdUsu.Text);
          Dm.sqlcga_acesso.Params[1].Value := Codificar(EdSenha.Text,chave);
          Dm.sqlcga_acesso.Open;
          if Dm.sqlcga_acesso.RecordCount = 1 then
            begin
               application.CreateForm(TFrmPrincipal,FrmPrincipal);
               FrmPrincipal.usuario:='Usu�rio: '+Dm.sqlcga_acessonome.Value+' - ';
               FrmPrincipal.codusu  := Dm.sqlcga_acessocodigo.Value;
               acesso_ok := true;
               FrmPrincipal.ambiente := Dm.sqlcga_acessonivel.AsInteger;
               FrmAcesso.Close;
            end
          else
            begin
              conta:=conta+1;
              Application.MessageBox(PChar('Senha ou Us�ario incorreto voc� tem mais '+inttostr(3-conta)+' tentativas!!!'),'Entrada no Sistema',MB_OK+MB_ICONWARNING);
              EdSenha.Clear;
              EdUsu.Clear;
              EdUsu.SetFocus;
            end;
        end;
      end
    else
      begin
        Application.Terminate;
      end;
end;

procedure TFrmAcesso.FormCreate(Sender: TObject);
begin
  FrmPrincipal.FrmNome := FrmAcesso;
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
    BtnEnt.SetFocus;
end;

end.
