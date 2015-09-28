unit U_CadBaixa;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TFrmCadBaixa = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    EdCodigo: TEdit;
    Panel9: TPanel;
    EdDescricao: TEdit;
    BtnFechar: TBitBtn;
    Btn_Salvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    EdCodBrad: TEdit;
    procedure limpa;
    procedure atualiza;
    procedure deletar;
    procedure alterar;
    procedure salvar;
    procedure BtnFecharClick(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
   cod : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadBaixa: TFrmCadBaixa;

implementation

uses DmDados, DB;

{$R *.dfm}

procedure TFrmCadBaixa.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadbaixa.salvar;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('insert into cga20 (cg20_codbaixa,cg20_descricao,cg20_codbrad) values (:codbaixa,:descricao,:cg20_codbrad)');
      SqlAux1.Params[0].Value := Trim(EdCodigo.Text);
      SqlAux1.Params[1].Value := Trim(EdDescricao.Text);
      SqlAux1.Params[2].Value := Trim(EdCodBrad.Text);
      try
        SqlAux1.ExecSql;
        application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
        SqlCga20.Refresh;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal, o programa levantou a seguinte excessão'+e.Message),'Ads',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
    end;
end;

procedure TFrmCadBaixa.Btn_SalvarClick(Sender: TObject);
begin
  if (Trim(EdCodigo.Text) = '') or (Trim(EdDescricao.Text) = '') then
    application.MessageBox('Preencha todos os campos','Ads',MB_OK+MB_ICONERROR)
  else
    begin
      salvar;
      limpa;
    end;
end;

procedure TFrmCadBaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga20.Close;
  action := cafree;
end;

procedure TFrmCadBaixa.alterar;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('update cga20 set cg20_codbaixa=:cg20_codbaixa,cg20_descricao=:cg20_descricao,cg20_codbrad=:cg20_codbrad where cg20_codbaixa=:cg20_codbaixaX');
      SqlAux1.Params[0].Value := Trim(EdCodigo.Text);
      SqlAux1.Params[1].Value := Trim(EdDescricao.Text);
      SqlAux1.Params[2].Value := Trim(EdCodBrad.Text);
      SqlAux1.Params[3].Value := SqlCga20cg20_codbaixa.Value;
      try
        SqlAux1.ExecSql;
        application.MessageBox('Alteração feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
        SqlCga20.Refresh;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal, o programa levantou a seguinte excessão'+e.Message),'Ads',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
    end;
end;

procedure TFrmCadBaixa.BtnAlterarClick(Sender: TObject);
begin
  if (Trim(EdCodigo.Text) = '') or (Trim(EdDescricao.Text) = '') then
    application.MessageBox('Preencha todos os campos','Ads',MB_OK+MB_ICONERROR)
  else
    if cod = strtoint(Dm.SqlCga20cg20_codbaixa.Value) then
      alterar
    else
      begin
        application.MessageBox('Selecione uma baixa para alteração','Ads',MB_OK+MB_ICONWARNING);
        limpa;
      end;
end;

procedure TFrmCadBaixa.deletar;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('delete from cga20  where cg20_codbaixa=:cg20_codbaixaX');
      SqlAux1.Params[0].Value := SqlCga20cg20_codbaixa.Value;
      try
        SqlAux1.ExecSql;
        application.MessageBox('Registro deletado com  feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
        SqlCga20.Refresh;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal, o programa levantou a seguinte excessão'+e.Message),'Ads',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
    end;
end;

procedure TFrmCadBaixa.BtnDeletarClick(Sender: TObject);
begin
  if cod = strtoint(Dm.SqlCga20cg20_codbaixa.Value) then
    deletar
  else
    application.MessageBox('Selecione uma baixa para exclusão','Ads',MB_OK+MB_ICONWARNING);
  limpa;
end;

procedure TFrmCadBaixa.atualiza;
begin
  EdCodigo.Text    := Dm.SqlCga20cg20_codbaixa.Value;
  EdDescricao.Text := Dm.SqlCga20cg20_descricao.Text;
  EdCodBrad.Text   := Dm.SqlCga20cg20_codbrad.Value;
  try
    cod              := Dm.SqlCga20cg20_codbaixa.AsInteger;
  except
  end;
end;

procedure TFrmCadBaixa.limpa;
begin
  EdCodigo.Clear;
  EdDescricao.Clear;
  EdCodBrad.Clear;
  cod := -1;
end;

procedure TFrmCadBaixa.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  atualiza;
end;

procedure TFrmCadBaixa.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualiza;
end;

end.
