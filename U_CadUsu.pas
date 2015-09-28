unit U_CadUsu;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, Mask, ExtCtrls;

type
  TFrmCadUsu = class(TForm)
    ScrollBox1: TScrollBox;
    EdUsu: TEdit;
    MkedSenha1: TEdit;
    MkedSenha2: TEdit;
    CboNivel: TComboBox;
    BtnIncluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnSair: TBitBtn;
    Bevel1: TBevel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure Atualiza;
    procedure FormCreate(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure limpa;
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MkedSenha2Exit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
  private
    senha1,senha2,aux: string;
    chave,literal : integer;
    codid : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadUsu: TFrmCadUsu;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmCadUsu.limpa;
begin
  EdUsu.Clear;
  MkedSenha1.Clear;
  MkedSenha2.Clear;
  codid := 999999;
  EdUsu.SetFocus;
end;

procedure TFrmCadUsu.FormCreate(Sender: TObject);
begin
  chave:=128;
end;

procedure TFrmCadUsu.BtnSairClick(Sender: TObject);
begin
  FrmCadUsu.Close;
end;

procedure TFrmCadUsu.BtnSalvarClick(Sender: TObject);
begin
  if (senha1 = senha2) and (EdUsu.Text <> '') then
    try
       begin
         Dm.SqlAux1.Close;
         Dm.SqlAux1.Sql.Clear;
         Dm.SqlAux1.Sql.Add('insert into cga_acesso (nome,nivel,senha)values(:nome,:nivel,:senha)');
         Dm.SqlAux1.Params[0].Value:= Trim(EdUsu.Text);
         Dm.SqlAux1.Params[1].Value:= CboNivel.ItemIndex;
         Dm.SqlAux1.Params[2].Value:= Codificar(MkedSenha1.Text,chave);
         Dm.SqlAux1.ExecSql;
         Dm.sqlcga_acesso.Refresh;
         limpa;
         Application.MessageBox('Usuário incluido com exíto!!!','Inclusão',MB_OK+MB_ICONINFORMATION);
        end;
     except on e: exception do
        Application.MessageBox(PChar('Erro!!!'+#13+e.Message),'Inclusão',MB_OK+MB_ICONERROR);
     end;
end;

procedure TFrmCadUsu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=4100) or (Key=4101) then
    begin
      SelectNext(ActiveControl,True,True);
    end;
end;

procedure TFrmCadUsu.BtnAlterarClick(Sender: TObject);
begin
 try
    if (senha1 = senha2) and (EdUsu.Text <> '') and (MkedSenha1.Text <> '') then
       begin
         if codid = Dm.sqlcga_acessocodigo.AsInteger then
           begin
             Dm.SqlAux1.Close;
             Dm.SqlAux1.Sql.Clear;
             Dm.SqlAux1.Sql.Add('update cga_acesso set nome=:nome,nivel=:nivel,senha=:senha where codigo=:codigo');
             Dm.SqlAux1.Params[0].Value:= Trim(EdUsu.Text);
             Dm.SqlAux1.Params[1].Value:= CboNivel.ItemIndex;
             Dm.SqlAux1.Params[2].Value:= Codificar(MkedSenha1.Text,chave);
             Dm.SqlAux1.Params[3].Value:= Dm.sqlcga_acessoCodigo.value;
             Dm.SqlAux1.ExecSql;
             Dm.sqlcga_acesso.Refresh;
             Application.MessageBox('Alteração concluida com exíto!!!','Alteração',MB_OK+MB_ICONINFORMATION);
             limpa;
           end
         else
           begin
             Application.MessageBox('Selecione um Usuario, depois altere o usuario','Alterar',MB_OK+MB_ICONWARNING);
           end;
       end
       else
       begin
         Application.MessageBox('Você não pode alterar este registro'+#10+'Possiveis causas'+#10+#10+'O Campo Usuário pode estar em branco'+#10+'Senha e Confirmação estão diferentes ou em Branco','Alteração',MB_OK+MB_ICONWARNING);
       end;
      except on e: exception do
        Application.MessageBox(PChar('Erro!!!'+#13+e.Message),'Inclusão',MB_OK+MB_ICONERROR);
     end
end;

procedure TFrmCadUsu.BtnDeletarClick(Sender: TObject);
begin
  if codid = Dm.sqlcga_acessocodigo.AsInteger then
    begin
      try
        begin
         Dm.SqlAux1.Close;
         Dm.SqlAux1.Sql.Clear;
         Dm.SqlAux1.Sql.Add('delete from cga_acesso where codigo=:codigo');
         Dm.SqlAux1.Params[0].Value:= Dm.sqlcga_acessocodigo.value;
         Dm.SqlAux1.ExecSql;
         Dm.sqlcga_acesso.Refresh;
         Application.MessageBox('Exclusão concluída com exíto!!!','Alteração',MB_OK+MB_ICONINFORMATION);
         limpa;
       end;
      except on e: exception do
        Application.MessageBox(PChar('Erro!!!'+#13+e.Message),'Inclusão',MB_OK+MB_ICONERROR);
      end;
    end
  else
    begin
      Application.MessageBox('Selecione um Usuario, depois delete o usuario','Deletar',MB_OK+MB_ICONWARNING);
    end;
end;

procedure TFrmCadUsu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.sqlcga_acesso.Close;
  Action:=cafree;
  FrmCadUsu:=nil;
end;

procedure TFrmCadUsu.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  atualiza;
end;

procedure TFrmCadUsu.MkedSenha2Exit(Sender: TObject);
begin
  if senha1 <> senha2 then
    begin
      Application.MessageBox('As senhas não são iguais','Cartorio',MB_OK+MB_ICONINFORMATION);
      SENHA2:='';
      MkedSenha2.Clear;
      MkedSenha2.SetFocus;
    end;
end;

procedure TFrmCadUsu.Atualiza;
begin
  EdUsu.Text         := Dm.sqlcga_acessonome.Value;
  CboNivel.ItemIndex := Dm.sqlcga_acessonivel.Value;
  codid              := Dm.sqlcga_acessocodigo.AsInteger;
end;

procedure TFrmCadUsu.BtnIncluirClick(Sender: TObject);
begin
  limpa;
end;

end.
